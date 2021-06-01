library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 
--16 bit subtractor code

entity Sub16bit is 

	port(A,B : in std_logic_vector(15 downto 0);
			S : out std_logic_vector(16 downto 0));
			
end entity Sub16bit;


architecture subbhv of Sub16bit is

	component KS16bit is

		port (G,P : in std_logic_vector(15 downto 0);
				Cin : in std_logic;
				S : out std_logic_vector(16 downto 0));  
				
	end component;
	
	signal cin : std_logic;
	signal gin,pin : std_logic_vector(15 downto 0); 
	
	begin
	
	cin <= '1';
	gin <= A and (not B);
	pin <= A xor (not B);
	
	adder16 : KS16bit port map(gin,pin,cin,S);
	
end subbhv;
	