library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;


-- INST		CTRL
-- ADD		000
-- ADDU		001
-- SUB		010
-- SUBU		011
-- SLT		010
-- SLTU		011
-- AND		100
-- OR		101


-- CTRL(0): AND or OR
-- CTRL(1): ADD or SUB
-- CTRL(2): ADD/SUB or AND/OR

entity alu_1 is
	port (
		ctrl	: in	std_logic_vector (2 downto 0);
		cin	: in	std_logic;
		a	: in	std_logic;
		b	: in	std_logic;
		r	: out	std_logic;
		cout	: out	std_logic
	);
end alu_1;

architecture alu_1_logic of alu_1 is
	signal and_r, or_r, and_or_mux_r : std_logic;
	signal add_sub_r, add_sub_cout, not_b, b_eff : std_logic;

begin
	alu_and : and_gate
	port map (
		x	=>	a,
		y	=>	b,
		z	=>	and_r
	);

	alu_or	:	or_gate
	port map (
		x	=>	a,
		y	=>	b,
		z	=>	or_r
	);

	and_or_mux	:	mux
	port map(
		sel	=>	ctrl(0),
		src0  	=>	and_r,
		src1	=>	or_r,
		z	=>	and_or_mux_r
	);


	alu_not_b	:	not_gate
	port map (
		x	=>	b,
		z	=>	not_b
	);

	alu_b_eff	:	mux
	port map(
		sel	=>	ctrl(1),
		src0  	=>	b,
		src1	=>	not_b,
		z	=>	b_eff
	);

	alu_full_adder	:	adder_1
	port map (
		cin	=>	cin,
		a	=>	a,
		b	=>	b_eff,
		r	=>	add_sub_r,
		cout	=>	add_sub_cout
	);

	alu_r_mux	:	mux
	port map(
		sel	=>	ctrl(2),
		src0  	=>	add_sub_r,
		src1	=>	and_or_mux_r,
		z	=>	r
	);

	alu_cout_mux	:	mux
	port map(
		sel	=>	ctrl(2),
		src0  	=>	add_sub_cout,
		src1	=>	'0',
		z	=>	cout
	);

end alu_1_logic;