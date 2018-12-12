library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all; 

entity ex_mem_register is 
	port (
		-- Inputs
		clk		: in std_logic;
		reset		: in std_logic;
		reg_bus_b	: in std_logic_vector (31 downto 0);
		ALU_result	: in std_logic_vector (31 downto 0);
		ALU_of		: in std_logic;
		ALU_zero	: in std_logic;
		MEM_data	: in std_logic_vector (31 downto 0);

		-- Outputs
		reg_bus_b_out	: out std_logic_vector (31 downto 0);
		ALU_result_out	: out std_logic_vector (31 downto 0);
		ALU_of_out	: out std_logic;
		ALU_zero_out	: out std_logic;
		MEM_data_out	: out std_logic_vector (31 downto 0)
	);
end ex_mem_register;

architecture structural of ex_mem_register is

begin

	dff_32_reg_bus_b : for i in 0 to 31 generate
		dff_bus_inst : dffr_a
			port map ( 
				clk	=>	clk,
				arst	=>	reset,
				aload	=>	'0',
				adata	=>	'0',
				d	=>	reg_bus_b(i),
				enable	=>	'1',
				q	=>	reg_bus_b_out(i)
				);
	end generate dff_32_reg_bus_b;

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

	dff_ALU_of_inst : dffr_a
		port map ( 
			clk	=>	clk,
			arst	=>	reset,
			aload	=>	'0',
			adata	=>	'0',
			d	=>	ALU_of,
			enable	=>	'1',
			q	=>	ALU_of_out
			);

	dff_ALU_zero_inst : dffr_a
		port map ( 
			clk	=>	clk,
			arst	=>	reset,
			aload	=>	'0',
			adata	=>	'0',
			d	=>	ALU_zero,
			enable	=>	'1',
			q	=>	ALU_zero_out
			);

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