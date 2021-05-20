library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 

entity four_or is
	port( A0,A1,A2,A3 : in bit;
			Y : out bit);
			
end entity four_or;

architecture or4_bhv of four_or is
	begin
		Y<= (A0 or A1) or (A2 or A3);
		
end architecture or4_bhv;