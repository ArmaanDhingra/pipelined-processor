library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use work.eecs361.all;
use work.eecs361_gates.all;

--INST	OPCODE	DEC	SPECIAL
--ADD	000000	0	100000
--ADDU	000000	0	100001
--SUB	000000	0	100010
--SUBU	000000	0	100011
--AND	000000	0	100100
--OR	000000	0	100101
--SLT	000000	0	101010
--SLTU	000000	0	101011
--SLL	000000	0	000000
--ADDI	001000	8
--LW	100011	35
--SW	101011	43
--BEQ	000100	4
--BNE	000101	5
--BGTZ	000111	7

entity branch_resolver_test is
end branch_resolver_test;

architecture behavioral of branch_resolver_test is

	signal branch		: std_logic;
	signal opcode		: std_logic_vector (5 downto 0);
	signal z_flag		: std_logic;
	signal s_flag		: std_logic;
	signal take_branch	: std_logic;
	
	signal take_branch_logic: std_logic;

begin
test_comp : branch_resolver
	port map (
		branch		=>	branch,
		opcode		=>	opcode,
		z_flag		=>	z_flag,
		s_flag		=>	s_flag,
		take_branch	=>	take_branch
	);
testbench : process
 begin

	branch <= '0';
	for i in 0 to (2**6 - 1) loop
		opcode <= conv_std_logic_vector (i, 6);
		z_flag <= '0';
		s_flag <= '0';
		wait for 5 ns;
		assert take_branch = '0' report "ERROR branch = 0 at i = " & integer'image (i) severity error;

		z_flag <= '0';
		s_flag <= '1';
		wait for 5 ns;
		assert take_branch = '0' report "ERROR branch = 0 at i = " & integer'image (i) severity error;

		z_flag <= '1';
		s_flag <= '0';
		wait for 5 ns;
		assert take_branch = '0' report "ERROR branch = 0 at i = " & integer'image (i) severity error;

		z_flag <= '1';
		s_flag <= '1';
		wait for 5 ns;
		assert take_branch = '0' report "ERROR branch = 0 at i = " & integer'image (i) severity error;
	end loop;

	branch <= '1';
	for i in 0 to (2**6 - 1) loop
		opcode <= conv_std_logic_vector (i, 6);

		z_flag <= '0';
		s_flag <= '0';
		wait for 5 ns;
		take_branch_logic <= 	((not opcode(1)) and (not opcode(0)) and (z_flag)) or
					((not opcode(1)) and (opcode(0)) and (not z_flag)) or
					((opcode(1)) and (opcode(0)) and (not z_flag) and (not s_flag));
		wait for 5 ns;
		assert take_branch = take_branch_logic report "ERROR branch = 1 at i = " & integer'image (i) severity error;

		z_flag <= '0';
		s_flag <= '1';
		wait for 5 ns;
		take_branch_logic <= 	((not opcode(1)) and (not opcode(0)) and (z_flag)) or
					((not opcode(1)) and (opcode(0)) and (not z_flag)) or
					((opcode(1)) and (opcode(0)) and (not z_flag) and (not s_flag));
		wait for 5 ns;
		assert take_branch = take_branch_logic report "ERROR branch = 1 at i = " & integer'image (i) severity error;


		z_flag <= '1';
		s_flag <= '0';
		wait for 5 ns;
		take_branch_logic <= 	((not opcode(1)) and (not opcode(0)) and (z_flag)) or
					((not opcode(1)) and (opcode(0)) and (not z_flag)) or
					((opcode(1)) and (opcode(0)) and (not z_flag) and (not s_flag));
		wait for 5 ns;
		assert take_branch = take_branch_logic report "ERROR branch = 1 at i = " & integer'image (i) severity error;


		z_flag <= '1';
		s_flag <= '1';
		wait for 5 ns;
		take_branch_logic <= 	((not opcode(1)) and (not opcode(0)) and (z_flag)) or
					((not opcode(1)) and (opcode(0)) and (not z_flag)) or
					((opcode(1)) and (opcode(0)) and (not z_flag) and (not s_flag));
		wait for 5 ns;
		assert take_branch = take_branch_logic report "ERROR branch = 1 at i = " & integer'image (i) severity error;


	end loop;

	wait;
 end process;
end behavioral;