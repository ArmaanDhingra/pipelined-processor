-- This package is used for EECS 361 from Northwestern University.

-- by Kaicheng Zhang (kaichengz@gmail.com)



library ieee;

use ieee.std_logic_1164.all;

use work.eecs361_gates.all;



package eecs361 is

  -- Decoders

  component dec_n

    generic (

      -- Widths of the inputs.

      n	  : integer

    );

    port (

      src   : in std_logic_vector(n-1 downto 0);

      z	    : out std_logic_vector((2**n)-1 downto 0)

    );

  end component dec_n;



  -- Multiplexors

  component mux

    port (

      sel   : in  std_logic;

      src0  : in  std_logic;

      src1  : in  std_logic;

      z     : out std_logic

    );

  end component mux;



  component mux_n

    generic (

      -- Widths of the inputs.

      n	  : integer

    );

    port (

      sel   : in  std_logic;

      src0  : in  std_logic_vector(n-1 downto 0);

      src1  : in  std_logic_vector(n-1 downto 0);

      z     : out std_logic_vector(n-1 downto 0)

    );

  end component mux_n;



  component mux_32

    port (

      sel   : in  std_logic;

      src0  : in  std_logic_vector(31 downto 0);

      src1  : in  std_logic_vector(31 downto 0);

      z	    : out std_logic_vector(31 downto 0)

    );

  end component mux_32;



  -- Flip-flops



  -- D Flip-flops from Figure C.8.4 with a falling edge trigger.

  component dff

    port (

      clk   : in  std_logic;

      d	    : in  std_logic;

      q	    : out std_logic

    );

  end component dff;



  -- D Flip-flops from Figure C.8.4 with a rising edge trigger.

  component dffr

    port (

      clk   : in  std_logic;

      d	    : in  std_logic;

      q	    : out std_logic

    );

  end component dffr;



  -- D Flip-flops from Example 13-40 in http://www.altera.com/literature/hb/qts/qts_qii51007.pdf

  component dffr_a

    port (

      clk	 : in  std_logic;

      arst   : in  std_logic;

      aload  : in  std_logic;

      adata  : in  std_logic;

      d	     : in  std_logic;

      enable : in  std_logic;

      q	     : out std_logic

    );



  end component dffr_a;



  -- A 32bit SRAM from Figure C.9.1. It can only be used for simulation.

  component sram

	generic (

	  mem_file	: string

	);

	port (

	  -- chip select

	  cs	: in  std_logic;

	  -- output enable

	  oe	: in  std_logic;

	  -- write enable

	  we	: in  std_logic;

	  -- address line

	  addr	: in  std_logic_vector(31 downto 0);

	  -- data input

	  din	: in  std_logic_vector(31 downto 0);

	  -- data output

	  dout	: out std_logic_vector(31 downto 0)

	);

  end component sram;



  -- Synchronous SRAM with asynchronous reset.

  component syncram

    generic (

	  mem_file	: string

	);

	port (

      -- clock

      clk   : in  std_logic;

	  -- chip select

	  cs	: in  std_logic;

      -- output enable

	  oe	: in  std_logic;

	  -- write enable

	  we	: in  std_logic;

	  -- address line

	  addr	: in  std_logic_vector(31 downto 0);

	  -- data input

	  din	: in  std_logic_vector(31 downto 0);

	  -- data output

	  dout	: out std_logic_vector(31 downto 0)

	);

  end component syncram;



  --ALU COMPONENTS



  -- Full Adder

  component adder_1 is

	port (

	  cin	: in	std_logic;

	  a	: in	std_logic;

	  b	: in	std_logic;

	  r	: out	std_logic;

	  cout	: out	std_logic

	);

  end component adder_1;



  -- 1 bit ALU

  component alu_1 is

	port (

	  ctrl	: in	std_logic_vector (2 downto 0);

	  cin	: in	std_logic;

	  a	: in	std_logic;

	  b	: in	std_logic;

	  r	: out	std_logic;

	  cout	: out	std_logic

	);

  end component alu_1;



  -- 32 bit shifter

  component shifter_32 is

	port (

		a	: in	std_logic_vector (31 downto 0);

		b	: in	std_logic_vector (31 downto 0);

		r	: out	std_logic_vector (31 downto 0)

	);

  end component shifter_32;



  component alu_32 is

	port (

		ctrl	: in	std_logic_vector (5 downto 0);

		a	: in	std_logic_vector (31 downto 0);

		b	: in	std_logic_vector (31 downto 0);

		r	: out	std_logic_vector (31 downto 0);

		of_flag	: out	std_logic;

		z_flag	: out	std_logic

	);

  end component alu_32;



  -- Extender

  component extender is

	port ( 

		sign	: in std_logic;

		input	: in std_logic_vector(15 downto 0);

		output	: out std_logic_vector(31 downto 0)

	);

  end component extender;



  -- Registers

  type array_registers is array (31 downto 0) of std_logic_vector (31 downto 0);

  component read_32x32registers is

	port (

		sel		: in std_logic_vector (4 downto 0);

		src		: in array_registers;

		z		: out std_logic_vector (31 downto 0)

	);

  end component read_32x32registers;



  component register_file is

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

  end component register_file;



  component register_1 is 

	port(

		clk		: in std_logic;

		init		: in std_logic;

		init_data	: in std_logic_vector(31 downto 0);

		input		: in std_logic_vector(31 downto 0);

		output		: out std_logic_vector(31 downto 0)

	);

  end component register_1;

	

  -- Instruction Decoding

  component instruction_decoder is

	port(

		instruction	: in std_logic_vector (31 downto 0);

		rs		: out std_logic_vector (4 downto 0); 

		rt		: out std_logic_vector (4 downto 0); 

		rd		: out std_logic_vector (4 downto 0);

		alu_op		: out std_logic_vector (5 downto 0);

		mem_to_reg	: out std_logic;

		reg_wrt		: out std_logic;

		mem_wrt		: out std_logic;

		branch		: out std_logic;

		sign_extend	: out std_logic;	-- sign extend = 1, zero extend = 0

		use_imm		: out std_logic;	-- use immediate = 1, use registers = 0

		use_sa		: out std_logic		-- use shamt = 1

	);

  end component instruction_decoder;



 -- Branch Logic Resolver

  component branch_resolver is

	port(

		branch		: in std_logic;

		opcode		: in std_logic_vector (5 downto 0);

		z_flag		: in std_logic;

		s_flag		: in std_logic;

		take_branch	: out std_logic

	);

  end component branch_resolver;



 -- Flow Control

  component pc_controller is

	port(

		pc_init			: in std_logic;

		pc_init_data		: in std_logic_vector (31 downto 0);

		clk			: in std_logic;

		immediate_extended	: in std_logic_vector (31 downto 0);

		take_branch		: in std_logic;	

		pc			: out std_logic_vector (31 downto 0)

	);

  end component pc_controller;



  -- Top Entity (Processor)

  component processor is

	generic (

		code 	: string

	);	

	port(

		-- Essential signals

		init			: in std_logic;				-- Set pc to pc_init_data and reset register file

		pc_init_data		: in std_logic_vector (31 downto 0);	-- Initial value for program counter

		clk			: in std_logic;



		-- Inspection signals



		-- Flow control

		pc_ins			: out std_logic_vector (31 downto 0);

		instruction_ins		: out std_logic_vector (31 downto 0);

		take_branch_ins		: out std_logic;

			

		-- Control signals

		alu_op_ins		: out std_logic_vector (5 downto 0);

		mem_to_reg_ins		: out std_logic;

		reg_wrt_ins		: out std_logic;

		mem_wrt_ins		: out std_logic;

		branch_ins		: out std_logic;

		sign_extend_ins		: out std_logic;	-- sign extend = 1, zero extend = 0

		use_imm_ins		: out std_logic;	-- use immediate = 1, use registers = 0

		use_sa_ins		: out std_logic;	-- use shamt = 1

	

		-- ALU

	 	immediate_extended_ins	: out std_logic_vector (31 downto 0);

		shamt_extended_ins	: out std_logic_vector (31 downto 0);

		alu_b_reg_imm_ins	: out std_logic_vector (31 downto 0);

		alu_a_ins		: out std_logic_vector (31 downto 0);

		alu_b_ins		: out std_logic_vector (31 downto 0);

		alu_r_ins		: out std_logic_vector (31 downto 0);

		of_flag_ins		: out std_logic;

		z_flag_ins		: out std_logic;

	

		-- Register

		rs_ins			: out std_logic_vector (4 downto 0); 

		rt_ins			: out std_logic_vector (4 downto 0); 

		rd_ins			: out std_logic_vector (4 downto 0);

		reg_bus_a_ins		: out std_logic_vector (31 downto 0);

		reg_bus_b_ins		: out std_logic_vector (31 downto 0);

		reg_bus_wrt_ins		: out std_logic_vector (31 downto 0);

		

		-- Data Memory

		manual_mem_inspect	: in std_logic;

		manual_mem_inspect_addr	: in std_logic_vector (31 downto 0);

		data_mem_out_ins	: out std_logic_vector (31 downto 0)

		);

  end component processor;

  component id_ex_register
	port (
		clk		: in std_logic;
		reset		: in std_logic;
		input_pc	: in std_logic_vector(31 downto 0);
		input_a		: in std_logic_vector(31 downto 0);
		input_b		: in std_logic_vector(31 downto 0);
		input_immediate	: in std_logic_vector(31 downto 0);
		output_pc	: out std_logic_vector(31 downto 0);
		output_a	: out std_logic_vector(31 downto 0);
		output_b	: out std_logic_vector(31 downto 0);
		output_immediate: out std_logic_vector(31 downto 0));
  end component id_ex_register;



end;
