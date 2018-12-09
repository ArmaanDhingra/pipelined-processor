library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all; 

entity register_1 is 
	port(
		clk		: in std_logic;
		init		: in std_logic;
		init_data	: in std_logic_vector(31 downto 0);
		input		: in std_logic_vector(31 downto 0);
		output		: out std_logic_vector(31 downto 0)
	);
end register_1;

architecture register_1_logic of register_1 is

begin
	dff_32_gen : for i in 0 to 31 generate
		dff:dffr_a
		port map( 
			arst	=>	'0',
			aload	=>	init,
			adata	=>	init_data(i),
			enable	=>	'1',
			clk	=>	clk,
			d	=>	input(i),
			q	=>	output(i)
		);
	end generate dff_32_gen;

end architecture register_1_logic;
