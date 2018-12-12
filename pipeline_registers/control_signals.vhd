library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity control_signals is
	port (
		clk			: in std_logic;
		reset			: in std_logic;
		in_mem_to_reg		: in std_logic;
		in_reg_wrt		: in std_logic;
		in_mem_wrt		: in std_logic;
		in_branch		: in std_logic;
		in_sign_extend		: in std_logic;	
		in_use_imm		: in std_logic;
		in_use_sa		: in std_logic;
		in_rs			: in std_logic_vector(4 downto 0);
		in_rt			: in std_logic_vector(4 downto 0);
		in_rd			: in std_logic_vector(4 downto 0);
		in_stall		: in std_logic;		

		out_mem_to_reg		: out std_logic;
		out_reg_wrt		: out std_logic;
		out_mem_wrt		: out std_logic;
		out_branch		: out std_logic;
		out_sign_extend		: out std_logic;	
		out_use_imm		: out std_logic;
		out_use_sa		: out std_logic;
		out_stall		: out std_logic;
		out_rs			: out std_logic_vector(4 downto 0);
		out_rt			: out std_logic_vector(4 downto 0);
		out_rd			: out std_logic_vector(4 downto 0)
	);

end control_signals;

architecture cs_logic of control_signals is
signal mem_wrt, reg_wrt : std_logic;

begin
	
	mem_to_reg_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_mem_to_reg, enable=>'1', q=>out_mem_to_reg);
	
	reg_wrt_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_reg_wrt, enable=>'1', q=>out_reg_wrt);

	mem_wrt_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_mem_wrt, enable=>'1', q=>out_mem_wrt);
	
	branch_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_branch, enable=>'1', q=>out_branch);
	
	sign_extend_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_sign_extend, enable=>'1', q=>out_sign_extend);
	
	use_sa_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_use_sa, enable=>'1', q=>out_use_sa);
	
	use_imm_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_use_imm, enable=>'1', q=>out_use_imm);

	stall_dff : dffr_a
		port map (clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_stall, enable=>'1', q=>out_stall);

	out_rs_dff : for i in 0 to 4 generate
		rs_dff: dffr_a
			port map(clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_rs(i), enable=>'1', q=>out_rs(i));
	end generate;

	out_rt_dff : for i in 0 to 4 generate
		rt_dff: dffr_a
			port map(clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_rt(i), enable=>'1', q=>out_rt(i));
	end generate;

	out_rd_dff : for i in 0 to 4 generate
		rd_dff: dffr_a
			port map(clk=>clk, arst=>reset, aload=>'0', adata=>'0', d=>in_rd(i), enable=>'1', q=>out_rd(i));
	end generate;
end architecture;
	
