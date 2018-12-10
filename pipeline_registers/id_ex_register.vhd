library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity id_ex_register is
	port (
		clk		: in std_logic;
		reset		: in std_logic;
		input_pc	: in std_logic_vector(31 downto 0);
		input_a		: in std_logic_vector(31 downto 0);
		input_b		: in std_logic_vector(31 downto 0);
		input_immediate	: in std_logic_vector(31 downto 0);
		output_pc	: out std_logic_vector(31 downto 0);
		output_a	: out std_logic_vector(31 downto 0);
		output_b	: out std_logic_vector(31 downto 0);
		output_immediate: out std_logic_vector(31 downto 0));

end id_ex_register;

architecture if_ex_logic of if_ex_register is

begin

	output_pc_loop: for i in 0 to 31 generate:
		dff_pc: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_pc(i), enable=>'1', q=>output_pc(i));
	end generate;

	output_a_loop: for i in 0 to 31 generate:
		dff_a: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_a(i), enable=>'1', q=>output_a(i));
	end generate;

	output_b_loop: for i in 0 to 31 generate:
		dff_b: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_b(i), enable=>'1', q=>output_b(i));
	end generate;

	output_immediate_loop: for i in 0 to 31 generate:
		dff_immediate: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_immediate(i), enable=>'1', q=>output_immediate(i));
	end generate;

end architecture;