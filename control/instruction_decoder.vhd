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

entity instruction_decoder is
	port(
		instruction	: in std_logic_vector (31 downto 0);
		rs		: out std_logic_vector (4 downto 0); 
		rt		: out std_logic_vector (4 downto 0); 
		rd		: out std_logic_vector (4 downto 0);
		alu_op		: out std_logic_vector (5 downto 0);
		mem_to_reg	: out std_logic;
		reg_wrt		: out std_logic;
		mem_wrt		: out std_logic;
		branch		: out std_logic;
		sign_extend	: out std_logic;	-- sign extend = 1, zero extend = 0
		use_imm		: out std_logic;	-- use immediate = 1, use registers = 0
		use_sa		: out std_logic		-- use shamt = 1
	);
end instruction_decoder;

architecture instruction_decoder_logic of instruction_decoder is
	signal opcode_decoder_r : std_logic_vector (2**6-1 downto 0);
	signal func_decoder_r : std_logic_vector (2**6-1 downto 0);
	signal be_bne_or_r, lw_sw_or_r : std_logic;
	signal reg_wrt_inv : std_logic;
	signal branch_sig : std_logic;
	signal add_sub_mux_r : std_logic_vector (5 downto 0);

begin
	-- Decode opcode:

	opcode_decoder	:	dec_n
	generic map (
		n	=>	6
	)
	port map (
		src	=>	instruction (31 downto 26),
		z	=>	opcode_decoder_r
	);

	-- Set mem_to_reg flag if lw instruction

	mem_to_reg <= opcode_decoder_r (35);
	
	-- Set mem_wrt flag if sw instruction

	mem_wrt <= opcode_decoder_r (43);

	-- Set branch flag if beq, bne or bgtz instruction

	be_bne_or	: 	or_gate
	port map (
		x	=>	opcode_decoder_r (4),
		y	=>	opcode_decoder_r (5),
		z	=>	be_bne_or_r
	);
	branch_or	: 	or_gate
	port map (
		x	=>	be_bne_or_r,
		y	=>	opcode_decoder_r (7),
		z	=>	branch_sig
	);
	branch <= branch_sig;

	-- Set reg_wrt flag if not branch or sw instruction 

	branch_sw_or	: 	or_gate
	port map (
		x	=>	branch_sig,
		y	=>	opcode_decoder_r (43),
		z	=>	reg_wrt_inv
	);

	reg_wrt_not	:	not_gate
	port map (
		x	=>	reg_wrt_inv,
		z	=>	reg_wrt
	);

	-- Set sign_extend flag if not r-type instruction (lw, sw, addi and branches require sign extending)
	
	sign_extend_not	:	not_gate
	port map(
		x	=>	opcode_decoder_r (0),
		z	=>	sign_extend
	);	

	-- Set use_imm flag if addi, lw or sw instruction

	lw_sw_or	: 	or_gate
	port map (
		x	=>	opcode_decoder_r (35),
		y	=>	opcode_decoder_r (43),
		z	=>	lw_sw_or_r
	);
	use_imm_or	: 	or_gate
	port map (
		x	=>	lw_sw_or_r,
		y	=>	opcode_decoder_r (8),
		z	=>	use_imm
	);

	-- Set use_sa flag if sll (opcode = 0 and func = 0) instruction
	func_decoder	:	dec_n
	generic map (
		n	=>	6
	)
	port map (
		src	=>	instruction (5 downto 0),
		z	=>	func_decoder_r
	);

	use_sa_and	:	and_gate
	port map(
		x	=>	opcode_decoder_r(0),
		y	=>	func_decoder_r(0),
		z	=>	use_sa
	);

	-- Deduce registers used and destination register

	rs <= instruction(25 downto 21);
	
	rt_mux	:	mux_n
	generic map (
		n 	=>	5
	)
	port map (
		sel	=>	opcode_decoder_r (7),		-- if bgtz instruction
		src0	=>	instruction(20 downto 16),	-- rt
		src1	=>	"00000",			-- r0 (zero register)
		z	=>	rt
	);
	
	rd_mux	:	mux_n
	generic map (
		n 	=>	5
	)
	port map (
		sel	=>	opcode_decoder_r (0),		-- if r-type instruction
		src0	=>	instruction (20 downto 16),	-- rt
		src1	=>	instruction (15 downto 11),	-- rd
		z	=>	rd
	);

	-- Select alu_op. r-type ? func : (branch ? SUB : ADD )

	add_sub_mux	:	mux_n
	generic map (
		n 	=>	6
	)
	port map (
		sel	=>	branch_sig,
		src0	=>	"100000",	-- ADD
		src1	=>	"100010",	-- SUB
		z	=>	add_sub_mux_r
	);

	alu_op_mux	:	mux_n
	generic map (
		n 	=>	6
	)
	port map (
		sel	=>	opcode_decoder_r (0),		-- if r-type instruction
		src0	=>	add_sub_mux_r,
		src1	=>	instruction (5 downto 0),
		z	=>	alu_op
	);
	

end instruction_decoder_logic;