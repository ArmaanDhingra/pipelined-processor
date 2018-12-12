library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity pc_controller_test is
end entity pc_controller_test;

architecture behavioral of pc_controller_test is

	signal pc_init			: std_logic;
	signal pc_init_data		: std_logic_vector (31 downto 0);
	signal clk			: std_logic := '0';
	signal immediate_extended	: std_logic_vector (31 downto 0);
	signal take_branch		: std_logic;
	signal pc			: std_logic_vector (31 downto 0);
	signal stall			: std_logic;	

	signal pc_compare		: integer;

begin

test_comp : pc_controller
	port map (
		pc_init			=>	pc_init,
		pc_init_data		=>	pc_init_data,
		clk			=>	clk,
		immediate_extended	=>	immediate_extended,
		take_branch		=>	take_branch,
		stall			=>	stall,
		pc			=>	pc
	);

clk_process : process 
begin
	while true loop
		wait for 1 ns;
		clk <= not clk;
	end loop;
end process clk_process;

testbench : process
  begin
	-- Initialize signals and program counter
	pc_init <= '1';
	pc_init_data <= x"00400020";
	stall <= '0';
	wait for 5 ns;
	assert 	pc = pc_init_data report "ERROR: PC did not initialize" severity error;

	-- Test pc doesn't change for 20 cycles while pc_init is set
	wait until falling_edge(clk);	
	for i in 0 to 20 loop
		assert 	pc = pc_init_data report "ERROR: PC not held steady" severity error;
		wait until falling_edge(clk);	
	end loop;

	-- Consecutive flow (pc + 4)
	immediate_extended <= std_logic_vector(to_signed(20,32));
	take_branch <= '0';
	pc_compare <= 4194336;	-- pc_compare = 0x00400020
	wait until falling_edge(clk);	
	pc_init <= '0';

	for i in 0 to 100 loop
		assert 	pc = std_logic_vector(to_signed(pc_compare,32)) report "ERROR: Consecutive flow" severity error;
		wait until rising_edge(clk);
		pc_compare <= pc_compare + 4;
	end loop;

	-- Branch flow
	take_branch <= '1';
	wait until falling_edge(clk);	

	for i in 0 to 100 loop
		assert 	pc = std_logic_vector(to_signed(pc_compare,32)) report "ERROR: Branch flow" severity error;
		wait until rising_edge(clk);
		pc_compare <= pc_compare + 4 + (to_integer(signed(immediate_extended)) * 4);
	end loop;

	-- Consecutive flow after branch flow
	take_branch <= '0';
	wait until falling_edge(clk);	

	for i in 0 to 100 loop
		assert 	pc = std_logic_vector(to_signed(pc_compare,32)) report "ERROR: Consecutive flow after branch flow" severity error;
		wait until rising_edge(clk);
		pc_compare <= pc_compare + 4;
	end loop;

	-- Stall
	stall <= '1';
	wait for 5 ns;
	assert 	pc = std_logic_vector(to_signed(pc_compare,32)) report "ERROR: PC did not stall" severity error;

	-- Increment after stall
	pc_init <= '0';
	pc_compare <= pc_compare + 4;
	wait until falling_edge(clk);
	stall <= '0';
 	wait until rising_edge(clk);
	wait until falling_edge (clk);
	assert 	pc = std_logic_vector(to_signed(pc_compare,32)) report "ERROR: PC did not add correctly after stall" severity error;
	wait until rising_edge (clk);
	wait until falling_edge (clk);

	-- Reinitialize program counter
	pc_init <= '1';
	wait for 5 ns;
	assert 	pc = pc_init_data report "ERROR: PC did not reinitialize" severity error;


	wait;
  end process testbench;
end architecture behavioral;