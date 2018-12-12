library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.eecs361_gates.all;

-- Forwarding unit outputs one control signal for each operand of the ALU
-- For each signal, if 00, do not forward; if 01, forward from MEM/WB; if 10, forward from EX/MEM

entity forwarding_unit is
	port (
		-- Continue from ID stage
		rs_ID_EX		: in std_logic_vector (4 downto 0);
		rt_ID_EX		: in std_logic_vector (4 downto 0);
		use_imm_ID_EX		: in std_logic; -- Flag, do not forward Rt
		use_sa_ID_EX		: in std_logic; -- Flag, do not forward Rt

		-- Forward from EX/MEM pipeline register
		rd_EX_MEM		: in std_logic_vector (4 downto 0); 
		reg_wrt_EX_MEM		: in std_logic;

		-- Forward from MEM/WB pipeline register
		reg_wrt_MEM_WB		: in std_logic;
		rd_MEM_WB		: in std_logic_vector (4 downto 0);

		-- Outputs, ALU operands
		forward_rs		: out std_logic_vector (1 downto 0); 
		forward_rt		: out std_logic_vector (1 downto 0)
		);
end entity forwarding_unit;

architecture structural of forwarding_unit is

	-- Forward from EX/MEM
	-- Check first operand rs
	signal check_EX_MEM_rd_rs	: std_logic_vector (4 downto 0);
	signal EX_MEM_rd_rs_eq1		: std_logic_vector (1 downto 0);
	signal EX_MEM_rd_rs_eq2		: std_logic;
	signal EX_MEM_rd_rs_eq3		: std_logic;
	-- Check second operand rt
	signal check_EX_MEM_rd_rt	: std_logic_vector (4 downto 0);
	signal EX_MEM_rd_rt_eq1		: std_logic_vector (1 downto 0);
	signal EX_MEM_rd_rt_eq2		: std_logic;
	signal EX_MEM_rd_rt_eq3		: std_logic;
	signal EX_MEM_rt_valid		: std_logic;
	signal use_imm_sa_ID_EX		: std_logic;
	signal not_imm_sa_ID_EX		: std_logic;

	-- Forward from MEM/WB
	-- Check first operand rs
	signal check_MEM_WB_rd_rs	: std_logic_vector (4 downto 0);
	signal MEM_WB_rd_rs_eq1		: std_logic_vector (1 downto 0);
	signal MEM_WB_rd_rs_eq2		: std_logic;
	signal MEM_WB_rd_rs_eq3		: std_logic;
	signal not_reg_wrt_EX_MEM	: std_logic;
	signal MEM_WB_rd_rs_valid	: std_logic;
	signal not_EX_MEM_rd_rs		: std_logic;
	signal not_forward_EX_MEM_rs	: std_logic;
	-- Check second operand rt
	signal check_MEM_WB_rd_rt	: std_logic_vector (4 downto 0);
	signal MEM_WB_rd_rt_eq1		: std_logic_vector (1 downto 0);
	signal MEM_WB_rd_rt_eq2		: std_logic;
	signal MEM_WB_rd_rt_eq3		: std_logic;
	signal MEM_WB_rd_rt_valid	: std_logic;
	signal not_EX_MEM_rd_rt		: std_logic;
	signal not_forward_EX_MEM_rt	: std_logic;
	signal MEM_WB_rd_rt_valid2	: std_logic;

begin
	-- FORWARD FROM EX/MEM -----------------------------------------------------------------

	-- Check first operand rs
	-- if (EX/MEM.RegWrite = 1 and EX/MEM.RegisterRd = ID/EX.RegisterRs) then ForwardA = 2
	
	-- Check EX/MEM.RegisterRd = ID/EX.RegisterRs
	check_EX_MEM_rd_rs_xnor : xnor_gate_n
		generic map (
			n	=> 5
			)
		port map (
			x	=> Rs_ID_EX,
			y	=> Rd_EX_MEM,
			z	=> check_EX_MEM_rd_rs
			);
	
	check_EX_MEM_rd_rs_eq1 : for i in 0 to 1 generate
		and_rd_rs_inst : and_gate
			port map (
				x	=> check_EX_MEM_rd_rs(i),
				y	=> check_EX_MEM_rd_rs(i+2),
				z	=> EX_MEM_rd_rs_eq1(i)
				);
	end generate check_EX_MEM_rd_rs_eq1;

	and_rd_rs_inst2 : and_gate
		port map (
			x	=> EX_MEM_rd_rs_eq1(0),
			y	=> EX_MEM_rd_rs_eq1(1),
			z	=> EX_MEM_rd_rs_eq2
			);

	and_rd_rs_inst3 : and_gate
		port map (
			x	=> EX_MEM_rd_rs_eq2,
			y	=> check_EX_MEM_rd_rs(4),
			z	=> EX_MEM_rd_rs_eq3
			);

	-- Set ForwardA = 2
	and_forwardA_2 : and_gate
		port map (
			x	=> EX_MEM_rd_rs_eq3,
			y	=> reg_wrt_EX_MEM,
			z	=> forward_rs(1)
			);

	-- Check second operand rt
	-- if (EX/MEM.RegWrite = 1 and EX/MEM.RegisterRd = ID/EX.RegisterRt) then ForwardB = 2

	-- Check EX/MEM.RegisterRd = ID/EX.RegisterRt
	check_EX_MEM_rd_rt_xnor : xnor_gate_n
		generic map (
			n	=> 5
			)
		port map (
			x	=> Rt_ID_EX,
			y	=> Rd_EX_MEM,
			z	=> check_EX_MEM_rd_rt
			);
	
	check_EX_MEM_rd_rt_eq1 : for i in 0 to 1 generate
		and_rd_rt_inst : and_gate
			port map (
				x	=> check_EX_MEM_rd_rt(i),
				y	=> check_EX_MEM_rd_rt(i+2),
				z	=> EX_MEM_rd_rt_eq1(i)
				);
	end generate check_EX_MEM_rd_rt_eq1;

	and_rd_rt_inst2 : and_gate
		port map (
			x	=> EX_MEM_rd_rt_eq1(0),
			y	=> EX_MEM_rd_rt_eq1(1),
			z	=> EX_MEM_rd_rt_eq2
			);

	and_rd_rt_inst3 : and_gate
		port map (
			x	=> EX_MEM_rd_rt_eq2,
			y	=> check_EX_MEM_rd_rt(4),
			z	=> EX_MEM_rd_rt_eq3
			);

	and_forwardB_2 : and_gate
		port map (
			x	=> EX_MEM_rd_rt_eq3,
			y	=> reg_wrt_EX_MEM,
			z	=> EX_MEM_rt_valid
			);
	
	-- Only forward if instruction is R-type, not an immediate operand
	or_imm_sa_ID_EX : or_gate
		port map ( 
			x	=> use_imm_ID_EX,  
			y	=> use_sa_ID_EX,
			z	=> use_imm_sa_ID_EX
			);

	not_immediate_operand : not_gate
		port map ( 
			x	=> use_imm_sa_ID_EX,  
			z	=> not_imm_sa_ID_EX
			);

	-- Set ForwardB = 2
	use_EX_MEM_rd_rt : and_gate
		port map ( 
			x	=> EX_MEM_rt_valid,
			y	=> not_imm_sa_ID_EX, 
			z	=> forward_rt(1)
		);

	-- FORWARD FROM MEM/WB -----------------------------------------------------------------
	
	-- Check first operand rs
	-- if (MEM/WB.RegWrite = 1 and MEM/WB.RegisterRd = ID/EX.RegisterRs and (EX/MEM.RegisterRd /= ID/EX.RegisterRs or EX/MEM.RegWrite = 0) then ForwardA = 1

	-- Check MEM/WB.RegisterRd = ID/EX.RegisterRs
	check_MEM_WB_rd_rs_xnor : xnor_gate_n
		generic map (
			n	=> 5
			)
		port map (
			x	=> rs_ID_EX,
			y	=> rd_MEM_WB,
			z	=> check_MEM_WB_rd_rs
			);
	
	check_MEM_WB_rd_rs_eq1 : for i in 0 to 1 generate
		MEM_WB_and_rd_rs_inst : and_gate
			port map (
				x	=> check_MEM_WB_rd_rs(i),
				y	=> check_MEM_WB_rd_rs(i+2),
				z	=> MEM_WB_rd_rs_eq1(i)
				);
	end generate check_MEM_WB_rd_rs_eq1;

	MEM_WB_and_rd_rs_inst2 : and_gate
		port map (
			x	=> MEM_WB_rd_rs_eq1(0),
			y	=> MEM_WB_rd_rs_eq1(1),
			z	=> MEM_WB_rd_rs_eq2
			);

	MEM_WB_and_rd_rs_inst3 : and_gate
		port map (
			x	=> MEM_WB_rd_rs_eq2,
			y	=> check_MEM_WB_rd_rs(4),
			z	=> MEM_WB_rd_rs_eq3
			);

	-- Check MEM/WB.RegWrite = 1 and MEM/WB.RegisterRd = ID/EX.RegisterRs
	MEM_WB_and_eq_reg_wrt : and_gate
		port map (
			x	=> MEM_WB_rd_rs_eq3,
			y	=> reg_wrt_MEM_WB,
			z	=> MEM_WB_rd_rs_valid
			);

	-- EX/MEM.RegWrite = 0
	not_EX_MEM_reg_wrt : not_gate
		port map (
			x	=> reg_wrt_EX_MEM,
			z	=> not_reg_wrt_EX_MEM
			);

	not_EX_MEM_rs_forward : not_gate
		port map (
			x	=> EX_MEM_rd_rs_eq3,
			z	=> not_EX_MEM_rd_rs
			);

	-- Check EX/MEM.RegisterRd /= ID/EX.RegisterRs or EX/MEM.RegWrite = 0
	MEM_WB_or_eq_reg_wrt : or_gate
		port map (
			x	=> not_EX_MEM_rd_rs,
			y	=> not_reg_wrt_EX_MEM,
			z	=> not_forward_EX_MEM_rs
			);

	-- Set ForwardA = 1
	forward_MEM_WB_rs : and_gate
		port map (
			x	=> MEM_WB_rd_rs_valid,
			y	=> not_forward_EX_MEM_rs,
			z	=> forward_rs(0)
			);

	-- Check second operand rt
	-- if (MEM/WB.RegWrite = 1 and MEM/WB.RegisterRd = ID/EX.RegisterRt and (EX/MEM.RegisterRd /= ID/EX.RegisterRt or EX/MEM.RegWrite = 0) then ForwardB = 1
	
	-- Check MEM/WB.RegisterRd = ID/EX.RegisterRs
	check_MEM_WB_rd_rt_xnor : xnor_gate_n
		generic map (
			n	=> 5
			)
		port map (
			x	=> rt_ID_EX,
			y	=> rd_MEM_WB,
			z	=> check_MEM_WB_rd_rt
			);
	
	check_MEM_WB_rd_rt_eq1 : for i in 0 to 1 generate
		MEM_WB_and_rd_rt_inst : and_gate
			port map (
				x	=> check_MEM_WB_rd_rt(i),
				y	=> check_MEM_WB_rd_rt(i+2),
				z	=> MEM_WB_rd_rt_eq1(i)
				);
	end generate check_MEM_WB_rd_rt_eq1;

	MEM_WB_and_rd_rt_inst2 : and_gate
		port map (
			x	=> MEM_WB_rd_rt_eq1(0),
			y	=> MEM_WB_rd_rt_eq1(1),
			z	=> MEM_WB_rd_rt_eq2
			);

	MEM_WB_and_rd_rt_inst3 : and_gate
		port map (
			x	=> MEM_WB_rd_rt_eq2,
			y	=> check_MEM_WB_rd_rt(4),
			z	=> MEM_WB_rd_rt_eq3
			);

	-- Check MEM/WB.RegWrite = 1 and MEM/WB.RegisterRd = ID/EX.RegisterRt
	MEM_WB_rt_and_eq_reg_wrt : and_gate
		port map (
			x	=> MEM_WB_rd_rt_eq3,
			y	=> reg_wrt_MEM_WB,
			z	=> MEM_WB_rd_rt_valid
			);


	not_EX_MEM_rt_forward : not_gate
		port map (
			x	=> EX_MEM_rd_rt_eq3,
			z	=> not_EX_MEM_rd_rt
			);

	-- Check EX/MEM.RegisterRd /= ID/EX.RegisterRs or EX/MEM.RegWrite = 0
	MEM_WB_rt_or_eq_reg_wrt : or_gate
		port map (
			x	=> not_EX_MEM_rd_rt,
			y	=> not_reg_wrt_EX_MEM,
			z	=> not_forward_EX_MEM_rt
			);

	-- Check requirements for ForwardB = 1
	forward_MEM_WB_rt : and_gate
		port map (
			x	=> MEM_WB_rd_rt_valid,
			y	=> not_forward_EX_MEM_rt,
			z	=> MEM_WB_rd_rt_valid2
			);

	-- Setting ForwardB = 1 if r-type instruction 
	use_EX_MEM_rd_rt_and : and_gate
		port map ( 
			x	=> MEM_WB_rd_rt_valid2,
			y	=> not_imm_sa_ID_EX, 
			z	=> forward_rt(0)
		);


end architecture structural;