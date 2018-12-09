library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity adder_1 is
	port (
		cin	: in	std_logic;
		a	: in	std_logic;
		b	: in	std_logic;
		r	: out	std_logic;
		cout	: out	std_logic
	);
end adder_1;

architecture adder_1_logic of adder_1 is
	signal xor_a_b, and_a_b, and_b_cin, and_a_cin, or_and_a_b_and_a_cin: std_logic;
begin
	-- Addition --
	r_xor_1		:	xor_gate
	port map (
		x	=>	a,
		y	=>	b,
		z	=>	xor_a_b
	);

	r_xor_2		:	xor_gate
	port map(
		x	=>	xor_a_b,
		y	=>	cin,
		z	=>	r
	);

	-- Carry Out --
	cout_and_1	:	and_gate
	port map (
		x	=>	a,
		y	=>	b,
		z	=>	and_a_b
	);

	cout_and_2	:	and_gate
	port map (
		x	=>	a,
		y	=>	cin,
		z	=>	and_a_cin
	);

	cout_and_3	:	and_gate
	port map (
		x	=>	b,
		y	=>	cin,
		z	=>	and_b_cin
	);
	
	cout_or_1	:	or_gate
	port map (
		x	=>	and_a_b,
		y	=>	and_a_cin,
		z	=>	or_and_a_b_and_a_cin
	);

	cout_or_2	:	or_gate
	port map (
		x	=>	or_and_a_b_and_a_cin,
		y	=>	and_b_cin,
		z	=>	cout
	);

end adder_1_logic;