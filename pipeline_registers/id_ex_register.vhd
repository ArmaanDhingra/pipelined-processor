library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity id_ex_register is
	port (
		clk			: in std_logic;
		reset			: in std_logic;
		input_pc		: in std_logic_vector(31 downto 0);
		input_a			: in std_logic_vector(31 downto 0);
		input_b			: in std_logic_vector(31 downto 0);
		input_immediate		: in std_logic_vector(31 downto 0);
		input_shamt_extended	: in std_logic_vector(31 downto 0);
		input_instruction	: in std_logic_vector(31 downto 0);
		input_alu_op		: in std_logic_vector(5 downto 0);		
		output_pc		: out std_logic_vector(31 downto 0);
		output_a		: out std_logic_vector(31 downto 0);
		output_b		: out std_logic_vector(31 downto 0);
		output_immediate	: out std_logic_vector(31 downto 0);
		output_shamt_extended	: out std_logic_vector(31 downto 0);
		output_instruction	: out std_logic_vector(31 downto 0);
		output_alu_op		: out std_logic_vector(5 downto 0)
	);

end id_ex_register;

architecture id_ex_logic of id_ex_register is

begin

	output_pc_loop: for i in 0 to 31 generate
		dff_pc: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_pc(i), enable=>'1', q=>output_pc(i));
	end generate;

	output_a_loop: for i in 0 to 31 generate
		dff_a: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_a(i), enable=>'1', q=>output_a(i));
	end generate;

	output_b_loop: for i in 0 to 31 generate
		dff_b: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_b(i), enable=>'1', q=>output_b(i));
	end generate;

	output_immediate_loop: for i in 0 to 31 generate
		dff_immediate: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_immediate(i), enable=>'1', q=>output_immediate(i));
	end generate;

	output_shamt_extended_loop: for i in 0 to 31 generate
		dff_shamt_extended: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_shamt_extended(i), enable=>'1', q=>output_shamt_extended(i));
	end generate;

	output_instruction_loop: for i in 0 to 31 generate
		dff_instruction: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_instruction(i), enable=>'1', q=>output_instruction(i));
	end generate;

	output_alu_op_loop: for i in 0 to 5 generate
		dff_alu_op: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_alu_op(i), enable=>'1', q=>output_alu_op(i));
	end generate;

end architecture;