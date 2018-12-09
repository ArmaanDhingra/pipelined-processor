library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

--INST	OPCODE	SPECIAL
--ADD	000000	100000
--ADDU	000000	100001
--SUB	000000	100010
--SUBU	000000	100011
--AND	000000	100100
--OR	000000	100101
--SLT	000000	101010
--SLTU	000000	101011
--SLL	000000	000000

entity alu_32 is
	port (
		ctrl	: in	std_logic_vector (5 downto 0);
		a	: in	std_logic_vector (31 downto 0);
		b	: in	std_logic_vector (31 downto 0);
		r	: out	std_logic_vector (31 downto 0);
		of_flag	: out	std_logic;
		z_flag	: out	std_logic
	);
end alu_32;

architecture alu_32_logic of alu_32 is
	signal c : std_logic_vector(32 downto 0);		-- for carry in/carry out to 1 bit ALUs
	signal or_vector : std_logic_vector(32 downto 0);	-- for zero flag
	signal arth_r, sll_r : std_logic_vector(31 downto 0);	
	signal slt_sltu_mux, arth_slt_sltu_mux : std_logic_vector(31 downto 0);
	signal slt_r, sltu_r : std_logic_vector(31 downto 0);
	signal cout, z_flag_inv, of_flag_sig : std_logic; 

begin
	-- Arithmetic Operations
	c(0) <= ctrl(1);	-- carry in is 1 if doing subtraction
	cout <= c(32);
	alu_loop : for i in 0 to 31 generate
		alu_32:alu_1
		port map( 
			ctrl	=>	ctrl(2 downto 0),
			cin	=>	c(i),
			a	=>	a(i),
			b	=>	b(i),
			r	=>	arth_r(i),
			cout	=>	c(i + 1)
		);
	end generate alu_loop;

	-- Zero flag
	or_vector(0) <= arth_r(0);
	z_flag_inv <= or_vector(32);
	z_flag_loop : for i in 0 to 31 generate
		z_flag_or:or_gate
		port map( 
			x	=>	or_vector(i),
			y	=>	arth_r(i),
			z	=>	or_vector(i + 1)
		);
	end generate z_flag_loop;
	z_flag_inv_invert : not_gate
	port map(
		x	=>	z_flag_inv,
		z	=>	z_flag
	);


	of_flag_xor : xor_gate
	port map(
		x	=>	c(31),
		y	=>	c(32),
		z	=>	of_flag_sig
	);
	of_flag <= of_flag_sig;

	shifter : shifter_32
	port map(
		a	=>	a,
		b	=>	b,
		r	=>	sll_r
	);

	
	slt_gen_0 : for i in 1 to 31 generate
		slt_r(i) <= '0';
	end generate slt_gen_0;
	slt_xor		:	xor_gate
	port map(
		x	=>	arth_r(31),
		y	=>	of_flag_sig,
		z	=>	slt_r(0)
	);

	sltu_gen_0 : for i in 1 to 31 generate
		sltu_r(i) <= '0';
	end generate sltu_gen_0;
	
	sltu_lsb	: 	not_gate
	port map (
		x 	=>	c(32),
		z	=>	sltu_r(0)
	);
	
	alu_mux_1	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	ctrl(0),
		src0	=>	slt_r,
		src1	=>	sltu_r,
		z	=>	slt_sltu_mux
	);

	alu_mux_2	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	ctrl(3),
		src0	=>	arth_r,
		src1	=>	slt_sltu_mux,
		z	=>	arth_slt_sltu_mux	
	);
	
	alu_mux_3	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	ctrl(5),
		src0	=>	sll_r,
		src1	=>	arth_slt_sltu_mux,
		z	=>	r	
	);

	
end architecture alu_32_logic;