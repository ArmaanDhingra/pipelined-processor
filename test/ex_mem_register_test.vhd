library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all; 
use ieee.numeric_std.all;

-- Run 35 ns

entity ex_mem_register_tb is
end entity ex_mem_register_tb;

architecture tb of ex_mem_register_tb is

	-- Signals 
	signal clk		: std_logic := '0';
	signal reset		: std_logic := '0';
	signal ALU_result	: std_logic_vector (31 downto 0) := (others => '0');
	signal ALU_of		: std_logic := '1';
	signal ALU_zero		: std_logic := '1';
	signal data_to_mem	: std_logic_vector (31 downto 0) := (others => '0');
	signal ALU_result_out	: std_logic_vector (31 downto 0) := (others => '0');
	signal ALU_of_out	: std_logic := '0';
	signal ALU_zero_out	: std_logic := '1';
	signal data_to_mem_out	: std_logic_vector (31 downto 0) := (others => '0');
	signal i		: integer := 0;
begin

	ex_mem_register_inst : ex_mem_register
		port map (
			clk		=> clk,
			reset		=> reset,
			ALU_result	=> ALU_result,
			ALU_of		=> ALU_of,
			ALU_zero	=> ALU_zero,
			data_to_mem	=> data_to_mem,
			ALU_result_out	=> ALU_result_out,
			ALU_of_out	=> ALU_of_out,
			ALU_zero_out	=> ALU_zero_out,
			data_to_mem_out	=> data_to_mem_out
			);
		
	clk_process : process
	begin
		while true loop
			clk <= not clk;
			wait for 5 ns;
		end loop;
	end process clk_process;
	
	stimulus : process
	begin
		-- Toggle reset
		reset <= '1';
		wait for 5 ns;
		reset <= '0';
		wait for 1 ns;
		
		i <= 3;
		wait for 1 ns;
		-- Set inputs
		ALU_result <= std_logic_vector(to_unsigned(i + 3, 32));
		ALU_of <= not ALU_of;
		ALU_zero <= not ALU_zero;
		data_to_mem <= std_logic_vector(to_unsigned(i + 5, 32));
		wait for 1 ns;

		-- Make sure outputs weren't changed
		assert ALU_result_out = std_logic_vector(to_unsigned(0, 32)) report "ERROR: ALU result passing through even not rising edge" severity error;
		assert ALU_of_out = (not ALU_of) report "ERROR: ALU overflow passing through even not rising edge" severity error;
		assert ALU_zero_out = (not ALU_zero) report "ERROR: ALU zero passing through even not rising edge" severity error;
		assert data_to_mem_out = std_logic_vector(to_unsigned(0, 32)) report "ERROR: Memory data passing through even not rising edge" severity error;

		-- Make sure outputs are changed
		if (rising_edge(clk)) then
			assert ALU_result_out = ALU_result report "ERROR: ALU result passing through even not rising edge" severity error;
			assert ALU_of_out = ALU_of report "ERROR: ALU overflow passing through even not rising edge" severity error;
			assert ALU_zero_out = ALU_zero report "ERROR: ALU zero passing through even not rising edge" severity error;
			assert data_to_mem_out = data_to_mem report "ERROR: Memory data passing through even not rising edge" severity error;
		end if;

		wait for 5 ns;
		i <= 4;
		wait for 1 ns;
		-- Set inputs
		ALU_result <= std_logic_vector(to_unsigned(i + 3, 32));
		ALU_of <= not ALU_of;
		ALU_zero <= not ALU_zero;
		data_to_mem <= std_logic_vector(to_unsigned(i + 5, 32));
		wait for 1 ns;

		-- Make sure outputs weren't changed
		assert ALU_result_out = std_logic_vector(to_unsigned(i + 2, 32)) report "ERROR: ALU result passing through even not rising edge" severity error;
		assert ALU_of_out = (not ALU_of) report "ERROR: ALU overflow passing through even not rising edge" severity error;
		assert ALU_zero_out = (not ALU_zero) report "ERROR: ALU zero passing through even not rising edge" severity error;
		assert data_to_mem_out = std_logic_vector(to_unsigned(i + 4, 32)) report "ERROR: Memory data passing through even not rising edge" severity error;

		-- Make sure outputs are changed
		if (rising_edge(clk)) then
			assert ALU_result_out = ALU_result report "ERROR: ALU result passing through even not rising edge" severity error;
			assert ALU_of_out = ALU_of report "ERROR: ALU overflow passing through even not rising edge" severity error;
			assert ALU_zero_out = ALU_zero report "ERROR: ALU zero passing through even not rising edge" severity error;
			assert data_to_mem_out = data_to_mem report "ERROR: Memory data passing through even not rising edge" severity error;
		end if;

		wait for 5 ns;
		i <= 5;
		wait for 1 ns;
		-- Set inputs
		ALU_result <= std_logic_vector(to_unsigned(i + 3, 32));
		ALU_of <= not ALU_of;
		ALU_zero <= not ALU_zero;
		data_to_mem <= std_logic_vector(to_unsigned(i + 5, 32));
		wait for 1 ns;

		-- Make sure outputs weren't changed
		assert ALU_result_out = std_logic_vector(to_unsigned(i + 2, 32)) report "ERROR: ALU result passing through even not rising edge" severity error;
		assert ALU_of_out = (not ALU_of) report "ERROR: ALU overflow passing through even not rising edge" severity error;
		assert ALU_zero_out = (not ALU_zero) report "ERROR: ALU zero passing through even not rising edge" severity error;
		assert data_to_mem_out = std_logic_vector(to_unsigned(i + 4, 32)) report "ERROR: Memory data passing through even not rising edge" severity error;

		-- Make sure outputs are changed
		if (rising_edge(clk)) then
			assert ALU_result_out = ALU_result report "ERROR: ALU result passing through even not rising edge" severity error;
			assert ALU_of_out = ALU_of report "ERROR: ALU overflow passing through even not rising edge" severity error;
			assert ALU_zero_out = ALU_zero report "ERROR: ALU zero passing through even not rising edge" severity error;
			assert data_to_mem_out = data_to_mem report "ERROR: Memory data passing through even not rising edge" severity error;
		end if;

		wait;
		assert false;

	end process stimulus;

end architecture tb;