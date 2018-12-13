library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity processor_bills_branch_test is
end entity processor_bills_branch_test;

architecture behavioral of processor_bills_branch_test is
	signal init			: std_logic;				-- Set pc to pc_init_data if pc_init is set
	signal pc_init_data		: std_logic_vector (31 downto 0);	-- Initial value for program counter
	signal clk			: std_logic := '0';

	-- Data Memory
	signal manual_mem_inspect	: std_logic;
	signal manual_mem_inspect_addr	: std_logic_vector (31 downto 0);
	signal data_mem_out		: std_logic_vector (31 downto 0);
	
	signal clk_cnt			: integer := -1;
begin

test_comp : processor
	generic map (
		code			=>	"data/bills_branch.dat"
	)
	port map (
		init			=>	init,
		pc_init_data		=>	pc_init_data,
		clk			=>	clk,

		-- Data Memory
		manual_mem_inspect	=>	manual_mem_inspect,
		manual_mem_inspect_addr	=>	manual_mem_inspect_addr,
		data_mem_out_ins	=>	data_mem_out
	);

clk_process : process 
begin
	while true loop
		if (clk = '1') then
			clk_cnt <= clk_cnt + 1;
		end if;
		wait for 1 ns;
		clk <= not clk;
	end loop;
end process clk_process;

testbench : process
  begin
	-- Initialize processor (pc init and registers reset and no manual memory inspection)
	manual_mem_inspect <= '0';
	init <= '1';
	pc_init_data <= x"00400020";
	wait until  rising_edge(clk);
	init <= '0';
	wait until falling_edge(clk);

	-- Run Code
	wait for 300 ns;	-- Enough time to run the code

-- Inspect memory manually to ensure code ran correctly
	manual_mem_inspect <= '1';
	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000000";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000004";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000008";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"1000000c";
	wait until falling_edge(clk);
	assert data_mem_out = x"000002bc" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000010";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000014";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000018";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000190" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"1000001c";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;

	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000020";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;
	
	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000024";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000000" report "ERROR: Code did not execute correctly" severity error;
	
	wait until rising_edge(clk);
	manual_mem_inspect_addr <= x"10000028";
	wait until falling_edge(clk);
	assert data_mem_out = x"00000038" report "ERROR: Code did not execute correctly" severity error;

	wait;
  end process testbench;
end architecture behavioral;