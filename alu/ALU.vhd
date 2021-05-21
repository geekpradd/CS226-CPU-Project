library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 

entity ALU is
	port(
		A, B : in std_logic_vector(15 downto 0);                 --Inputs
		control : in std_logic_vector(1 downto 0);    				--Control bit

		ALU_out : out std_logic_vector(15 downto 0);					--Output vector
		carry, zero : out std_logic								--Carry_out, zero bit
		);

end entity ALU;

architecture ALU_behavior of ALU is
	
	component nand_16 is
	port (A, B: in std_logic_vector(15 downto 0);
		   S: out std_logic_vector(16 downto 0));
	end component nand_16;

	component Adder16bit is
	port (A,B : in std_logic_vector(15 downto 0);
			S : out std_logic_vector(16 downto 0));
	end component Adder16bit;
	
	component Sub16bit is 
	port (A,B : in std_logic_vector(15 downto 0);
			S : out std_logic_vector(16 downto 0));
		
	end component Sub16bit;
	
	signal temp_nand : std_logic_vector(16 downto 0);
	signal temp_add : std_logic_vector(16 downto 0);
	signal temp_sub : std_logic_vector(16 downto 0);
	
	begin

		nand_1 : nand_16 port map(A,B,temp_nand);
		add_1 : Adder16bit port map(A,B,temp_add);
		sub_1 : Sub16bit port map(A,B,temp_sub);
	
		process (control, temp_nand, temp_add, temp_sub)
		begin
			if (control = "10") then
				ALU_out <= temp_nand(15 downto 0);
				carry <= temp_nand(16);
				zero <= not (temp_nand(0) or temp_nand(1) or temp_nand(2) or temp_nand(3) or temp_nand(4) or temp_nand(5) or temp_nand(6) or temp_nand(7) or temp_nand(8) or temp_nand(9) or temp_nand(10) or temp_nand(11) or temp_nand(12) or temp_nand(13) or temp_nand(14) or temp_nand(15));
			else 
				if (control = "00") then
					ALU_out <= temp_add(15 downto 0);
					carry <= temp_add(16);
					zero <= not (temp_add(0) or temp_add(1) or temp_add(2) or temp_add(3) or temp_add(4) or temp_add(5) or temp_add(6) or temp_add(7) or temp_add(8) or temp_add(9) or temp_add(10) or temp_add(11) or temp_add(12) or temp_add(13) or temp_add(14) or temp_add(15));
				else 
					ALU_out <= temp_sub(15 downto 0);
					carry <= temp_sub(16);
					
					zero <= not (temp_sub(0) or temp_sub(1) or temp_sub(2) or temp_sub(3) or temp_sub(4) or temp_sub(5) or temp_sub(6) or temp_sub(7) or temp_sub(8) or temp_sub(9) or temp_sub(10) or temp_sub(11) or temp_sub(12) or temp_sub(13) or temp_sub(14) or temp_sub(15));
				
				end if;
			end if;
		
		end process;
		
		
	end ALU_behavior;
