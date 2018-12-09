library ieee;
use ieee.std_logic_1164.all;
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

entity alu_1_test is
end alu_1_test;

architecture behavioral of alu_1_test is

signal ctrl	: std_logic_vector (2 downto 0);
signal cin	: std_logic;
signal a	: std_logic;
signal b	: std_logic;
signal r	: std_logic;
signal cout	: std_logic;
signal case_cnt	: integer;

begin
test_comp : alu_1
	port map (
		ctrl	=>	ctrl,
		cin	=>	cin,
		a	=>	a,
		b	=>	b,
		r	=>	r,
		cout	=>	cout
	);
testbench : process
 begin

	-- ADD TEST --
	ctrl <= "000";
	case_cnt <= 1;

	a <= '0';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- ADDU TEST --
	ctrl <= "001";
	case_cnt <= 1;

	a <= '0';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (ADD)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- SUB TEST --
	ctrl <= "010";
	case_cnt <= 1;

	a <= '0';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- SUBU TEST --
	ctrl <= "011";
	case_cnt <= 1;

	a <= '0';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '0';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	cin <= '1';
	wait for 5 ns;
	assert r = '1' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '0';
	wait for 5 ns;
	assert r = '1' and cout = '0' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	cin <= '1';
	wait for 5 ns;
	assert r = '0' and cout = '1' report "ERROR " & integer'image (case_cnt) & ": (SUB)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;


	-- AND TEST --
	ctrl <= "100";
	case_cnt <= 1;

	a <= '0';
	b <= '0';
	wait for 5 ns;
	assert r = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	wait for 5 ns;
	assert r = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	wait for 5 ns;
	assert r = '0' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	wait for 5 ns;
	assert r = '1' report "ERROR " & integer'image (case_cnt) & ": (AND)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	-- OR TEST --
	ctrl <= "101";
	case_cnt <= 1;

	a <= '0';
	b <= '0';
	wait for 5 ns;
	assert r = '0' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '0';
	b <= '1';
	wait for 5 ns;
	assert r = '1' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '0';
	wait for 5 ns;
	assert r = '1' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	a <= '1';
	b <= '1';
	wait for 5 ns;
	assert r = '1' report "ERROR " & integer'image (case_cnt) & ": (OR)" severity error;
	case_cnt <= case_cnt + 1;
	wait for 5 ns;

	wait;
 end process;
end behavioral;