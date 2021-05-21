library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 
entity testbench is 
end testbench;

architecture tb of testbench is 
	
	signal a,b : std_logic_vector(15 downto 0);
	signal control : std_logic_vector(1 downto  0);
	signal output : std_logic_vector(15 downto  0);
	signal zero : std_logic;
	signal carry : std_logic;
	
component ALU is
	port(
		A, B : in std_logic_vector(15 downto 0);                 --Inputs
		control : in std_logic_vector(1 downto 0);    				--Control bit

		ALU_out : out std_logic_vector(15 downto 0);					--Output vector
		carry, zero : out std_logic								--Carry_out, zero bit
		);

end component;


	begin 
	dut_instance : ALU
	port map(a,b,control, output, carry, zero);
	
	process 
	begin
	
	
	a <= "0110001000000000";
	b <= "0011100101111111";
	control <= "01";
	wait for 5ns;
	
	end process;
	
end tb;