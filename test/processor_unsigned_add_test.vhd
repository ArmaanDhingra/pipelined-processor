library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity processor_unsigned_add_test is
end entity processor_unsigned_add_test;

architecture behavioral of processor_unsigned_add_test is
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
		code			=>	"data/unsigned_sum.dat"
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

	-- Run Code
	wait for 160 ns;	-- Enough time to run the code

	-- Inspect memory manually to ensure code ran correctly
	wait until rising_edge(clk);
	manual_mem_inspect <= '1';
	manual_mem_inspect_addr <= x"10000028";
	wait until falling_edge(clk);
	assert data_mem_out = x"ffffffff" report "ERROR: Code did not execute correctly" severity error;

	wait;
  end process testbench;
end architecture behavioral;