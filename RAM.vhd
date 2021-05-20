LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY RAM IS
   PORT
   (
      address:  IN   std_logic_vector (15 DOWNTO 0);
		input:  IN   std_logic_vector (15 DOWNTO 0);
		 output:     OUT  std_logic_vector (15 DOWNTO 0);
      writeControl :    IN   std_logic;
		clk: IN   std_logic
   );
END RAM;
ARCHITECTURE rtl OF RAM IS
   TYPE mem IS ARRAY(0 TO 65535) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL ram_block : mem:= (others => "0000000000000000");
BEGIN
   PROCESS (clk)
   BEGIN
 -- clk'event AND clk = '1'
      IF (rising_edge(clk)) THEN
         IF (writeControl = '1') THEN
            ram_block((to_integer(unsigned(address)))) <= input;
         END IF;
			report  integer'image(to_integer(unsigned(address))) & " " & integer'image(to_integer(unsigned(ram_block((to_integer(unsigned(address)))))));
         output <= ram_block((to_integer(unsigned(address))));
      END IF;
   END PROCESS;
END rtl;