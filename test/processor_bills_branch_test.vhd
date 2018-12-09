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

	signal pc 			: std_logic_vector (31 downto 0);
	signal instruction		: std_logic_vector (31 downto 0);
	signal take_branch		: std_logic;
		
	-- Control signals
	signal alu_op			: std_logic_vector (5 downto 0);
	signal mem_to_reg		: std_logic;
	signal reg_wrt			: std_logic;
	signal mem_wrt			: std_logic;
	signal branch			: std_logic;
	signal sign_extend		: std_logic;	-- sign extend = 1, zero extend = 0
	signal use_imm			: std_logic;	-- use immediate = 1, use registers = 0
	signal use_sa			: std_logic;	-- use shamt = 1

	-- ALU
	signal immediate_extended	: std_logic_vector (31 downto 0);
	signal shamt_extended		: std_logic_vector (31 downto 0);
	signal alu_b_reg_imm		: std_logic_vector (31 downto 0);
	signal alu_a			: std_logic_vector (31 downto 0);
	signal alu_b			: std_logic_vector (31 downto 0);
	signal alu_r			: std_logic_vector (31 downto 0);
	signal of_flag			: std_logic;
	signal z_flag			: std_logic;

	-- Register
	signal rs			: std_logic_vector (4 downto 0); 
	signal rt			: std_logic_vector (4 downto 0); 
	signal rd			: std_logic_vector (4 downto 0);
	signal reg_bus_a		: std_logic_vector (31 downto 0);
	signal reg_bus_b		: std_logic_vector (31 downto 0);
	signal reg_bus_wrt		: std_logic_vector (31 downto 0);
	
	-- Data Memory
	signal manual_mem_inspect	: std_logic;
	signal manual_mem_inspect_addr	: std_logic_vector (31 downto 0);
	signal data_mem_out		: std_logic_vector (31 downto 0);

begin

test_comp : processor
	generic map (
		code			=>	"data/bills_branch.dat"
	)
	port map (
		init			=>	init,
		pc_init_data		=>	pc_init_data,
		clk			=>	clk,
		-- Flow control
		pc_ins			=>	pc,
		instruction_ins		=>	instruction,
		take_branch_ins		=>	take_branch,
			
		-- Control signals
		alu_op_ins		=>	alu_op,
		mem_to_reg_ins		=>	mem_to_reg,
		reg_wrt_ins		=>	reg_wrt,
		mem_wrt_ins		=>	mem_wrt,
		branch_ins		=>	branch,
		sign_extend_ins		=>	sign_extend,
		use_imm_ins		=>	use_imm,
		use_sa_ins		=>	use_sa,
	
		-- ALU;
	 	immediate_extended_ins	=>	immediate_extended,
		shamt_extended_ins	=>	shamt_extended,
		alu_b_reg_imm_ins	=>	alu_b_reg_imm,
		alu_a_ins		=>	alu_a,
		alu_b_ins		=>	alu_b,
		alu_r_ins		=>	alu_r,
		of_flag_ins		=>	of_flag,
		z_flag_ins		=>	z_flag,
	
		-- Register
		rs_ins			=>	rs,
		rt_ins			=>	rt,
		rd_ins			=>	rd,
		reg_bus_a_ins		=>	reg_bus_a,
		reg_bus_b_ins		=>	reg_bus_b,
		reg_bus_wrt_ins		=>	reg_bus_wrt,

		-- Data Memory
		manual_mem_inspect	=>	manual_mem_inspect,
		manual_mem_inspect_addr	=>	manual_mem_inspect_addr,
		data_mem_out_ins	=>	data_mem_out
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
	-- Initialize processor (pc init and registers reset and no manual memory inspection)
	manual_mem_inspect <= '0';
	init <= '1';
	pc_init_data <= x"00400020";
	wait until  rising_edge(clk);
	init <= '0';
	wait until falling_edge(clk);

	-- Run Code
	wait for 170 ns;	-- Enough time to run the code

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