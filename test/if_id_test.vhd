library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity if_id_test is
end if_id_test;

architecture behavioral of if_id_test is

signal clk, reset : std_logic := '0';
signal input_pc, input_inst : std_logic_vector(31 downto 0) := (others => '0');
signal output_pc, output_inst : std_logic_vector(31 downto 0) := (others => '0');

begin
test_comp : if_id_register
	port map (
		clk		=>	clk,
		reset		=>	reset,
		input_pc	=>	input_pc,
		input_inst	=>	input_inst,
		output_pc	=>	output_pc,
		output_inst	=>	output_inst
	);

testbench : process
  begin
	clk <= '0';
	reset <= '0';
	input_pc <= "00000000000000000000000000000000";
	input_inst <= "00000000000000000000000000000000";
	
	wait for 5 ns;	
	clk <= '1';
	wait for 5 ns;
	
	assert output_pc = "00000000000000000000000000000000";
	assert output_inst = "00000000000000000000000000000000";
	
	wait for 5 ns;
	input_pc <= "00000000000000000000000000000001";
	input_inst <= "00000000000000000000000000000001";

	wait for 5 ns;
	assert output_pc = "00000000000000000000000000000000";
	assert output_inst = "00000000000000000000000000000000";

	wait for 5 ns;
	clk <= '0';
	wait for 5 ns;
	assert output_pc = "00000000000000000000000000000000";
	assert output_inst = "00000000000000000000000000000000";

	wait for 5 ns;
	clk <= '1';
	wait for 5 ns;
	assert output_pc = "00000000000000000000000000000001";
	assert output_inst = "00000000000000000000000000000001";
	wait for 5 ns;
wait;
 end process;
end behavioral;

