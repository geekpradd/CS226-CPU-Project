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
			mw : in std_logic;
			state_out: out std_logic_vector(4 downto 0)
		);
	end component;
	
	signal wa, inst : std_logic_vector(15 downto 0);
	signal clk : std_logic := '1';
	signal rst, mw : std_logic;
	signal state_out: std_logic_vector(4 downto 0);
	
begin
	dut_instance: iitbproc
		port map (wa => wa, inst => inst, clk => clk, rst => rst, mw => mw, state_out => state_out);
	
	
	process 
		file in_file: text open read_mode is "D:/Courses/CS226-CPU-Project/input_file.txt";
		file output_file: text open write_mode is "D:/Courses/CS226-CPU-Project/output_file.txt";
		variable in_line,output_line : line;
		variable in_var,output_var : std_logic_vector(15 downto 0);
		variable count : integer range 0 to 64;
		variable curr : integer range 0 to 64;
		
		begin
		
			count := 0;
			curr := 0;
			wa <= "0000000000000000";
			rst <= '1';
				
			-- load instructions in memory
			while not endfile(in_file) loop
				readline (in_file, in_line);
				read (in_line, in_var);
				clk <= '1';
				inst <= in_var;
				mw <= '1';
				wait for 100 ns;
				clk <= '0';
				wait for 100 ns;
				wa <= std_logic_vector ( unsigned(wa) + 1);
				count := count + 1;
	
			end loop;
			
			rst <= '1';
			mw <= '0';
			clk <= '0';
			wait for 100 ns;
			clk <= '1';
			wait for 100 ns;
	
			rst <= '0';
			for i in 1 to 1000 loop
				clk <= '0';
				wait for 100 ns;
				clk <= '1';
				wait for 100 ns;
			end loop;
			
			
--			execute instructions
--			mw <= '0';
--			wa <= "0000000000000000";
--			rst <= '0';
--			
--			clk <= '0';
--			wait for 100 ns;
--			clk <= '1';
--			wait for 100 ns;
--			
--			while curr < count loop
--				clk <= '0';
--				wait for 100 ns;
--				clk <= '1';
--				wait for 100 ns;
--
--				output_var := mem_out;
--				write (output_line, output_var);
--				writeline (output_file, output_line);
--				
----				if (start = '1') then
--				curr := curr + 1;
----				end if;
--				wa <= std_logic_vector ( unsigned(wa) + 1);
--			end loop;
			
--			wa <= "0000000000000000";
--			clk <= '0';
--			wait for 100 ns;
--			clk <= '1';
--			wait for 100 ns;
--			clk <= '0';
--			wait for 100 ns;
--			rst <='1';
--			clk <= '1';
--			wait for 100 ns;
--			clk <= '0';
--			wait for 100 ns;
--			clk <= '1';
--			wait for 100 ns;
			
	wait;
	end process;
end architecture;