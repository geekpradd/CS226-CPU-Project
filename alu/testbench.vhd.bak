entity testbench is 
end testbench;

architecture tb of testbench is 
	
	signal a,b : bit_vector(15 downto 0);
	signal sum : bit_vector(16 downto  0);
	
	component Adder16bit is 

		port(A,B : in bit_vector(15 downto 0);
				S : out bit_vector(16 downto 0));
				
	end component;


	begin 
	dut_instance : Adder16bit
	port map(a,b,sum);
	
	process 
	begin
	
	
	a <= "0110001000000000";
	b <= "0011100101111111";
	wait for 5ns;
	
	end process;
	
end tb;