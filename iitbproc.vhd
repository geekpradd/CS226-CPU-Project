library std;
use std.standard.all;
use work.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity iitbproc is 
	port (
			wa, inst : in std_logic_vector(15 downto 0);
			clk : in std_logic;
			rst : in std_logic;
			mw: in std_logic;
			state_out: out std_logic_vector(4 downto 0)
			);
end entity;

architecture final of iitbproc is

	component register_1bit is
	  port(
		 output        : out std_logic;
		 input       : in  std_logic;
		 writeControl : in  std_logic;
		 clk         : in  std_logic
		 );
	end component;
	component register_16bit is
	  port(
		 output        : out std_logic_vector(15 downto 0);
		 input       : in  std_logic_vector(15 downto 0);
		 writeControl : in  std_logic;
		 clk         : in  std_logic;
		 rst : in std_logic
		 );
	end component;
	component register_file is
	  port(
		 outputA        : out std_logic_vector(15 downto 0);
		 outputB        : out std_logic_vector(15 downto 0);
		 input       : in  std_logic_vector(15 downto 0);
		 writeControl : in  std_logic;
		 regASel     : in  std_logic_vector(2 downto 0);
		 regBSel     : in  std_logic_vector(2 downto 0);
		 writeRegSel : in  std_logic_vector(2 downto 0);
		 clk         : in  std_logic
		 );
	end component;
	
	component RAM is
	  port(
      address:  IN   std_logic_vector (15 DOWNTO 0);
		input:  IN   std_logic_vector (15 DOWNTO 0);
		 output:     OUT  std_logic_vector (15 DOWNTO 0);
      writeControl :    IN   std_logic;
		clk: IN   std_logic
		 );
	end component;
	
	component ALU is
		port(
		A, B : in std_logic_vector(15 downto 0);                 --Inputs
		control : in std_logic_vector(1 downto 0);    				--Control bit
		ALU_out : out std_logic_vector(15 downto 0);					--Output vector
		carry, zero : out std_logic								--Carry_out, zero bit
		);
	end component;

	component Controller is
	  port(
		 clk,rst     : in  std_logic;
		 pc_in, ir_in, m_data_in, t1_in, t2_in, t3_in, m_add, alu_a, alu_b, rf_d3: out std_logic_vector(15 downto 0);
		 pc_out, ir_out, m_data_out, t1_out, t2_out, t3_out, alu_c, rf_d1, rf_d2: in std_logic_vector(15 downto 0);
		 c_out, z_out, alu_carry, alu_zero: in std_logic;
		 c_in, z_in: out std_logic;
		 ir_write, pc_write, t1_write, t2_write, t3_write, rf_write, memory_write, c_write, z_write : out std_logic;
		 rf_a1, rf_a2, rf_a3 : out std_logic_vector(2 downto 0);
		 alu_op: out std_logic_vector(1 downto 0);
		 state_out: out std_logic_vector(4 downto 0)
		 );
	end component; 
	component TwoByOneMux is
		port (i0 : in std_logic;
				i1 : in std_logic;
				sel : in std_logic; 
				z : out std_logic);
	end component;
	signal memory_write, rf_w, mem_w, ir_w, pc_w, t1_w, t2_w, t3_w, alu_carry, alu_zero, c_in, z_in, c_out, z_out, c_w, z_w: std_logic;
	signal rf_a1, rf_a2, rf_a3: std_logic_vector(2 downto 0);
	signal memory_address,memory_din, pc_in, pc_out, ir_in, ir_out, mem_a, mem_din, mem_dout, alu_a, alu_b, alu_c, rf_d1, rf_d2, rf_d3, t1_in, t1_out, t2_in, t2_out, t3_in, t3_out: std_logic_vector(15 downto 0);
	signal alu_op: std_logic_vector(1 downto 0);
	
	begin
		pc: register_16bit port map(pc_out, pc_in, pc_w, clk, rst);
		memory: RAM port map(memory_address, memory_din, mem_dout, memory_write, clk);
		ir: register_16bit port map(ir_out, ir_in, ir_w, clk, rst);
		rf: register_file port map(rf_d1, rf_d2, rf_d3, rf_w, rf_a1, rf_a2, rf_a3, clk);
		t1: register_16bit port map(t1_out, t1_in, t1_w, clk, rst);
		t2: register_16bit port map(t2_out, t2_in, t2_w, clk, rst);
		t3: register_16bit port map(t3_out, t3_in, t3_w, clk, rst);
		c: register_1bit port map(c_out, c_in, c_w, clk);
		z: register_1bit port map(z_out, z_in, z_w, clk);
		alu_1: ALU port map(alu_a, alu_b, alu_op, alu_c, alu_carry, alu_zero);
		fsm:  Controller port map(clk=> clk,rst=>rst, 
			pc_in=> pc_in, ir_in => ir_in, m_data_in => mem_din, alu_c => alu_c, rf_d1 => rf_d1, rf_d2 => rf_d2, t1_in => t1_in, t2_in => t2_in, t3_in => t3_in,
			pc_out=> pc_out, ir_out => ir_out, m_add => mem_a, m_data_out => mem_dout, alu_a => alu_a, alu_b => alu_b, rf_d3 => rf_d3, t1_out => t1_out, t2_out => t2_out, t3_out => t3_out,
			c_in => c_in, z_in => z_in, alu_carry => alu_carry, alu_zero => alu_zero,
			c_out => c_out, z_out => z_out,
			ir_write => ir_w, pc_write => pc_w, t1_write => t1_w, t2_write => t2_w, t3_write => t3_w, rf_write => rf_w, memory_write => mem_w, c_write => c_w, z_write => z_w,
			rf_a1 => rf_a1, rf_a2 => rf_a2, rf_a3 => rf_a3,
			alu_op => alu_op, state_out => state_out);

		
		memory_write <= mem_w or mw;
		
		address: 	for i in 0 to 15 generate
			addnode : TwoByOneMux port map(mem_a(i), wa(i), mw, memory_address(i));
		end generate address;
		datain: 	for i in 0 to 15 generate
			addnode : TwoByOneMux port map(mem_din(i), inst(i), mw, memory_din(i));
		end generate datain;
		
end architecture;
