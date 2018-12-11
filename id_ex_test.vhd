library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity id_ex_test is
end id_ex_test;

architecture behavioral of id_ex_test is

signal clk, reset : std_logic;
signal input_pc, input_a, input_b, input_immediate : std_logic_vector(31 downto 0);
signal output_pc, output_a, output_b, output_immediate : std_logic_vector(31 downto 0);

begin
test_comp : id_ex_register
	port map (
		clk=>clk,
		reset=>reset,
		input_pc=>input_pc,
		input_a=>input_a,
		input_b=>input_b,
		input_immediate=>input_immediate,
		output_pc=>output_pc,
		output_a=>output_a,
		output_b=>output_b,
		output_immediate=>output_immediate);
testbench : process
begin
clk <= '0';
reset <= '0';
input_pc <= "00000000000000000000000000000000";
input_a <= "10101010101010101010101010101010";
input_b <= "10101010101010101010101010101010";
input_immediate <= "00000000000000001111111111111111";
wait for 5 ns;
clk <= '1';
wait for 5 ns;
assert output_pc <= "00000000000000000000000000000000";
assert output_a <= "10101010101010101010101010101010";
assert output_b <= "10101010101010101010101010101010";
assert output_immediate <= "00000000000000001111111111111111";

wait;
 end process;
end behavioral;


