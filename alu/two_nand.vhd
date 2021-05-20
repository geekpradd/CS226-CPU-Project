
entity two_nand is
 
	port ( A : in bit; 
			 B : in bit; 
			 C : out bit); 
			 
end two_nand; 
 
architecture Behavioral of two_nand is 

	begin 
		C <= A nand B;
 
end Behavioral;