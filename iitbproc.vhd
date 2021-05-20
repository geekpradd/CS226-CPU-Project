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
			mem_out: out std_logic_vector(15 downto 0)
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
		 clk         : in  std_logic
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
	
	signal memory_address,memory_din, memory_write, rf_w, mem_w, ir_w, pc_w, t1_w, t2_w, t3_w, alu_carry, alu_zero, c_in, z_in, c_out, z_out, c_w, z_w: std_logic;
	signal rf_a1, rf_a2, rf_a3: std_logic_vector(2 downto 0);
	signal pc_in, pc_out, ir_in, ir_out, mem_a, mem_din, mem_dout, alu_a, alu_b, alu_c, rf_d1, rf_d2, rf_d3, t1_in, t1_out, t2_in, t2_out, t3_in, t3_out: std_logic_vector(15 downto 0);
	
	begin
		pc: register_16bit port map(pc_out, pc_in, pc_w, clk);
		memory: RAM port map(memory_address, memory_din, mem_dout, memory_write, clk);
		ir: register_16bit port map(ir_out, ir_in, ir_w, clk);
		rf: register_file port map(rf_d1, rf_d2, rf_d3, rf_w, rf_a1, rf_a2, rf_a3, clk);
		t1: register_16bit port map(t1_out, t1_in, t1_w, clk);
		t2: register_16bit port map(t2_out, t2_in, t1_w, clk);
		t3: register_16bit port map(t3_out, t3_in, t1_w, clk);
		c: register_1bit port map(c_out, c_in, c_w, clk);
		z: register_1bit port map(z_out, z_in, z_w, clk);
		
		mem_out <= mem_dout;
		memory_write <= mem_w or mw;
		process(clk) is
		begin
			if rising_edge(clk) then
				if mw = '1' then
					memory_address <= wa;
					mem_w <= '0';
					memory_din <= inst;
				else
					memory_din <= mem_din;
					memory_address <= m_a;
				end if;
		end process;
end architecture;
