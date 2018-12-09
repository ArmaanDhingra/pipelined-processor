library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.eecs361.all;
use work.eecs361_gates.all;


entity shifter_32_test is
end shifter_32_test;

architecture behavioral of shifter_32_test is

signal a	: std_logic_vector (31 downto 0);
signal b	: std_logic_vector (31 downto 0);
signal r	: std_logic_vector (31 downto 0);

signal sll_test	: std_logic_vector (31 downto 0);
signal case_cnt	: integer;

begin
test_comp : shifter_32
	port map (
		a	=>	a,
		b	=>	b,
		r	=>	r
	);
testbench : process
 begin
	case_cnt <= 1;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	sll_test <= a(31 DOWNTO 0);
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	sll_test <= a(31 DOWNTO 0);
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	sll_test <= a(30 DOWNTO 0) & '0';
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	sll_test <= a(30 DOWNTO 0) & '0';
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(2, 32);
	wait for 5 ns;
	sll_test <= a(29 DOWNTO 0) & "00";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(3, 32);
	wait for 5 ns;
	sll_test <= a(28 DOWNTO 0) & "000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(4, 32);
	wait for 5 ns;
	sll_test <= a(27 DOWNTO 0) & "0000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(5, 32);
	wait for 5 ns;
	sll_test <= a(26 DOWNTO 0) & "00000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(6, 32);
	wait for 5 ns;
	sll_test <= a(25 DOWNTO 0) & "000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(7, 32);
	wait for 5 ns;
	sll_test <= a(24 DOWNTO 0) & "0000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(8, 32);
	wait for 5 ns;
	sll_test <= a(23 DOWNTO 0) & "00000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(9, 32);
	wait for 5 ns;
	sll_test <= a(22 DOWNTO 0) & "000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(10, 32);
	wait for 5 ns;
	sll_test <= a(21 DOWNTO 0) & "0000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(11, 32);
	wait for 5 ns;
	sll_test <= a(20 DOWNTO 0) & "00000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(12, 32);
	wait for 5 ns;
	sll_test <= a(19 DOWNTO 0) & "000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(13, 32);
	wait for 5 ns;
	sll_test <= a(18 DOWNTO 0) & "0000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(14, 32);
	wait for 5 ns;
	sll_test <= a(17 DOWNTO 0) & "00000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(15, 32);
	wait for 5 ns;
	sll_test <= a(16 DOWNTO 0) & "000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(16, 32);
	wait for 5 ns;
	sll_test <= a(15 DOWNTO 0) & "0000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(17, 32);
	wait for 5 ns;
	sll_test <= a(14 DOWNTO 0) & "00000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(18, 32);
	wait for 5 ns;
	sll_test <= a(13 DOWNTO 0) & "000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(19, 32);
	wait for 5 ns;
	sll_test <= a(12 DOWNTO 0) & "0000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(20, 32);
	wait for 5 ns;
	sll_test <= a(11 DOWNTO 0) & "00000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(21, 32);
	wait for 5 ns;
	sll_test <= a(10 DOWNTO 0) & "000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(22, 32);
	wait for 5 ns;
	sll_test <= a(9 DOWNTO 0) & "0000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(23, 32);
	wait for 5 ns;
	sll_test <= a(8 DOWNTO 0) & "00000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(24, 32);
	wait for 5 ns;
	sll_test <= a(7 DOWNTO 0) & "000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(25, 32);
	wait for 5 ns;
	sll_test <= a(6 DOWNTO 0) & "0000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(26, 32);
	wait for 5 ns;
	sll_test <= a(5 DOWNTO 0) & "00000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(27, 32);
	wait for 5 ns;
	sll_test <= a(4 DOWNTO 0) & "000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(28, 32);
	wait for 5 ns;
	sll_test <= a(3 DOWNTO 0) & "0000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(29, 32);
	wait for 5 ns;
	sll_test <= a(2 DOWNTO 0) & "00000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(30, 32);
	wait for 5 ns;
	sll_test <= a(1 DOWNTO 0) & "000000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(31, 32);
	wait for 5 ns;
	sll_test <= a(0 DOWNTO 0) & "0000000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(12546, 32);
	b <= conv_std_logic_vector(23, 32);
	wait for 5 ns;
	sll_test <= a(8 DOWNTO 0) & "00000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-1, 32);
	b <= conv_std_logic_vector(23, 32);
	wait for 5 ns;
	sll_test <= a(8 DOWNTO 0) & "00000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	

	wait;
 end process;
end behavioral;
