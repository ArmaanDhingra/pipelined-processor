library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
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

entity register_1_test is
end register_1_test;

architecture behavioral of register_1_test is

signal clk	: std_logic;
signal init	: std_logic;
signal init_data: std_logic_vector(31 downto 0);
signal input	: std_logic_vector(31 downto 0);
signal output	: std_logic_vector(31 downto 0);


begin
test_comp : register_1
	port map (
		clk		=>	clk,
		init		=>	init,
		init_data	=>	init_data,
		input		=>	input,
		output		=>	output
	);
testbench : process
 begin
	init_data <= x"00400020";
	init <= '1';
	wait for 5 ns;
	assert output = init_data report "ERROR: Initialization" severity error;
	init <= '0';

	clk <= '0';
	input <= conv_std_logic_vector(5, 32);
	wait for 5 ns;
	clk <= '1';
	wait for 5 ns;
	assert output = conv_std_logic_vector(5, 32) report "ERROR: Cold Write" severity error;
	wait for 5 ns;

	clk <= '0';
	input <= conv_std_logic_vector(88, 32);
	assert output = conv_std_logic_vector(5, 32) report "ERROR: Read Stored Value" severity error;

	wait for 5 ns;
	clk <= '1';
	wait for 5 ns;
	assert output = conv_std_logic_vector(88, 32) report "ERROR: Read New Value" severity error;
	wait for 5 ns;

	init_data <= x"00400020";
	init <= '1';
	wait for 5 ns;
	assert output = init_data report "ERROR: Reinitialization" severity error;
	init <= '0';

	wait;
 end process;
end behavioral;
