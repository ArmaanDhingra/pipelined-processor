library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity control_signals_test is
end control_signals_test;

architecture behavioral of control_signals_test is

signal clk, reset, in_stall, in_mem_to_reg, in_reg_wrt, in_mem_wrt, in_branch, in_sign_extend, in_use_imm, in_use_sa : std_logic;
signal out_mem_to_reg, out_stall, out_reg_wrt, out_mem_wrt, out_branch, out_sign_extend, out_use_imm, out_use_sa : std_logic;
signal in_rd, out_rd : std_logic_vector(4 downto 0);

begin
test_comp : control_signals
	port map (
		clk=>clk,
		reset=>reset,
		in_mem_to_reg=>in_mem_to_reg,
		in_reg_wrt=>in_reg_wrt,
		in_mem_wrt=>in_mem_wrt,
		in_branch=>in_branch,
		in_sign_extend=>in_sign_extend,
		in_use_imm=>in_use_imm,
		in_use_sa=>in_use_sa,
		in_stall=>in_stall,
		out_mem_to_reg=>out_mem_to_reg,
		out_reg_wrt=>out_reg_wrt,
		out_mem_wrt=>out_mem_wrt,
		out_branch=>out_branch,
		out_sign_extend=>out_sign_extend,
		out_use_imm=>out_use_imm,
		out_use_sa=>out_use_sa,
		out_stall=>out_stall,
		in_rd=>in_rd,
		out_rd=>out_rd);

testbench : process
begin
clk <= '0';
reset <= '0';
in_mem_to_reg <= '0';
in_reg_wrt <= '0';
in_mem_wrt <= '0';
in_branch <= '0';
in_sign_extend <= '0';
in_use_imm <= '0';
in_use_sa <= '0';
in_stall <= '0';
in_rd <= "00000";
wait for 5 ns;
clk <= '1';
wait for 5 ns;
assert out_mem_to_reg = '0' report "m2R did not change output at RE";
assert out_reg_wrt = '0' report "r2w did not change output at RE";
assert out_mem_wrt = '0' report "mW did not change output at RE";
assert out_branch = '0' report "branch did not change output at RE";
assert out_sign_extend = '0' report "sign_extend did not change output at RE";
assert out_use_imm = '0' report "use_imm did not change output at RE";
assert out_use_sa = '0' report "use_sa did not change output at RE";
assert out_rd = "00000" report "rd did not change output at RE";
assert out_stall = '0' report "stall did not change output at RE";
wait for 5 ns;
clk <= '0';
wait for 5 ns;
assert out_mem_to_reg = '0' report "mem to reg changed output at FE";
assert out_reg_wrt = '0' report "reg_wrt changed output at FE";
assert out_mem_wrt = '0' report "mem_wrt changed output at FE";
assert out_branch = '0' report "branch changed output at FE";
assert out_sign_extend = '0' report "sign extend changed output at FE";
assert out_use_imm = '0' report "use imm changed output at FE";
assert out_use_sa = '0' report "use_sa changed output at FE";
assert out_rd = "00000" report "rd changed output at FE";
assert out_stall = '0' report "stall changed output at FE";
wait for 5 ns;
in_mem_to_reg <= '1';
in_reg_wrt <= '1';
in_mem_wrt <= '1'; 
in_branch <= '1';
in_sign_extend <= '1';
in_use_imm <= '1';
in_use_sa <= '1';
in_stall <= '1';
in_rd <= "11111";
wait for 5 ns;
assert out_mem_to_reg = '0';
assert out_reg_wrt = '0';
assert out_mem_wrt = '0';
assert out_branch = '0';
assert out_sign_extend = '0';
assert out_use_imm = '0';
assert out_use_sa = '0';
assert out_rd = "00000";
assert out_stall = '0';
wait for 5 ns;
clk <= '1';
wait for 5 ns;
assert out_mem_to_reg = '1';
assert out_reg_wrt = '1';
assert out_mem_wrt = '1';
assert out_branch = '1';
assert out_sign_extend = '1';
assert out_use_imm = '1';
assert out_use_sa = '1';
assert out_rd = "11111";
assert out_stall = '1';
wait for 5 ns;
wait;
end process;
end behavioral;
