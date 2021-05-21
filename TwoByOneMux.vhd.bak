library work;
use work.all;
library ieee; 
use ieee.std_logic_1164.all;

entity TwoByOneMux is
port (i0 : in std_logic;
		i1 : in std_logic;
		sel : in std_logic; 
		z : out std_logic);
end entity;

architecture ARCH of TwoByOneMux is 
	component OrGate is 
		port (X,Y : in std_logic;
		O : out std_logic);
	end component;
	
	component AndGate is 
		port (P,Q : in std_logic;
		R : out std_logic);
	end component;
	
	component NotGate is 
		port (K: in std_logic;
		L : out std_logic);
	end component;
	
	signal not_sel, x, y: std_logic;
begin 

	Chip1: OrGate
	port map(x, y, z);

	Chip2: AndGate
	port map(i1, sel, x);
	
	Chip3: AndGate
	port map(i0, not_sel, y);

	Chip4: NotGate
	port map(sel, not_sel);
end;