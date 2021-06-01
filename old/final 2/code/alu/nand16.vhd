library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 
-- To calculate the bitwise NAND of two bit_vectors A and B

entity nand_16 is

	port( A, B: in std_logic_vector(15 downto 0);
		   S: out std_logic_vector(16 downto 0));
			
end nand_16;

architecture behav of nand_16 is

	component two_nand is
		port(A,B : in std_logic;
				C : out std_logic);
	end component two_nand;	
	
	signal temp : std_logic_vector(15 downto 0);
	begin
		lvl1:
		
		for i in 0 to 15 generate
			nand_in : two_nand port map(A(i), B(i), temp(i)); --Uses the two_nand.vhd
		end generate lvl1;
		
		S <= '0' & temp; 
		
end behav;