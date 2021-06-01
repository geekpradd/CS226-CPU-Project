-- Main 16 bit ALU code, performs 4 operations as described
-- The control bit is used to control what operations it will perform on the inputs
-- The output is given as : [16 bit_vector of output], carry_out, zero_bit
-- When control bits are 00 : then we perform addition (Using the 16 bit KoggeStone fast adder)
-- When control bits are 01 : then we perform subtraction (Using the 16 bit KoggeStone fast adder)
-- When control bits are 10 : We perform a bitwise XOR of the elements of the bit_vectors A and B
-- When control bits are 10 : We perform a bitwise NAND of the elements of the bit_vectors A and B
-- In case of XOR and NAND, the carry_out bit is set to 0, while for the other two, it is the carry_out bit given by the adder/subtractor
-- Zero bit = '0' if output is not all zeros. If the output is "0000000000000000", it is '1'

-- Defining entity ALU
entity ALU is
	port(
		--inputs
		A, B : in bit_vector(15 downto 0);                 --Inputs
		ALU_ctrl : in bit_vector(1 downto 0);    				--Control bit
		
		--outputs
		ALU_out : out bit_vector(15 downto 0);					--Output vector
		carry_out, zero_bit : out bit								--Carry_out, zero bit
		);

end entity ALU;

architecture ALU_behavior of ALU is
	
	
	-- Component of the 16 bitwise xor (xor16.vhd)	
	component xor_16 is							
	port (A, B: in bit_vector(15 downto 0);
		   S: out bit_vector(16 downto 0));
	end component xor_16;
	
	-- Component of the 16 bitwise nand (nand16.vhd)	
	component nand_16 is
	port (A, B: in bit_vector(15 downto 0);
		   S: out bit_vector(16 downto 0));
	end component nand_16;
	
	-- Component of the KoggeStone adder (Adder16bit.vhd)
	component Adder16bit is
	port (A,B : in bit_vector(15 downto 0);
			S : out bit_vector(16 downto 0));
	end component Adder16bit;
	
	-- Component of the KoggeStone subtractor (Sub16bit.vhd)
	component Sub16bit is 
	port (A,B : in bit_vector(15 downto 0);
			S : out bit_vector(16 downto 0));
		
	end component Sub16bit;
	
	-- Component of the or of elements of bit_vector, i.e A(0) or A(1) or A(2) ......... or A(15)  (sixteen_or.vhd)
	component sixteen_or is 
	port (X : in bit_vector(15 downto 0);
			Y : out bit);
	end component sixteen_or;
	
	component MUX_41 is
	port(S0, S1 : in bit;
		  A, B, C, D : in bit;
		  Y : out bit);
	end component MUX_41;
	
	
	-- We used the following method : our internal signal is a 17 bit_vector, in which the left most bit, i.e internal(16) is the carry_out
	-- The bits from 15 to 0 are the output i.e ALU_out
	-- The signals defined below are used in the ALU
	
	signal internal : bit_vector(16 downto 0) := "00000000000000000";
	signal temp_xor: bit_vector(16 downto 0);
	signal temp_nand : bit_vector(16 downto 0);
	signal temp_add : bit_vector(16 downto 0);
	signal temp_sub : bit_vector(16 downto 0);
	signal temp_or : bit;
	
	begin
	-- We cannot do this since we have to use structural VHD : zero_bit <= '1' when internal(15 downto 0) = "0000000000000000" else '0';
	-- Hence, sixteen_or.vhd is used
	
		ALU_out <= internal(15 downto 0); 
		carry_out <= internal(16);
		zero_bit <= not (temp_or); -- sixteen_or returns the or of the elements. If temp_or is 0, we need zero_bit as 1. Hence not gate is used
		
		-- Port maps for the above signals
		xor_1 : xor_16 port map(A,B,temp_xor);
		nand_1 : nand_16 port map(A,B,temp_nand);
		add_1 : Adder16bit port map(A,B,temp_add);
		sub_1 : Sub16bit port map(A,B,temp_sub);
		or_1 : sixteen_or port map(internal(15 downto 0), temp_or);
	
		lvl1:
		
		for i in 0 to 16 generate
			MUX_in : MUX_41 port map(ALU_ctrl(0), ALU_ctrl(1), temp_add(i), temp_sub(i), temp_xor(i), temp_nand(i), internal(i)); 
		
		end generate lvl1;
		
		
		end ALU_behavior;
