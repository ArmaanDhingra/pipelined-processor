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
		
		out_mem_to_reg		: out std_logic;
		out_reg_wrt		: out std_logic;
		out_mem_wrt		: out std_logic;
		out_branch		: out std_logic;
		out_sign_extend		: out std_logic;	
		out_use_imm		: out std_logic;
		out_use_sa		: out std_logic);

end control_signals;

architecture cs_logic of control_signals is

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

end architecture;
	