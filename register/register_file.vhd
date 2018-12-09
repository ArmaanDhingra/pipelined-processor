library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity register_file is
	port (
		init		: in std_logic;				-- reset all registers to zero
		reg_wr		: in std_logic;
		reg_dst		: in std_logic_vector (4 downto 0);	-- destination register
		rs		: in std_logic_vector (4 downto 0); 	-- first register source
		rt 		: in std_logic_vector (4 downto 0); 	-- second register source
		busW		: in std_logic_vector (31 downto 0);	-- write data
		clk		: in std_logic;
		busA		: out std_logic_vector (31 downto 0); 	-- read data 1
		busB		: out std_logic_vector (31 downto 0) 	-- read data 2
		);
end entity register_file;

architecture register_file_logic of register_file is
	--Initialize register files
	signal registers	: array_registers;

	--Writing
	signal dest_dec		: std_logic_vector (31 downto 0);
	signal wr_addr		: std_logic_vector (31 downto 0) := (others => '0');

begin

	-- Write to registers -------------------------------------------------------------------

	--Decode 5-bit write register to 32-bit one-hot
	dec_inst : dec_n
		generic map (
			n	=> 5
			)
		port map (
			src	=> reg_dst,
			z	=> dest_dec
			);

	--Make sure we are in the write mode
	write_ands : for i in 0 to 31 generate
		and_inst : and_gate
			port map (
				x	=>	reg_wr,
				y	=>	dest_dec(i),
				z	=>	wr_addr(i)
			);
	end generate write_ands;

	--Write to a register
	write_reg : for i in 0 to 31 generate
		write_bit : for j in 0 to 31 generate
			dffr_a_inst : dffr_a
				port map (
					clk	=> clk,
					arst	=> '0',
					aload	=> init,
					adata	=> '0',
					d	=> busW(j),
					enable	=> wr_addr(i),
					q	=> registers(i)(j)
					);
		end generate write_bit;
	end generate write_reg;

	--Read from first register (rs input)
	rs_data : read_32x32registers
		port map (
			sel	=> rs,
			src	=> registers,
			z	=> busA
		);

	--Read from second register (rt input)
	rt_data : read_32x32registers
		port map (
			sel	=> rt,
			src	=> registers,
			z	=> busB
		);

end architecture register_file_logic;