--16 bit subtractor code

entity Sub16bit is 

	port(A,B : in bit_vector(15 downto 0);
			S : out bit_vector(16 downto 0));
			
end entity Sub16bit;


architecture subbhv of Sub16bit is

	component KS16bit is

		port (G,P : in bit_vector(15 downto 0);
				Cin : in bit;
				S : out bit_vector(16 downto 0));  
				
	end component;
	
	signal cin : bit;
	signal gin,pin : bit_vector(15 downto 0); 
	
	begin
	
	cin <= '1';
	gin <= A and (not B);
	pin <= A xor (not B);
	
	adder16 : KS16bit port map(gin,pin,cin,S);
	
end subbhv;
	