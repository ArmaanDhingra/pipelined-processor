library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity register_file_test is
end entity register_file_test;

architecture behavioral of register_file_test is
	
	signal init		: std_logic;
	signal reg_wr_tb	: std_logic;
	signal reg_dst_tb	: std_logic_vector (4 downto 0); 
	signal rs_tb		: std_logic_vector (4 downto 0); 
	signal rt_tb 		: std_logic_vector (4 downto 0); 
	signal busW_tb		: std_logic_vector (31 downto 0); 
	signal clk_tb		: std_logic := '0';
	signal busA_tb		: std_logic_vector (31 downto 0); 
	signal busB_tb		: std_logic_vector (31 downto 0);

begin

	register_file_inst : register_file
		port map (
			init	=> init,
			reg_wr	=> reg_wr_tb,
			reg_dst	=> reg_dst_tb,
			rs	=> rs_tb,		 
			rt	=> rt_tb, 		
			busW	=> busW_tb,		
			clk	=> clk_tb,		
			busA	=> busA_tb,		
			busB	=> busB_tb
		);

	clk_process : process 
	begin
		while true loop
			wait for 10 ps;
			clk_tb <= not clk_tb;
		end loop;
	end process clk_process;

	write_process : process
	begin
		reg_wr_tb <= '1';
		wait until rising_edge(clk_tb);
		for i in 0 to 31 loop 
			reg_wr_tb <= '1';
			reg_dst_tb <= std_logic_vector(to_unsigned(i,5));
			busW_tb <= std_logic_vector(to_signed((i - 5), 32));
			wait until rising_edge(clk_tb);
			reg_wr_tb <= '0';
			wait until rising_edge(clk_tb);
		end loop;
		wait until rising_edge(clk_tb);
		wait;
	end process write_process;

	read_rs_process : process
	begin
		rs_tb <= (others => '0');
		wait until falling_edge(clk_tb);
		for i in 0 to 64 loop
			wait until rising_edge(clk_tb);
		end loop;
		
		for i in 0 to 15 loop
			rs_tb <= std_logic_vector(to_unsigned(i, 5));
			wait until rising_edge(clk_tb);
			wait until rising_edge(clk_tb);
			if (to_integer(signed(busA_tb)) /= (i - 5)) then
				report "ERROR in reading busA";
			end if;
		end loop;
		wait until rising_edge(clk_tb);
		wait;
	end process;

	read_rt_process : process
	begin
		rt_tb <= (others => '0');
		wait until falling_edge(clk_tb);
		for i in 0 to 64 loop
			wait until rising_edge(clk_tb);
		end loop; 
		for i in 16 to 31 loop
			rt_tb <= std_logic_vector(to_unsigned(i, 5));
			wait until rising_edge(clk_tb);
			wait until rising_edge(clk_tb);
			if (to_integer(signed(busB_tb)) /= (i - 5)) then
				report "ERROR in reading busB";
			end if;
		end loop;
		wait until rising_edge(clk_tb);
		wait;
	end process;
		
end architecture behavioral;

architecture init_test of register_file_test is
	
	signal init	: std_logic;
	signal reg_wr	: std_logic;
	signal reg_dst	: std_logic_vector (4 downto 0); 
	signal rs	: std_logic_vector (4 downto 0); 
	signal rt 	: std_logic_vector (4 downto 0); 
	signal busW	: std_logic_vector (31 downto 0); 
	signal clk	: std_logic := '0';
	signal busA	: std_logic_vector (31 downto 0); 
	signal busB	: std_logic_vector (31 downto 0);

begin

	register_file_inst : register_file
	port map (
		init	=>	init,
		reg_wr	=> 	reg_wr,
		reg_dst	=> 	reg_dst,
		rs	=> 	rs,		 
		rt	=> 	rt, 		
		busW	=> 	busW,		
		clk	=> 	clk,		
		busA	=> 	busA,		
		busB	=>	busB
	);

clk_process : process 
  begin
	while true loop
		wait for 10 ps;
		clk <= not clk;
	end loop;
end process clk_process;

test_process : process
  begin
	-- Reset register file
	init <= '1';
	wait for 5 ns;
	init <= '0';
	wait for 5 ns;

	-- Test registers are zero after reset
	rs <= "00000";
	rt <= "00001";
	reg_dst <= "10110";
	reg_wr <= '0';
	busW <= std_logic_vector(to_signed(5, 32));
	assert busA = std_logic_vector(to_signed(0, 32)) and busB = std_logic_vector(to_signed(0, 32)) report
	"ERROR: Registers did not reset correctly" severity error;
	wait for 5 ns;
  wait;
end process test_process;		
end architecture init_test;