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

entity instruction_decoder_test is
end instruction_decoder_test;

architecture behavioral of instruction_decoder_test is

signal instruction	: std_logic_vector (31 downto 0);
signal rs		: std_logic_vector (4 downto 0); 
signal rt		: std_logic_vector (4 downto 0); 
signal rd		: std_logic_vector (4 downto 0);
signal alu_op		: std_logic_vector (5 downto 0);
signal mem_to_reg	: std_logic;
signal reg_wrt		: std_logic;
signal mem_wrt		: std_logic;
signal branch		: std_logic;
signal sign_extend	: std_logic;	-- sign extend = 1, zero extend = 0
signal use_imm		: std_logic;	-- use immediate = 1, use registers = 0
signal use_sa		: std_logic;	-- use shamt = 1

begin
test_comp : instruction_decoder
	port map (
		instruction	=>	instruction,
		rs		=>	rs,
		rt		=>	rt,
		rd		=>	rd,
		alu_op		=>	alu_op,
		mem_to_reg	=>	mem_to_reg,
		reg_wrt		=>	reg_wrt,
		mem_wrt		=>	mem_wrt,
		branch		=>	branch,
		sign_extend	=>	sign_extend,
		use_imm		=>	use_imm,
		use_sa		=>	use_sa
	);
testbench : process
 begin
	-- ADD TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000100000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "100000"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' 
		report "ERROR ADD" severity error;
	wait for 5 ns;

	-- ADDU TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000100001";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "100001"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' 
		report "ERROR ADDU" severity error;
	wait for 5 ns;

	-- SUB TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000100010";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "100010"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' 
		report "ERROR SUB" severity error;
	wait for 5 ns;

	-- SUBU TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000100011";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "100011"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' 
		report "ERROR SUBU" severity error;
	wait for 5 ns;

	-- AND TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000100100";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "100100"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' 
		report "ERROR AND" severity error;
	wait for 5 ns;

	-- OR TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000100101";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "100101"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' and use_sa = '0'
		report "ERROR OR" severity error;
	wait for 5 ns;

	-- SLT TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000101010";
		wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "101010"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' and use_sa = '0'
		report "ERROR SLT" severity error;
	wait for 5 ns;


	-- SLTU TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000101011";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "101011"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' and use_sa = '0'
		report "ERROR SLTU" severity error;
	wait for 5 ns;

	-- SLL TEST --
	--		      |rs  |rt	|rd  |sha |func	
	instruction <= "00000001010101011111100000000000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "11111" and 
		alu_op = "000000"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '0' and use_imm = '0' and use_sa = '1'
		report "ERROR SLL" severity error;
	wait for 5 ns;

	-- ADDI TEST --
	--		      |rs  |rt	|immediate	
	instruction <= "00100001010101011111100000000000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "10101" and 
		alu_op = "100000"  and
		mem_to_reg = '0' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '1' and use_imm = '1' and use_sa = '0'
		report "ERROR ADDI" severity error;
	wait for 5 ns;

	-- LW TEST --
	--		      |rs  |rt	|immediate	
	instruction <= "10001101010101011111100000000000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and rd = "10101" and 
		alu_op = "100000"  and
		mem_to_reg = '1' and reg_wrt = '1' and mem_wrt = '0' and
		branch = '0' and sign_extend = '1' and use_imm = '1' and use_sa = '0'
		report "ERROR LW" severity error;
	wait for 5 ns;

	-- SW TEST --
	--		      |rs  |rt	|immediate	
	instruction <= "10101101010101011111100000000000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and 
		alu_op = "100000"  and
		mem_to_reg = '0' and reg_wrt = '0' and mem_wrt = '1' and
		branch = '0' and sign_extend = '1' and use_imm = '1' and use_sa = '0'
		report "ERROR SW" severity error;
	wait for 5 ns;

	-- BEQ TEST --
	--		      |rs  |rt	|immediate	
	instruction <= "00010001010101011111100000000000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and 
		alu_op = "100010"  and
		mem_to_reg = '0' and reg_wrt = '0' and mem_wrt = '0' and
		branch = '1' and sign_extend = '1' and use_imm = '0' and use_sa = '0'
		report "ERROR BEQ" severity error;
	wait for 5 ns;

	-- BNE TEST --
	--		      |rs  |rt	|immediate	
	instruction <= "00010101010101011111100000000000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "10101" and 
		alu_op = "100010"  and
		mem_to_reg = '0' and reg_wrt = '0' and mem_wrt = '0' and
		branch = '1' and sign_extend = '1' and use_imm = '0' and use_sa = '0'
		report "ERROR BNE" severity error;
	wait for 5 ns;

	-- BGTZ TEST --
	--		      |rs  |rt	|immediate	
	instruction <= "00011101010101011111100000000000";
	wait for 5 ns;
	assert 	rs = "01010" and rt = "00000" and 
		alu_op = "100010"  and
		mem_to_reg = '0' and reg_wrt = '0' and mem_wrt = '0' and
		branch = '1' and sign_extend = '1' and use_imm = '0' and use_sa = '0'
		report "ERROR BGTZ" severity error;
	wait for 5 ns;
	
	wait;
 end process;
end behavioral;