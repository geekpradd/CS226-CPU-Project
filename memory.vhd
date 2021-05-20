LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY memory IS
   PORT
   (
      address:  IN   std_logic_vector (15 DOWNTO 0);
		input:  IN   std_logic_vector (15 DOWNTO 0);
		 output:     OUT  std_logic_vector (15 DOWNTO 0);
      writeControl :    IN   std_logic;
		clk: IN   std_logic
   );
END memory;
ARCHITECTURE rtl OF memory IS
   TYPE mem IS ARRAY(0 TO 65535) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL ram_block : mem;
BEGIN
   PROCESS (clk)
   BEGIN
 -- clk'event AND clk = '1'
      IF (rising_edge(clk)) THEN
         IF (writeControl = '1') THEN
            ram_block((to_integer(unsigned(address)))) <= input;
         END IF;
         output <= ram_block((to_integer(unsigned(address))));
      END IF;
   END PROCESS;
END rtl;