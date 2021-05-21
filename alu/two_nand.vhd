library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 

entity two_nand is
 
	port ( A : in std_logic; 
			 B : in std_logic; 
			 C : out std_logic); 
			 
end two_nand; 
 
architecture Behavioral of two_nand is 

	begin 
		C <= A nand B;
 
end Behavioral;