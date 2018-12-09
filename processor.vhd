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
	
	-- Obtain current pc and advance pc the end of clock cycle
	pc_control	:	pc_controller
	port map(
		pc_init			=>	init,
		pc_init_data		=>	pc_init_data,
		clk			=>	clk,
		immediate_extended	=>	immediate_extended,
		take_branch		=>	take_branch,
		pc			=>	pc
	);
	
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
	
	-- Decode instruction and set control signals
	instruction_decoding	: instruction_decoder
	port map(
		instruction	=>	instruction,
		rs		=>	rs,
		rt		=>	rt,
		rd		=>	rd,
		alu_op		=>	alu_op,
		mem_to_reg	=>	mem_to_reg,
		reg_wrt		=>	reg_wrt,
		mem_wrt		=>	mem_wrt,
		branch		=>	branch,
		sign_extend	=>	sign_extend,
		use_imm		=>	use_imm,
		use_sa		=>	use_sa
	);

	-- Read and write to register file
	register_file_inst : register_file
	port map (
		init		=> init,
		reg_wr		=> reg_wrt,
		reg_dst		=> rd,
		rs		=> rs,		 
		rt		=> rt, 		
		busW		=> reg_bus_wrt,
		clk		=> clk,		
		busA		=> reg_bus_a,		
		busB		=> reg_bus_b
	);
	
	-- Extend immediate for addi, load/store or branch instructions
	immediate_extender	: extender
	port map (
		sign	=>	sign_extend,
		input	=>	instruction (15 downto 0),
		output	=>	immediate_extended
	);
	
	-- Extend (zero extend) shamt for sll 
	sa_16_gen_0 : for i in 0 to 4 generate
		shamt_extended (i) <= instruction(6+i);
	end generate;
	sa_16_gen : for i in 5 to 31 generate
		shamt_extended (i) <= '0';
	end generate;

	-- Adjust alu first source based on if sll (rd=rt<<sa) instruction or not
	alu_a_mux	:	mux_32
	port map (
		sel	=>	use_sa,
		src0	=>	reg_bus_a,
		src1	=>	reg_bus_b,
		z	=>	alu_a
	);
	
	-- Adjust alu second source based on if addi, load/store or branch instructions or not	 
	alu_b_reg_imm_mux	:	mux_32
	port map (
		sel	=>	use_imm,
		src0	=>	reg_bus_b,
		src1	=>	immediate_extended,
		z	=>	alu_b_reg_imm
	);
	alu_b_mux	:	mux_32
	port map (
		sel	=>	use_sa,
		src0	=>	alu_b_reg_imm,
		src1	=>	shamt_extended,
		z	=>	alu_b
	);


	-- Perform desired alu operation
	alu	:	alu_32
	port map (
		ctrl	=>	alu_op,
		a	=>	alu_a,
		b	=>	alu_b,
		r	=>	alu_r,
		of_flag	=>	of_flag,
		z_flag	=>	z_flag
	);

	-- In case of writing to register file, write from memory or alu result
	reg_bus_wrt_mux	:	mux_32
	port map (
		sel	=>	mem_to_reg,
		src0	=>	alu_r,
		src1	=>	data_mem_out,
		z	=>	reg_bus_wrt
	);


	-- Check if manually reading from data memory
	data_mem_read_or	:	or_gate
	port map(
		x	=>	manual_mem_inspect,
		y	=>	mem_to_reg,
		z	=>	data_mem_read	-- read from memory if manually inspecting or lw instruction
	);
	data_mem_address	:	mux_32
	port map(
		sel	=>	manual_mem_inspect,
		src0	=>	alu_r,
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
		x	=>	mem_wrt,
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
		oe	=>	data_mem_read,	-- only read if writing to register (lw instruction) or manually inspecting memory
		we	=>	data_mem_wrt,	-- only write if sw insturction and clk is low (only allowed to write in the second half of the clock cycle)
		addr	=>	data_mem_addr,	-- effective address calculated by alu or given manually from test bench
		din	=>	reg_bus_b,	-- data in is the reg_busB
		dout	=>	data_mem_out
	);

	-- If instruction was branch, decide if branch should be taken or not
	branch_decision : branch_resolver
	port map (
		branch		=>	branch,
		opcode		=>	instruction(31 downto 26),
		z_flag		=>	z_flag,
		s_flag		=>	alu_r(31),
		take_branch	=>	take_branch
	);

end processor_logic;