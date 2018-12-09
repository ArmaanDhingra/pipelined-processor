library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use work.eecs361.all;
use work.eecs361_gates.all;

--INST	OPCODE	SPECIAL
--ADD	000000	100000
--ADDU	000000	100001
--SUB	000000	100010
--SUBU	000000	100011
--AND	000000	100100
--OR	000000	100101
--SLT	000000	101010
--SLTU	000000	101011
--SLL	000000	000000

entity alu_32_test is
end alu_32_test;

architecture behavioral of alu_32_test is

signal ctrl	: std_logic_vector (5 downto 0);
signal a	: std_logic_vector (31 downto 0);
signal b	: std_logic_vector (31 downto 0);
signal r	: std_logic_vector (31 downto 0);
signal of_flag	: std_logic;
signal z_flag	: std_logic;

signal sll_test	: std_logic_vector (31 downto 0);
signal case_cnt	: integer;

begin
test_comp : alu_32
	port map (
		ctrl	=>	ctrl,
		a	=>	a,
		b	=>	b,
		r	=>	r,
		of_flag	=>	of_flag,
		z_flag	=>	z_flag
	);
testbench : process
 begin
	-- AND TEST --
	ctrl <= "100100";
	case_cnt <= 1;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = (a and b) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = (a and b) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;


	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = (a and b) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = (a and b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(54872, 32);
	b <= conv_std_logic_vector(15236, 32);
	wait for 5 ns;
	assert r = (a and b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-1, 32);
	b <= conv_std_logic_vector(-1, 32);
	wait for 5 ns;
	assert r = (a and b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- OR TEST --
	ctrl <= "100101";
	case_cnt <= 1;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = (a or b) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = (a or b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;


	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = (a or b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = (a or b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(54872, 32);
	b <= conv_std_logic_vector(15236, 32);
	wait for 5 ns;
	assert r = (a or b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-1, 32);
	b <= conv_std_logic_vector(-1, 32);
	wait for 5 ns;
	assert r = (a or b) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- ADD TEST --
	ctrl <= "100000";
	case_cnt <= 1;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(0, 32) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(1, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;


	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(1, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(2, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(54872, 32);
	b <= conv_std_logic_vector(15236, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(70108, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-1, 32);
	b <= conv_std_logic_vector(-1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(-2, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(2147483647, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(-2147483648, 32) and z_flag = '0' and of_flag = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(2147483646, 32);
	b <= conv_std_logic_vector(2, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(-2147483648, 32) and z_flag = '0' and of_flag = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;


	-- SUB TEST --
	ctrl <= "100010";
	case_cnt <= 1;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(0, 32) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(-1, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;


	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(1, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(0, 32) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(54872, 32);
	b <= conv_std_logic_vector(15236, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(39636, 32) and z_flag = '0' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-1, 32);
	b <= conv_std_logic_vector(-1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(0, 32) and z_flag = '1' and of_flag = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-2147483648, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(2147483647, 32) and z_flag = '0' and of_flag = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-2147483648, 32);
	b <= conv_std_logic_vector(5, 32);
	wait for 5 ns;
	assert r = conv_std_logic_vector(2147483643, 32) and z_flag = '0' and of_flag = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;


	-- SLL TEST --
	ctrl <= "000000";
	case_cnt <= 1;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	sll_test <= a(31 DOWNTO 0);
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	sll_test <= a(31 DOWNTO 0);
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	sll_test <= a(30 DOWNTO 0) & '0';
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	sll_test <= a(30 DOWNTO 0) & '0';
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(2, 32);
	wait for 5 ns;
	sll_test <= a(29 DOWNTO 0) & "00";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(3, 32);
	wait for 5 ns;
	sll_test <= a(28 DOWNTO 0) & "000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(4, 32);
	wait for 5 ns;
	sll_test <= a(27 DOWNTO 0) & "0000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(5, 32);
	wait for 5 ns;
	sll_test <= a(26 DOWNTO 0) & "00000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(6, 32);
	wait for 5 ns;
	sll_test <= a(25 DOWNTO 0) & "000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(7, 32);
	wait for 5 ns;
	sll_test <= a(24 DOWNTO 0) & "0000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(8, 32);
	wait for 5 ns;
	sll_test <= a(23 DOWNTO 0) & "00000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(9, 32);
	wait for 5 ns;
	sll_test <= a(22 DOWNTO 0) & "000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(10, 32);
	wait for 5 ns;
	sll_test <= a(21 DOWNTO 0) & "0000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(11, 32);
	wait for 5 ns;
	sll_test <= a(20 DOWNTO 0) & "00000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(12, 32);
	wait for 5 ns;
	sll_test <= a(19 DOWNTO 0) & "000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(13, 32);
	wait for 5 ns;
	sll_test <= a(18 DOWNTO 0) & "0000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(14, 32);
	wait for 5 ns;
	sll_test <= a(17 DOWNTO 0) & "00000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(15, 32);
	wait for 5 ns;
	sll_test <= a(16 DOWNTO 0) & "000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(16, 32);
	wait for 5 ns;
	sll_test <= a(15 DOWNTO 0) & "0000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(17, 32);
	wait for 5 ns;
	sll_test <= a(14 DOWNTO 0) & "00000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(18, 32);
	wait for 5 ns;
	sll_test <= a(13 DOWNTO 0) & "000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(19, 32);
	wait for 5 ns;
	sll_test <= a(12 DOWNTO 0) & "0000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(20, 32);
	wait for 5 ns;
	sll_test <= a(11 DOWNTO 0) & "00000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(21, 32);
	wait for 5 ns;
	sll_test <= a(10 DOWNTO 0) & "000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(22, 32);
	wait for 5 ns;
	sll_test <= a(9 DOWNTO 0) & "0000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(23, 32);
	wait for 5 ns;
	sll_test <= a(8 DOWNTO 0) & "00000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(24, 32);
	wait for 5 ns;
	sll_test <= a(7 DOWNTO 0) & "000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(25, 32);
	wait for 5 ns;
	sll_test <= a(6 DOWNTO 0) & "0000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(26, 32);
	wait for 5 ns;
	sll_test <= a(5 DOWNTO 0) & "00000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(27, 32);
	wait for 5 ns;
	sll_test <= a(4 DOWNTO 0) & "000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(28, 32);
	wait for 5 ns;
	sll_test <= a(3 DOWNTO 0) & "0000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(29, 32);
	wait for 5 ns;
	sll_test <= a(2 DOWNTO 0) & "00000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(30, 32);
	wait for 5 ns;
	sll_test <= a(1 DOWNTO 0) & "000000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(31, 32);
	wait for 5 ns;
	sll_test <= a(0 DOWNTO 0) & "0000000000000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(12546, 32);
	b <= conv_std_logic_vector(23, 32);
	wait for 5 ns;
	sll_test <= a(8 DOWNTO 0) & "00000000000000000000000";
	wait for 5 ns;
	assert r =  sll_test report "ERROR " & integer'image (case_cnt) & ": (SLL)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- SLT TEST --
	ctrl <= "101010";
	case_cnt <= 1;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(5, 32);
	b <= conv_std_logic_vector(5, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-5, 32);
	b <= conv_std_logic_vector(-5, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(12345, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(12546, 32);
	b <= conv_std_logic_vector(23, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(12345, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(23, 32);
	b <= conv_std_logic_vector(123456, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-40, 32);
	b <= conv_std_logic_vector(-60, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-60, 32);
	b <= conv_std_logic_vector(-40, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-123, 32);
	b <= conv_std_logic_vector(154, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(154, 32);
	b <= conv_std_logic_vector(-123, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-123456, 32);
	b <= conv_std_logic_vector(123456, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(123456, 32);
	b <= conv_std_logic_vector(-123456, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(2147483647, 32);
	b <= conv_std_logic_vector(-2147483648, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-2147483648, 32);
	b <= conv_std_logic_vector(2147483647, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLT)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- SLTU TEST --
	ctrl <= "101011";
	case_cnt <= 1;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(5, 32);
	b <= conv_std_logic_vector(5, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-5, 32);
	b <= conv_std_logic_vector(-5, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(1, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(12345, 32);
	b <= conv_std_logic_vector(0, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(12546, 32);
	b <= conv_std_logic_vector(23, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(1, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(0, 32);
	b <= conv_std_logic_vector(12345, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(23, 32);
	b <= conv_std_logic_vector(123456, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-40, 32);
	b <= conv_std_logic_vector(-60, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-60, 32);
	b <= conv_std_logic_vector(-40, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-123, 32);
	b <= conv_std_logic_vector(154, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(154, 32);
	b <= conv_std_logic_vector(-123, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-123, 32);
	b <= conv_std_logic_vector(123, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(123, 32);
	b <= conv_std_logic_vector(-123, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(2147483647, 32);
	b <= conv_std_logic_vector(-2147483648, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(1, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= conv_std_logic_vector(-2147483648, 32);
	b <= conv_std_logic_vector(2147483647, 32);
	wait for 5 ns;
	assert r =  conv_std_logic_vector(0, 32) report "ERROR " & integer'image (case_cnt) & ": (SLTU)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	wait;
 end process;
end behavioral;