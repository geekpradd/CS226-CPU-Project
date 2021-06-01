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
	signal x, y: std_logic;
begin 
	x <= i1 and sel;
	y <= i0 and (not sel);
	z <= x or y;
end;