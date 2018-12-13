library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity id_ex_test is
end id_ex_test;

architecture behavioral of id_ex_test is

signal clk, reset : std_logic;
signal input_pc, input_a, input_b, input_immediate, input_shamt_extended, input_instruction : std_logic_vector(31 downto 0);
signal output_pc, output_a, output_b, output_immediate, output_shamt_extended,output_instruction : std_logic_vector(31 downto 0);
signal input_alu_op, output_alu_op : std_logic_vector(5 downto 0);

begin
test_comp : id_ex_register
	port map (
		clk=>clk,
		reset=>reset,
		input_pc=>input_pc,
		input_a=>input_a,
		input_b=>input_b,
		input_immediate=>input_immediate,
		input_shamt_extended=>input_shamt_extended,
		input_instruction=>input_instruction,
		input_alu_op=>input_alu_op,
		output_pc=>output_pc,
		output_a=>output_a,
		output_b=>output_b,
		output_immediate=>output_immediate,
		output_shamt_extended=>output_shamt_extended, 
		output_instruction=>output_instruction, 
		output_alu_op=>output_alu_op);
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
assert output_pc = "00000000000000000000000000000000";
assert output_a = "10101010101010101010101010101010";
assert output_b = "10101010101010101010101010101010";
assert output_immediate = "00000000000000001111111111111111";
wait for 5 ns;
input_pc <= "00000000000000000000000000000001";
input_a <= "10101010101010101010101010101011";
input_b <= "10101010101010101010101010101011";
input_immediate <= "00000000000000001111111111111110";
wait for 5 ns;
assert output_pc = "00000000000000000000000000000000";
assert output_a = "10101010101010101010101010101010";
assert output_b = "10101010101010101010101010101010";
assert output_immediate = "00000000000000001111111111111111";
wait for 5 ns;
clk <= '0';
wait for 5 ns;
assert output_pc = "00000000000000000000000000000000";
assert output_a = "10101010101010101010101010101010";
assert output_b = "10101010101010101010101010101010";
assert output_immediate = "00000000000000001111111111111111";
wait for 5 ns;
clk <= '1';
wait for 5 ns;
assert output_pc = "00000000000000000000000000000001";
assert output_a = "10101010101010101010101010101011";
assert output_b = "10101010101010101010101010101011";
assert output_immediate = "00000000000000001111111111111110";
wait for 5 ns;
wait;
 end process;
end behavioral;


