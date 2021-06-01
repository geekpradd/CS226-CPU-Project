library work;
use work.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;

entity cputest is 
end entity;

architecture behv of cputest is
	component iitbproc is
	port
		(
			wa, inst : in std_logic_vector(15 downto 0);
			clk : in std_logic;
			rst : in std_logic;
			mem_w : in std_logic;
			start : out std_logic
		);
	end component;
	
	signal wa, inst : std_logic_vector(15 downto 0);
	signal clk : std_logic := '1';
	signal rst, mem_w, start : std_logic;
	
begin
	dut_instance: iitbproc
		port map (wa => wa, inst => inst, clk => clk, rst => rst, mem_w => mem_w, start => start);
	
	
	process 
		file in_file : text open read_mode is "/home/anon/Desktop/IITB-proc/src/in.txt";
		variable in_line : line;
		variable in_var : std_logic_vector(15 downto 0);
		variable count : integer range 0 to 32;
		variable curr : integer range 0 to 32;
		
		begin
			count := 0;
			curr := 0;
			wa <= "0000000000000000";
			
			-- load instructions in memory
			while not endfile(in_file) loop
				readline (in_file, in_line);
				read (in_line, in_var);
				rst <= '1';
				clk <= '1';
				inst <= in_var;
				mem_w <= '1';
				wait for 100 ns;
				clk <= '0';
				wait for 100 ns;
				wa <= std_logic_vector ( unsigned(wa) + 1);
				count := count + 1;
			end loop;
			
			-- execute instructions
			rst <= '1';
			mem_w <= '0';
			clk <= '1';
			wait for 100 ns;
			clk <= '0';
			wait for 100 ns;
	
			rst <= '0';
			while curr < count+1 loop
				clk <= '1';
				wait for 100 ns;
				clk <= '0';
				wait for 100 ns;
				
				if (start = '1') then
					curr := curr + 1;
				end if;
				
			end loop;
	wait;
	end process;
end architecture;