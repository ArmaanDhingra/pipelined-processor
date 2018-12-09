library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all; 

entity mem_wb_register is 
	port (
		-- Inputs
		clk		: in std_logic;
		reset		: in std_logic;
		ALU_result	: in std_logic_vector (31 downto 0);
		MEM_data	: in std_logic_vector (31 downto 0);

		-- Outputs
		ALU_result_out	: out std_logic_vector (31 downto 0);
		MEM_data_out	: out std_logic_vector (31 downto 0)
	);
end mem_wb_register;

architecture structural of mem_wb_register is

begin

	dff_32_ALU_result : for i in 0 to 31 generate
		dff_ALU_inst : dffr_a
			port map ( 
				clk	=>	clk,
				arst	=>	reset,
				aload	=>	'0',
				adata	=>	'0',
				d	=>	ALU_result(i),
				enable	=>	'1',
				q	=>	ALU_result_out(i)
				);
	end generate dff_32_ALU_result;

	dff_32_MEM : for i in 0 to 31 generate
		dff_MEM_inst : dffr_a
			port map ( 
				clk	=>	clk,
				arst	=>	reset,
				aload	=>	'0',
				adata	=>	'0',
				d	=>	MEM_data(i),
				enable	=>	'1',
				q	=>	MEM_data_out(i)
				);
	end generate dff_32_MEM;

end architecture structural;