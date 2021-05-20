entity testbench is 
end testbench;

architecture tb of testbench is 
	
	signal a,b : bit_vector(15 downto 0);
	signal control : bit_vector(1 downto  0);
	signal output : bit_vector(15 downto  0);
	signal zero : bit;
	signal carry : bit;
	
component ALU is
	port(
		A, B : in bit_vector(15 downto 0);                 --Inputs
		control : in bit_vector(1 downto 0);    				--Control bit

		ALU_out : out bit_vector(15 downto 0);					--Output vector
		carry, zero : out bit								--Carry_out, zero bit
		);

end component;


	begin 
	dut_instance : ALU
	port map(a,b,control, output, carry, zero);
	
	process 
	begin
	
	
	a <= "0110001000000000";
	b <= "0011100101111111";
	control <= "00";
	wait for 5ns;
	
	end process;
	
end tb;