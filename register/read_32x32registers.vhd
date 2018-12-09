library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity read_32x32registers is
	port (
		sel	: in std_logic_vector (4 downto 0);
		src	: in array_registers;
		z	: out std_logic_vector (31 downto 0)
		);
end entity read_32x32registers;

architecture read_32x32registers_logic of read_32x32registers is
	
	type array_16 is array (15 downto 0) of std_logic_vector (31 downto 0);
	signal lvl0_out		: array_16;

	type array_8 is array (7 downto 0) of std_logic_vector (31 downto 0);
	signal lvl1_out		: array_8;

	type array_4 is array (3 downto 0) of std_logic_vector (31 downto 0);
	signal lvl2_out		: array_4;

	type array_2 is array (1 downto 0) of std_logic_vector (31 downto 0);
	signal lvl3_out		: array_2;
	
begin

	mux_lvl0 : for i in 0 to 15 generate
		mux_lvl0_inst : mux_32
			port map (
				sel	=> sel(0),
				src0	=> src(2*i),
				src1	=> src(2*i + 1),
				z	=> lvl0_out(i)
			);
	end generate mux_lvl0;

	mux_lvl1 : for i in 0 to 7 generate
		mux_lvl1_inst : mux_32
			port map (
				sel	=> sel(1),
				src0	=> lvl0_out(2*i),
				src1	=> lvl0_out(2*i + 1),
				z	=> lvl1_out(i)
			);
	end generate mux_lvl1;

	mux_lvl2 : for i in 0 to 3 generate
		mux_lvl2_inst : mux_32
			port map (
				sel	=> sel(2),
				src0	=> lvl1_out(2*i),
				src1	=> lvl1_out(2*i + 1),
				z	=> lvl2_out(i)
			);
	end generate mux_lvl2;

	mux_lvl3 : for i in 0 to 1 generate
		mux_lvl3_inst : mux_32
			port map (
				sel	=> sel(3),
				src0	=> lvl2_out(2*i),
				src1	=> lvl2_out(2*i + 1),
				z	=> lvl3_out(i)
			);
	end generate mux_lvl3;

	mux_lvl4_inst : mux_32
		port map (
			sel	=> sel(4),
			src0	=> lvl3_out(0),
			src1	=> lvl3_out(1),
			z	=> z
		);

end architecture read_32x32registers_logic;