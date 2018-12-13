library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity processor is
	generic (
		code 	: string
	);	
	port(
		-- Essential signals
		init			: in std_logic;				-- Set pc to pc_init_data and reset register file
		pc_init_data		: in std_logic_vector (31 downto 0);	-- Initial value for program counter
		clk			: in std_logic;

		-- Inspection signals

		-- Flow control
		pc_ins			: out std_logic_vector (31 downto 0);
		instruction_ins		: out std_logic_vector (31 downto 0);
		take_branch_ins		: out std_logic;
			
		-- Control signals
		alu_op_ins		: out std_logic_vector (5 downto 0);
		mem_to_reg_ins		: out std_logic;
		reg_wrt_ins		: out std_logic;
		mem_wrt_ins		: out std_logic;
		branch_ins		: out std_logic;
		sign_extend_ins		: out std_logic;	-- sign extend = 1, zero extend = 0
		use_imm_ins		: out std_logic;	-- use immediate = 1, use registers = 0
		use_sa_ins		: out std_logic;	-- use shamt = 1
	
		-- ALU
	 	immediate_extended_ins	: out std_logic_vector (31 downto 0);
		shamt_extended_ins	: out std_logic_vector (31 downto 0);
		alu_b_reg_imm_ins	: out std_logic_vector (31 downto 0);
		alu_a_ins		: out std_logic_vector (31 downto 0);
		alu_b_ins		: out std_logic_vector (31 downto 0);
		alu_r_ins		: out std_logic_vector (31 downto 0);
		of_flag_ins		: out std_logic;
		z_flag_ins		: out std_logic;
	
		-- Register
		rs_ins			: out std_logic_vector (4 downto 0); 
		rt_ins			: out std_logic_vector (4 downto 0); 
		rd_ins			: out std_logic_vector (4 downto 0);
		reg_bus_a_ins		: out std_logic_vector (31 downto 0);
		reg_bus_b_ins		: out std_logic_vector (31 downto 0);
		reg_bus_wrt_ins		: out std_logic_vector (31 downto 0);
		
		-- Data Memory
		manual_mem_inspect	: in std_logic;
		manual_mem_inspect_addr	: in std_logic_vector (31 downto 0);
		data_mem_out_ins	: out std_logic_vector (31 downto 0)
		);
end processor;
	
architecture processor_logic of processor is
	-- Flow control
	signal pc 			: std_logic_vector (31 downto 0);
	signal instruction		: std_logic_vector (31 downto 0);
	signal take_branch		: std_logic;
	signal stall			: std_logic;
		
	-- Control signals
	signal alu_op			: std_logic_vector (5 downto 0);
	signal mem_to_reg		: std_logic;
	signal reg_wrt			: std_logic;
	signal mem_wrt			: std_logic;
	signal branch			: std_logic;
	signal sign_extend		: std_logic;	-- sign extend = 1, zero extend = 0
	signal use_imm			: std_logic;	-- use immediate = 1, use registers = 0
	signal use_sa			: std_logic;	-- use shamt = 1

	-- ALU
	signal immediate_extended	: std_logic_vector (31 downto 0);
	signal shamt_extended		: std_logic_vector (31 downto 0);
	signal alu_b_reg_imm		: std_logic_vector (31 downto 0);
	signal alu_a			: std_logic_vector (31 downto 0);
	signal alu_b			: std_logic_vector (31 downto 0);
	signal alu_r			: std_logic_vector (31 downto 0);
	signal of_flag			: std_logic;
	signal z_flag			: std_logic;
	signal alu_a_mem_wb		: std_logic_vector (31 downto 0);
	signal alu_a_valid		: std_logic_vector (31 downto 0);
	signal alu_b_mem_wb		: std_logic_vector (31 downto 0);
	signal alu_b_valid		: std_logic_vector (31 downto 0);

	-- Register
	signal rs			: std_logic_vector (4 downto 0); 
	signal rt			: std_logic_vector (4 downto 0); 
	signal rd			: std_logic_vector (4 downto 0);
	signal reg_bus_a		: std_logic_vector (31 downto 0);
	signal reg_bus_b		: std_logic_vector (31 downto 0);
	signal reg_bus_wrt		: std_logic_vector (31 downto 0);
	
	-- Data Memory
	signal data_mem_read		: std_logic;
	signal data_mem_addr		: std_logic_vector (31 downto 0);
	signal data_mem_out		: std_logic_vector (31 downto 0);
	signal data_mem_wrt		: std_logic;

	-- Timing
	signal clk_inv			: std_logic;
	
	-- Stage Registers
		-- if_id
	signal pc_if_id			: std_logic_vector(31 downto 0);
	signal instruction_if_id	: std_logic_vector(31 downto 0);
		-- id_ex
	signal reg_bus_a_id_ex		: std_logic_vector(31 downto 0);
	signal reg_bus_b_id_ex		: std_logic_vector(31 downto 0);
	signal immediate_extended_id_ex	: std_logic_vector(31 downto 0);
	signal shamt_extended_id_ex	: std_logic_vector(31 downto 0);
	signal alu_op_id_ex		: std_logic_vector(5 downto 0);	
	signal instruction_id_ex	: std_logic_vector(31 downto 0);
	signal pc_id_ex			: std_logic_vector(31 downto 0);
	signal mem_to_reg_id_ex		: std_logic;
	signal reg_wrt_id_ex		: std_logic;
	signal mem_wrt_id_ex		: std_logic;
	signal branch_id_ex		: std_logic;
	signal sign_extend_id_ex	: std_logic;
	signal use_imm_id_ex		: std_logic;
	signal use_sa_id_ex		: std_logic;
	signal stall_id_ex		: std_logic;
	signal rs_id_ex			: std_logic_vector(4 downto 0);
	signal rt_id_ex			: std_logic_vector(4 downto 0);
	signal rd_id_ex			: std_logic_vector(4 downto 0);
		--ex_mem
	signal alu_r_ex_mem		: std_logic_vector(31 downto 0);
	signal reg_bus_b_ex_mem		: std_logic_vector(31 downto 0);
	signal alu_of_ex_mem		: std_logic;
	signal alu_z_ex_mem		: std_logic;
	signal mem_to_reg_ex_mem	: std_logic;
	signal reg_wrt_ex_mem		: std_logic;
	signal mem_wrt_ex_mem		: std_logic;
	signal branch_ex_mem		: std_logic;
	signal sign_extend_ex_mem	: std_logic;
	signal use_imm_ex_mem		: std_logic;
	signal use_sa_ex_mem		: std_logic;
	signal stall_ex_mem		: std_logic;
	signal rs_ex_mem		: std_logic_vector(4 downto 0);
	signal rt_ex_mem		: std_logic_vector(4 downto 0);
	signal rd_ex_mem		: std_logic_vector(4 downto 0);
		--mem_wb
	signal alu_r_mem_wb		: std_logic_vector(31 downto 0);
	signal data_mem_out_mem_wb	: std_logic_vector(31 downto 0);
	signal mem_to_reg_mem_wb	: std_logic;
	signal sign_extend_mem_wb	: std_logic;
	signal reg_wrt_mem_wb		: std_logic;
	signal mem_wrt_mem_wb		: std_logic;
	signal branch_mem_wb		: std_logic;
	signal use_imm_mem_wb		: std_logic;
	signal use_sa_mem_wb		: std_logic;
	signal stall_mem_wb		: std_logic;
	signal rs_mem_wb		: std_logic_vector(4 downto 0);
	signal rt_mem_wb		: std_logic_vector(4 downto 0);
	signal rd_mem_wb		: std_logic_vector(4 downto 0);

	-- Forwarding
	signal forward_rs		: std_logic_vector (1 downto 0);
	signal forward_rt		: std_logic_vector (1 downto 0);

	-- Stall Calculation
	signal branch_or_load		: std_logic;
	signal last_branch_and_stall	: std_logic;
	signal stall_logic		: std_logic;

	-- Squashing
	signal last_inst_branch_or_load	: std_logic;
	signal squash			: std_logic;
	signal squash_inv		: std_logic;
	signal reg_wrt_decoder		: std_logic;
	signal mem_wrt_decoder		: std_logic;
begin

	-- Debugging signals for simulation
	-- Flow control
	pc_ins			<=	pc;
	instruction_ins		<=	instruction;
	take_branch_ins		<=	take_branch;
		
	-- Control signals
	alu_op_ins		<=	alu_op;
	mem_to_reg_ins		<=	mem_to_reg;
	reg_wrt_ins		<=	reg_wrt;
	mem_wrt_ins		<=	mem_wrt;
	branch_ins		<=	branch;
	sign_extend_ins		<=	sign_extend;
	use_imm_ins		<=	use_imm;
	use_sa_ins		<=	use_sa;

	-- ALU;
 	immediate_extended_ins	<=	immediate_extended;
	shamt_extended_ins	<=	shamt_extended;
	alu_b_reg_imm_ins	<=	alu_b_reg_imm;
	alu_a_ins		<=	alu_a;
	alu_b_ins		<=	alu_b;
	alu_r_ins		<=	alu_r;
	of_flag_ins		<=	of_flag;
	z_flag_ins		<=	z_flag;

	-- Register
	rs_ins			<=	rs;
	rt_ins			<=	rt;
	rd_ins			<=	rd;
	reg_bus_a_ins		<=	reg_bus_a;
	reg_bus_b_ins		<=	reg_bus_b;
	reg_bus_wrt_ins		<=	reg_bus_wrt;
	
	-- Data Memory
	data_mem_out_ins	<=	data_mem_out;

	-- STAGE 1: IF

	-- Fetch instruction from instruction memory
	instruction_mem	:	sram
	generic map (
		mem_file => code
	)
	port map (
		cs	=>	'1',
		oe	=>	'1',	-- Always output mode
		we	=>	'0',	-- No modification
		addr	=>	pc,
		din	=>	conv_std_logic_vector(0, 32),
		dout	=>	instruction
	);
	
	-- Obtain current pc and advance pc the end of clock cycle
	pc_control	:	pc_controller
	port map(
		pc_init			=>	init,
		pc_init_data		=>	pc_init_data,
		clk			=>	clk,
		immediate_extended	=>	immediate_extended,
		take_branch		=>	take_branch,
		stall			=>	stall_logic,
		pc			=>	pc
	);

	if_id_reg : if_id_register
	port map (
		clk		=>	clk,
		reset		=>	init,
		input_pc	=>	pc,
		input_inst	=>	instruction,
		output_pc	=>	pc_if_id,
		output_inst	=>	instruction_if_id
	);
	
	
	-- STAGE 2: ID/REG

	-- Decode instruction and set control signals
	instruction_decoding	: instruction_decoder
	port map(
		instruction	=>	instruction_if_id,
		rs		=>	rs,
		rt		=>	rt,
		rd		=>	rd,
		alu_op		=>	alu_op,
		mem_to_reg	=>	mem_to_reg,	
		reg_wrt		=>	reg_wrt_decoder,	-- will be modified by squash logic before passing to id_ex reg
		mem_wrt		=>	mem_wrt_decoder,	-- will be modified by squash logic before passing to id_ex reg
		branch		=>	branch,
		sign_extend	=>	sign_extend,
		use_imm		=>	use_imm,
		use_sa		=>	use_sa
	);
	
	-- Stall if necessary for branch and load instructions	
	-- if branch or load
	--	stall = 1
	-- else if stall = 1 and last instruction was branch
	--	stall = 1
	-- else
	--	stall = 0

	branch_or_load_or	:	or_gate
	port map (
		x	=>	branch,
		y	=>	mem_to_reg,
		z	=>	branch_or_load
	);

	last_branch_and_stall_and	:	and_gate
	port map (
		x	=>	branch_id_ex,
		y	=>	stall,
		z	=>	last_branch_and_stall
	);

	stall_or	:	or_gate
	port map (
		x	=>	branch_or_load,
		y	=>	last_branch_and_stall,
		z	=>	stall_logic
	);

	stall_ff	:	dffr_a 
	port map (
		clk	=>	clk,
		arst	=>	init,
		aload	=>	'0',
		adata	=>	'0',
		enable	=>	'1',
		d	=>	stall_logic,
		q	=>	stall
	);

	-- Squashing logic

	-- if (last_instruction = branch or load)
	-- 	squash = 1
	-- else if second_to_last instruction = branch
	-- 	squash = 1
	-- else
	--	squash = 0

	--

	-- if last instruction is branch or load
	last_inst_branch_or_load_or	:	or_gate
	port map (
		x	=>	branch_id_ex,		-- last instruction branch
		y	=>	mem_to_reg_id_ex,	-- last instruction load
		z	=>	last_inst_branch_or_load
	);

	-- squash or no squash
	squash_or	:	or_gate
	port map (
		x	=>	last_inst_branch_or_load,
		y	=>	branch_ex_mem,		-- second to last instruction is branch
		z	=>	squash
	);

	squash_inv_not	:	not_gate
	port map (
		x	=>	squash,
		z	=>	squash_inv
	);

	-- reg_wrt = reg_wrt_decoder and not squash
	reg_wrt_and	:	and_gate
	port map (
		x	=>	reg_wrt_decoder,
		y	=>	squash_inv,
		z	=>	reg_wrt
	);

	-- mem_wrt = mem_wrt_decoder and not squash
	mem_wrt_and	:	and_gate
	port map (
		x	=>	mem_wrt_decoder,
		y	=>	squash_inv,
		z	=>	mem_wrt
	);

	-- Read and write to register file
	register_file_inst : register_file
	port map (
		init		=>	init,
		reg_wr		=>	reg_wrt_mem_wb,
		reg_dst		=>	rd_mem_wb,
		rs		=>	rs,		 
		rt		=>	rt, 		
		busW		=>	reg_bus_wrt,
		clk		=>	clk_inv,		
		busA		=>	reg_bus_a,		
		busB		=>	reg_bus_b
	);
	
	-- Extend immediate for addi, load/store or branch instructions
	immediate_extender	: extender
	port map (
		sign	=>	sign_extend,
		input	=>	instruction_if_id(15 downto 0),
		output	=>	immediate_extended
	);
	
	-- Extend (zero extend) shamt for sll 
	sa_16_gen_0 : for i in 0 to 4 generate
		shamt_extended (i) <= instruction_if_id(6+i);
	end generate;
	sa_16_gen : for i in 5 to 31 generate
		shamt_extended (i) <= '0';
	end generate;

	id_ex_reg : id_ex_register
	port map (
		clk			=>	clk,
		reset			=>	init,
		input_pc		=>	pc_if_id,
		input_a			=>	reg_bus_a,
		input_b			=>	reg_bus_b,
		input_immediate		=>	immediate_extended,
		input_shamt_extended	=>	shamt_extended,
		input_instruction	=>	instruction_if_id,
		input_alu_op		=>	alu_op,
		output_pc		=>	pc_id_ex,
		output_a		=>	reg_bus_a_id_ex,
		output_b		=>	reg_bus_b_id_ex,
		output_immediate	=>	immediate_extended_id_ex,
		output_shamt_extended	=>	shamt_extended_id_ex,
		output_instruction	=>	instruction_id_ex,
		output_alu_op		=>	alu_op_id_ex
	);

	control_id_ex : control_signals
	port map (
		clk			=>	clk,
		reset			=>	init,
		in_mem_to_reg		=>	mem_to_reg,
		in_reg_wrt		=>	reg_wrt,
		in_mem_wrt		=>	mem_wrt,
		in_branch		=>	branch,
		in_sign_extend		=>	sign_extend,
		in_use_imm		=>	use_imm,
		in_use_sa		=>	use_sa,
		in_stall		=>	stall,
		in_rs			=>	rs,
		in_rt			=>	rt,
		in_rd			=>	rd,
		out_mem_to_reg		=>	mem_to_reg_id_ex,
		out_reg_wrt		=>	reg_wrt_id_ex,
		out_mem_wrt		=>	mem_wrt_id_ex,
		out_branch		=>	branch_id_ex,
		out_sign_extend		=>	sign_extend_id_ex,
		out_use_imm		=>	use_imm_id_ex,
		out_use_sa		=>	use_sa_id_ex,
		out_stall		=>	stall_id_ex,
		out_rs			=>	rs_id_ex,
		out_rt			=>	rt_id_ex,
		out_rd			=>	rd_id_ex
	);

	-- STAGE 3: EX

	-- Adjust alu first source based on if sll (rd=rt<<sa) instruction or not
	alu_a_mux	:	mux_32
	port map (
		sel	=>	use_sa_id_ex,
		src0	=>	reg_bus_a_id_ex,
		src1	=>	reg_bus_b_id_ex,
		z	=>	alu_a
	);
	
	-- Adjust alu second source based on if addi, load/store or branch instructions or not	 
	alu_b_reg_imm_mux	:	mux_32
	port map (
		sel	=>	use_imm_id_ex,
		src0	=>	reg_bus_b_id_ex,
		src1	=>	immediate_extended_id_ex,
		z	=>	alu_b_reg_imm
	);
	alu_b_mux	:	mux_32
	port map (
		sel	=>	use_sa_id_ex,
		src0	=>	alu_b_reg_imm,
		src1	=>	shamt_extended_id_ex,
		z	=>	alu_b
	);

	-- Forward from previous instructions
	forwarding_unit_inst : forwarding_unit
	port map (
		rs_ID_EX		=>	rs_id_ex,
		rt_ID_EX		=>	rt_id_ex,
		use_imm_ID_EX		=>	use_imm_id_ex,	
		use_sa_ID_EX		=>	use_sa_id_ex,
		rd_EX_MEM		=>	rd_ex_mem,
		reg_wrt_EX_MEM		=>	reg_wrt_ex_mem,
		reg_wrt_MEM_WB		=>	reg_wrt_mem_wb,	
		rd_MEM_WB		=>	rd_mem_wb,
		forward_rs		=>	forward_rs,	 
		forward_rt		=>	forward_rt	
	);

	-- Decide if forwarding for operand a for ALU
	alu_a_mem_wb_data : mux_32
	port map (
		sel			=>	forward_rs(0),
		src0			=>	alu_a,
		src1			=>	reg_bus_wrt,
		z			=>	alu_a_mem_wb
	);

	alu_a_ex_mem_data : mux_32
	port map (
		sel			=>	forward_rs(1),
		src0			=>	alu_a_mem_wb,
		src1			=>	alu_r_ex_mem,
		z			=>	alu_a_valid
	);

	-- Decide f forwarding for operand b for ALU
	alu_b_mem_wb_data : mux_32
	port map (
		sel			=>	forward_rt(0),
		src0			=>	alu_b,
		src1			=>	reg_bus_wrt,
		z			=>	alu_b_mem_wb
	);

	alu_b_ex_mem_data : mux_32
	port map (
		sel			=>	forward_rt(1),
		src0			=>	alu_b_mem_wb,
		src1			=>	alu_r_ex_mem,
		z			=>	alu_b_valid
	);

	-- Perform desired alu operation
	alu	:	alu_32
	port map (
		ctrl	=>	alu_op_id_ex,
		a	=>	alu_a_valid,
		b	=>	alu_b_valid,
		r	=>	alu_r,
		of_flag	=>	of_flag,
		z_flag	=>	z_flag
	);

	-- If instruction was branch, decide if branch should be taken or not
	branch_decision : branch_resolver
	port map (
		branch		=>	branch_id_ex,
		opcode		=>	instruction_id_ex(31 downto 26),
		z_flag		=>	z_flag,
		s_flag		=>	alu_r(31),
		take_branch	=>	take_branch
	);

	ex_mem_reg : ex_mem_register
	port map (
		clk		=>	clk,
		reset		=>	init,
		ALU_result	=>	alu_r,
		ALU_of		=>	of_flag,
		ALU_zero	=>	z_flag,
		data_to_mem	=>	reg_bus_b_id_ex,
		ALU_result_out	=>	alu_r_ex_mem,
		ALU_of_out	=>	alu_of_ex_mem,
		ALU_zero_out	=>	alu_z_ex_mem,
		data_to_mem_out	=>	reg_bus_b_ex_mem
	);

	control_reg_ex_mem : control_signals
	port map (
		clk			=>	clk,
		reset			=>	init,
		in_mem_to_reg		=>	mem_to_reg_id_ex,
		in_reg_wrt		=>	reg_wrt_id_ex,
		in_mem_wrt		=>	mem_wrt_id_ex,
		in_branch		=>	branch_id_ex,
		in_sign_extend		=>	sign_extend_id_ex,
		in_use_imm		=>	use_imm_id_ex,
		in_use_sa		=>	use_sa_id_ex,
		in_stall		=>	stall_id_ex,
		in_rs			=>	rs_id_ex,
		in_rt			=>	rt_id_ex,
		in_rd			=>	rd_id_ex,
		out_mem_to_reg		=>	mem_to_reg_ex_mem,
		out_reg_wrt		=>	reg_wrt_ex_mem,
		out_mem_wrt		=>	mem_wrt_ex_mem,
		out_branch		=>	branch_ex_mem,
		out_sign_extend		=>	sign_extend_ex_mem,
		out_use_imm		=>	use_imm_ex_mem,
		out_use_sa		=>	use_sa_ex_mem,
		out_stall		=>	stall_ex_mem,
		out_rs			=>	rs_ex_mem,
		out_rt			=>	rt_ex_mem,
		out_rd			=>	rd_ex_mem
	);

	-- STAGE 4: MEM

	-- Check if manually reading from data memory
	data_mem_read_or	:	or_gate
	port map(
		x	=>	manual_mem_inspect,
		y	=>	mem_to_reg_ex_mem,
		z	=>	data_mem_read	-- read from memory if manually inspecting or lw instruction
	);
	data_mem_address	:	mux_32
	port map(
		sel	=>	manual_mem_inspect,
		src0	=>	alu_r_ex_mem,
		src1	=>	manual_mem_inspect_addr,
		z	=>	data_mem_addr	-- memory address is either alu result (lw or sw) or manual address
	);
	

	-- Calculate data memory writing condition. Only allowed to write if mem_wrt (sw instruction) and clk is low. 
	clk_inv_not	:	not_gate
	port map (
		x	=>	clk,
		z	=>	clk_inv
	);

	data_mem_wrt_and	:	and_gate
	port map (
		x	=>	mem_wrt_ex_mem,
		y	=>	clk_inv,
		z	=>	data_mem_wrt
	);

	-- Read and write to data memory
	data_mem	:	sram
	generic map (
		mem_file => code
	)
	port map (
		cs	=>	'1',
		oe	=>	data_mem_read,		-- only read if writing to register (lw instruction) or manually inspecting memory
		we	=>	data_mem_wrt,		-- only write if sw insturction and clk is low (only allowed to write in the second half of the clock cycle)
		addr	=>	data_mem_addr,		-- effective address calculated by alu or given manually from test bench
		din	=>	reg_bus_b_ex_mem,	-- data in is the reg_busB
		dout	=>	data_mem_out
	);

	mem_wb_reg : mem_wb_register
		port map (
		clk			=>	clk,
		reset			=>	init,
		ALU_result		=>	alu_r_ex_mem,
		data_from_mem		=>	data_mem_out,
		ALU_result_out		=>	alu_r_mem_wb,
		data_from_mem_out	=>	data_mem_out_mem_wb
	);

	control_reg_mem_wb : control_signals
	port map (
		clk			=>	clk,
		reset			=>	init,
		in_mem_to_reg		=>	mem_to_reg_ex_mem,
		in_reg_wrt		=>	reg_wrt_ex_mem,
		in_mem_wrt		=>	mem_wrt_ex_mem,
		in_branch		=>	branch_ex_mem,
		in_sign_extend		=>	sign_extend_ex_mem,
		in_use_imm		=>	use_imm_ex_mem,
		in_use_sa		=>	use_sa_ex_mem,
		in_stall		=>	stall_ex_mem,
		in_rs			=>	rs_ex_mem,
		in_rt			=>	rt_ex_mem,
		in_rd			=>	rd_ex_mem,
		out_mem_to_reg		=>	mem_to_reg_mem_wb,
		out_reg_wrt		=>	reg_wrt_mem_wb,
		out_mem_wrt		=>	mem_wrt_mem_wb,
		out_branch		=>	branch_mem_wb,
		out_sign_extend		=>	sign_extend_mem_wb,
		out_use_imm		=>	use_imm_mem_wb,
		out_use_sa		=>	use_sa_mem_wb,
		out_stall		=>	stall_mem_wb,
		out_rs			=>	rs_mem_wb,
		out_rt			=>	rt_mem_wb,
		out_rd			=>	rd_mem_wb
	);

	-- STAGE 5: WB

	-- In case of writing to register file, write from memory or alu result
	reg_bus_wrt_mux	:	mux_32
	port map (
		sel	=>	mem_to_reg_mem_wb,
		src0	=>	alu_r_mem_wb,
		src1	=>	data_mem_out_mem_wb,
		z	=>	reg_bus_wrt
	);
	

end processor_logic;