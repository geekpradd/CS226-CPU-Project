-- 16bit Adder code
entity Adder16bit is 

	port(A,B : in bit_vector(15 downto 0); -- inputs
			S : out bit_vector(16 downto 0)); -- outputs
			
end entity Adder16bit;


--The KS16bit takes in G and P as the inputs and gives a 17bit vector as output with left most bit as carry_out
architecture addbhv of Adder16bit is 

	component KS16bit is

		port (G,P : in bit_vector(15 downto 0);
				Cin : in bit;
				S : out bit_vector(16 downto 0));  
				
	end component;
	
	signal cin : bit;
	signal gin,pin : bit_vector(15 downto 0); 
	
	begin
	
	cin <= '0';
	gin <= A and B;
	pin <= A xor B;
	
	adder16 : KS16bit port map(gin,pin,cin,S);
	
end addbhv;
	