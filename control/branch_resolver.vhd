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

entity branch_resolver is
	port(
		branch		: in std_logic;
		opcode		: in std_logic_vector (5 downto 0);
		z_flag		: in std_logic;
		s_flag		: in std_logic;
		take_branch	: out std_logic
	);
end branch_resolver;

architecture branch_resolver_logic of branch_resolver is
	signal a, b 					: std_logic;
	signal a_inv, b_inv, z_flag_inv, s_flag_inv	: std_logic;
	signal a_inv_and_b_inv_r, b_and_z_flag_inv 	: std_logic;
	signal minterm_1, minterm_2, minterm_3		: std_logic;
	signal minterm_1_or_minterm_2_r, minterms_or_r	: std_logic;

begin
	-- Overall logic

	--if branch
	--	if beq and z_flag
	--		return 1
	--	else if bneq and not z_flag
	--		return 1
	--	else if bgtz and not s_flag and not z_flag
	--		return 1
	--	else
	--		return 0
	-- else
		-- return 0

	-- Let opcode (0) = b, opcode (1) = a	
	a <= opcode (1);
	b <= opcode (0);

	-- take_branch = branch & ( (~a&~b&z) | (~a&b&~z) | (a&b~z&~s)) == branch & ( (~a&~b&z) | (~a&b&~z) | (b~z&~s)) using k-map minimization

	-- Calculate inverses
	a_inv_not	:	not_gate
	port map (
		x	=>	a,
		z	=>	a_inv
	);

	b_inv_not	:	not_gate
	port map (
		x	=>	b,
		z	=>	b_inv
	);

	z_flag_inv_not	:	not_gate
	port map (
		x	=>	z_flag,
		z	=>	z_flag_inv
	);

	s_flag_inv_not	:	not_gate
	port map (
		x	=>	s_flag,
		z	=>	s_flag_inv
	);

	-- Minterm 1 (~a&~b&z)	
	a_inv_and_b_inv_and	:	and_gate
	port map (
		x	=>	a_inv,
		y	=>	b_inv,
		z	=>	a_inv_and_b_inv_r
	);
	minterm_1_and	:	and_gate
	port map (
		x	=>	a_inv_and_b_inv_r,
		y	=>	z_flag,
		z	=>	minterm_1
	);

	-- Minterm 2 (~a&b&~z)	
	b_and_z_inv_and	:	and_gate
	port map (
		x	=>	b,
		y	=>	z_flag_inv,
		z	=>	b_and_z_flag_inv
	);
	minterm_2_and	:	and_gate
	port map (
		x	=>	b_and_z_flag_inv,
		y	=>	a_inv,
		z	=>	minterm_2
	);

	-- Minterm 3 (b~z&~s)	
	minterm_3_and	:	and_gate
	port map (
		x	=>	b_and_z_flag_inv,
		y	=>	s_flag_inv,
		z	=>	minterm_3
	);

	-- or all 3 minterms --> (~a&~b&z) | (~a&b&~z) | (b~z&~s)
	min_1_or_min_2_or	:	or_gate
	port map (
		x	=>	minterm_1,
		y	=>	minterm_2,
		z	=>	minterm_1_or_minterm_2_r
	);

	minterms_or	:	or_gate
	port map (
		x	=>	minterm_1_or_minterm_2_r,
		y	=>	minterm_3,
		z	=>	minterms_or_r
	);
	
	-- take_branch = branch & ( (~a&~b&z) | (~a&b&~z) | (b~z&~s))
	take_branch_and	:	and_gate
	port map (
		x	=>	branch,
		y	=>	minterms_or_r,
		z	=>	take_branch
	);

	
end branch_resolver_logic;

