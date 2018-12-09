library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity shifter_32 is
	port (
		a	: in	std_logic_vector (31 downto 0);
		b	: in	std_logic_vector (31 downto 0);
		r	: out	std_logic_vector (31 downto 0)
	);
end shifter_32;

architecture shifter_32_logic of shifter_32 is
	signal a_1, m1, m1_2, m2, m2_4, m3, m3_8, m4, m4_16, sll_r: std_logic_vector(31 downto 0);

begin
	a_1_gen_0 : for i in 0 to 0 generate
		a_1(i) <= '0';
	end generate a_1_gen_0;

	a_1_gen : for i in 1 to 31 generate
		a_1(i) <= a(i-1);
	end generate a_1_gen;

	ssl_1_mux	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	b(0),
		src0	=>	a,
		src1	=>	a_1,
		z	=>	m1
	);
	
	m1_2_gen_0 : for i in 0 to 1 generate
		m1_2(i) <= '0';
	end generate m1_2_gen_0;

	m1_2_gen : for i in 2 to 31 generate
		m1_2(i) <= m1(i-2);
	end generate m1_2_gen;

	ssl_2_mux	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	b(1),
		src0	=>	m1,
		src1	=>	m1_2,
		z	=>	m2
	);

	m2_4_gen_0 : for i in 0 to 3 generate
		m2_4(i) <= '0';
	end generate m2_4_gen_0;

	m2_4_gen : for i in 4 to 31 generate
		m2_4(i) <= m2(i-4);
	end generate m2_4_gen;

	ssl_4_mux	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	b(2),
		src0	=>	m2,
		src1	=>	m2_4,
		z	=>	m3
	);

	
	m3_8_gen_0 : for i in 0 to 7 generate
		m3_8(i) <= '0';
	end generate m3_8_gen_0;

	m3_8_gen : for i in 8 to 31 generate
		m3_8(i) <= m3(i-8);
	end generate m3_8_gen;

	ssl_8_mux	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	b(3),
		src0	=>	m3,
		src1	=>	m3_8,
		z	=>	m4
	);

	
	m4_16_gen_0 : for i in 0 to 15 generate
		m4_16(i) <= '0';
	end generate m4_16_gen_0;

	m4_16_gen : for i in 16 to 31 generate
		m4_16(i) <= m4(i-16);
	end generate m4_16_gen;

	ssl_16_mux	:	mux_n
	generic map (
		n	=>	32
	)
	port map (
		sel	=>	b(4),
		src0	=>	m4,
		src1	=>	m4_16,
		z	=>	r
	);

	
end architecture shifter_32_logic;
