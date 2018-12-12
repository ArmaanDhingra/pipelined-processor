library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.eecs361_gates.all;
use work.eecs361.all;

-- run -all

entity forwarding_unit_tb is
end entity forwarding_unit_tb;

architecture tb of forwarding_unit_tb is

	-- Component signals
	signal rs_ID_EX		: std_logic_vector (4 downto 0) := (others => '0');
	signal rt_ID_EX		: std_logic_vector (4 downto 0) := (others => '0'); 
	signal use_imm_ID_EX	: std_logic := '0'; -- Flag, do not forward Rt
	signal use_sa_ID_EX	: std_logic := '0'; -- Flag, do not forward Rt
	signal rd_EX_MEM	: std_logic_vector (4 downto 0) := (others => '0'); 
	signal reg_wrt_EX_MEM	: std_logic := '0';
	signal reg_wrt_MEM_WB	: std_logic := '0';
	signal rd_MEM_WB	: std_logic_vector (4 downto 0) := (others => '0');
	signal forward_rs	: std_logic_vector (1 downto 0) := (others => '0'); 
	signal forward_rt	: std_logic_vector (1 downto 0) := (others => '0');

begin

	forwarding_unit_inst : forwarding_unit
		port map (
			rs_ID_EX	=> rs_ID_EX,
			rt_ID_EX	=> rt_ID_EX,
			use_imm_ID_EX	=> use_imm_ID_EX,	
			use_sa_ID_EX	=> use_sa_ID_EX,
			rd_EX_MEM	=> rd_EX_MEM,
			reg_wrt_EX_MEM	=> reg_wrt_EX_MEM,
			reg_wrt_MEM_WB	=> reg_wrt_MEM_WB,	
			rd_MEM_WB	=> rd_MEM_WB,
			forward_rs	=> forward_rs,	 
			forward_rt	=> forward_rt	
			);

	stimulus : process
	begin
	-- Iterate through every possible value for rs, rt, and rd
	for ii in 0 to 31 loop -- rs
		rs_ID_EX <= std_logic_vector(to_unsigned(ii, 5));
		for jj in 0 to 31 loop -- rt
			rt_ID_EX <= std_logic_vector(to_unsigned(jj, 5));
			for kk in 0 to 31 loop -- EX/MEM rd
				rd_EX_MEM <= std_logic_vector(to_unsigned(kk, 5));
				for ww in 0 to 31 loop -- MEM/WB rd
					rd_MEM_WB <= std_logic_vector(to_unsigned(ww, 5));

					-- Check if addi means no forwarding
					use_imm_ID_EX <= '1';
					use_sa_ID_EX <= '0';
					wait for 5 ns;
					assert 	forward_rt = "00" report "ERROR: Forwarding unit does not use immediate value" severity error;
					wait for 5 ns;

					-- Check if shift means no forwarding
					use_imm_ID_EX <= '0';
					use_sa_ID_EX <= '1';
					wait for 5 ns;
					assert 	forward_rt = "00" report "ERROR: Forwarding unit does not use shift value" severity error;
					wait for 5 ns;

					use_imm_ID_EX <= '0';
					use_sa_ID_EX <= '0';

					-- Toggle reg_wrt_EX_MEM
					reg_wrt_EX_MEM <= '1';
					reg_wrt_MEM_WB <= '0';
					wait for 5 ns;
					if (ii = kk) then
						assert forward_rs = "10" report "ERROR: Not forwarding from EX_MEM to rs" severity error;
					end if;
					if (jj = kk) then
						assert forward_rt = "10" report "ERROR: Not forwarding from EX_MEM to rt" severity error;
					end if;
					wait for 5 ns;
					-- No writing to registers so no forwarding
					reg_wrt_EX_MEM <= '0';
					wait for 5 ns;
					if (ii = kk) then
						assert forward_rs = "00" report "ERROR: both reg_wrt low, should not forward to rs" severity error;
					end if;
					if (jj = kk) then
						assert forward_rt = "00" report "ERROR: both reg_wrt low, should not forward to rt" severity error;
					end if;
					wait for 5 ns;
					-- Toggle reg_wrt_MEM_WB
					reg_wrt_MEM_WB <= '1';
					wait for 5 ns;
					if (ii = ww) then
						assert forward_rs = "01" report "ERROR: Not forwarding from MEM_WB to rs" severity error;
					end if;
					if (jj = ww) then
						assert forward_rt = "01" report "ERROR: Not forwarding from MEM_WB to rt" severity error;
					end if;
					wait for 5 ns;
					-- Both reg_wrt on, choose EX_MEM
					reg_wrt_EX_MEM <= '1';
					wait for 5 ns;
					if (ii = kk) then
						assert forward_rs = "10" report "ERROR: both reg_wrt high, should forward from EX_MEM to rs" severity error;
					end if;
					if (jj = kk) then
						assert forward_rt = "10" report "ERROR: both reg_wrt high, should forward from EX_MEM to rt" severity error;
					end if;
					wait for 5 ns;

				end loop; -- MEM/WB rd
			end loop; -- EX/MEM rd
		end loop; -- rt
	end loop; -- rs
	wait;
	assert false;
	end process stimulus;			
					

end architecture tb;