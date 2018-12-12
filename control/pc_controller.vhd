library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use work.eecs361.all;
use work.eecs361_gates.all;

--INST	OPCODE	DEC	SPECIAL
--ADD	000000	0	100000
--ADDU	000000	0	100001
--SUB	000000	0	100010
--SUBU	000000	0	100011
--AND	000000	0	100100
--OR	000000	0	100101
--SLT	000000	0	101010
--SLTU	000000	0	101011
--SLL	000000	0	000000
--ADDI	001000	8
--LW	100011	35
--SW	101011	43
--BEQ	000100	4
--BNE	000101	5
--BGTZ	000111	7

entity pc_controller is
	port(
		pc_init			: in std_logic;
		pc_init_data		: in std_logic_vector (31 downto 0);
		clk			: in std_logic;
		immediate_extended	: in std_logic_vector (31 downto 0);
		take_branch		: in std_logic;	
		stall			: in std_logic;	
		pc			: out std_logic_vector (31 downto 0)
	);
end pc_controller;

architecture pc_controller_logic of pc_controller is
	signal pc_plus_4, pc_branch	: std_logic_vector (31 downto 0);
	signal immediate_extended_x4	: std_logic_vector (31 downto 0);
	signal pc_next			: std_logic_vector (31 downto 0);
	signal pc_next_val			: std_logic_vector (31 downto 0);
	signal pc_curr			: std_logic_vector (31 downto 0);
begin
	-- Obtain current pc
	pc_reg	:	register_1
	port map (
		clk		=>	clk,
		init		=>	pc_init,
		init_data	=>	pc_init_data,
		input		=>	pc_next,
		output		=>	pc_curr
	);

	pc <= pc_curr;

	--Calculate next pc

	--if branch
		-- PC <- PC + 4 + ( SignExt(imm16) x 4 )
	-- else
		-- PC <- PC + 4

	-- pc + 4
	pc_plus_4_alu	:	alu_32
	port map (
		ctrl	=>	"100000",	-- Add
		a	=>	pc_curr,
		b	=>	conv_std_logic_vector (4, 32),	-- Add 4 to pc
		r	=>	pc_plus_4
	);

	-- SignExt(imm16) * 4 = SignExt(imm16) << 2
	imm16x4_shifter	:	shifter_32
	port map (
		a	=>	immediate_extended,
		b	=>	conv_std_logic_vector (2,32),
		r	=>	immediate_extended_x4
	);

	-- pc + 4 + SignExt(imm16) * 4
	pc_branch_alu	:	alu_32
	port map (
		ctrl	=>	"100000",	-- Add
		a	=>	pc_plus_4,
		b	=>	immediate_extended_x4,
		r	=>	pc_branch
	);

	next_pc_mux	:	mux_32
	port map (
		sel	=>	take_branch,
		src0	=>	pc_plus_4,
		src1	=>	pc_branch,
		z	=>	pc_next_val
	);

	stall_mux	:	mux_32
	port map (
		sel	=>	stall,
		src0	=>	pc_next_val,
		src1	=>	conv_std_logic_vector(0,32),
		z	=>	pc_next
	);

end pc_controller_logic;


