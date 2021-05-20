library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_1bit is
  port(
    output        : out std_logic;
    input       : in  std_logic;
    writeControl : in  std_logic;
    clk         : in  std_logic
    );
end register_1bit;


architecture arch of register_1bit is
  signal register1 : std_logic := '0';
begin
  output <= register1;
		
  regFile : process (clk) is
  begin
    if rising_edge(clk) then

      if writeControl = '1' then
        register1 <= input; 
      end if;

    end if;
  end process;
end arch;