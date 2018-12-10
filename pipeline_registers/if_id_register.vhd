library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity if_id_register is
	port (
		clk		: in std_logic;
		reset		: in std_logic;
		input_pc	: in std_logic_vector(31 downto 0);
		input_inst	: in std_logic_vector(31 downto 0);
		output_pc	: out std_logic_vector(31 downto 0); 
		output_inst	: out std_logic_vector(31 downto 0)
	);
end if_id_register;

architecture if_id_logic of if_id_register is

begin
	output_inst_loop: for i in 0 to 31 generate:
		dff_inst: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_inst(i), enable=>'1', q=>output_inst(i));
	end generate;
		
	output_pc_loop: for i in 0 to 31 generate:
		dff_pc: dffr_a
			port map(clk=>clk, arst =>reset, aload=>'0', adata=>'0', d=>input_pc(i), enable=>'1', q=>output_pc(i));
	end generate;

end architecture;
		
