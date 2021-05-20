library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
  port(
	 address       : in std_logic_vector(15 downto 0);
    output        : out std_logic_vector(15 downto 0);
    input       : in  std_logic_vector(15 downto 0);
    writeControl : in  std_logic;
    clk         : in  std_logic
    );
end RAM;


architecture arch of RAM is
  type ramstruct is array(0 to 65535) of std_logic_vector(15 downto 0);
  signal ram : ramstruct := (others=>"0000000000000000");
begin
  output <= ram((to_integer(unsigned(address))));
		
  ramFile : process (clk) is
  begin
    if rising_edge(clk) then

      if writeControl = '1' then
        ram((to_integer(unsigned(address)))) <= input; 
      end if;

    end if;
  end process;
end arch;