library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity extender is
	port ( 
		sign	: in std_logic;
		input	: in std_logic_vector(15 downto 0);
		output	: out std_logic_vector(31 downto 0)
	);
end extender;

architecture extender_logic of extender is
 	
signal and_r: std_logic;

begin
	
	a1: and_gate 
	port map(
		x	=>	input(15), 
		y	=>	sign, 
		z	=>	and_r
	);

	lowerBits : for i in 15 downto 0 generate
		output(i) <= input(i);
	end generate lowerBits;

	extension: for i in 31 downto 16 generate
		output(i) <= and_r;
	end generate extension;
		
end architecture extender_logic;
	