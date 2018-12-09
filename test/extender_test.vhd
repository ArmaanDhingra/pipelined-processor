library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;

entity extender_test is
end extender_test;

architecture behavioral of extender_test is
signal sign : std_logic;
signal input : std_logic_vector(15 downto 0);
signal output : std_logic_vector(31 downto 0);


begin
test_comp: extender
	port map(
		sign	=>	sign,
		input	=>	input, 
		output	=>	output
);

testbench : process
  begin

	input <= "0000000000000000";
	sign <= '0';
	wait for 5 ns;
	assert output = "00000000000000000000000000000000" report "Failed Zero Extend 0";
	wait for 5 ns;

	input <= "1111111111111111";
	wait for 5 ns;
	assert output = "00000000000000001111111111111111" report "Failed Zero Extend -1";
	wait for 5 ns;
	
	sign <= '1';
	wait for 5 ns;
	assert output = "11111111111111111111111111111111" report "Failed Sign Extend -1";
	wait for 5ns;
	
	input <= "1010101010101010";
	wait for 5 ns;
	assert output = "11111111111111111010101010101010" report "Failed Sign Extend 1010...";
	wait for 5 ns;
	
	wait;
  end process;
end behavioral;
