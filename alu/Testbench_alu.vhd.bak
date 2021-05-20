use STD.textio.all;   -- To take i/o from a file

entity Testbench_alu is
end Testbench_alu;

architecture behav1 of Testbench_alu is
	--Input signals
	signal A 	      : bit_vector(15 downto 0) ;
	signal B 	      : bit_vector(15 downto 0) ;
	signal ALU_ctrl 	: bit_vector(1 downto 0);

	--To read and write to file
	file file_VECTORS : text;
	file file_RESULTS : text;

	--output signals
	signal carry_out, zero_bit : bit;
	signal ALU_out 		      : bit_vector(15 downto 0);
	
	--ALU component
	component ALU is 
		port(
		 	A, B 		: in bit_vector(15 downto 0);		-- operands
			ALU_ctrl		: in bit_vector(1 downto 0); -- Control
			carry_out, zero_bit: out bit;		-- carry_out, zero flag
			ALU_out 		: out bit_vector(15 downto 0)	-- result
		);
	end component;

	begin
		dut_instance_1: ALU --Instance of ALU
		port map(A,B,ALU_ctrl,carry_out,zero_bit,ALU_out); --Sensitivity list

		process
			
			-- This is to take i/o from file : "tb.txt" which contains our test cases
			variable v_ILINE   : line;							
			variable v_OLINE   : line;
			variable v_A       : bit_vector(15 downto 0);
			variable v_B       : bit_vector(15 downto 0);
			variable v_ctrl    : bit_vector(1 downto 0);
			variable v_SPACE_1 : character;
			variable v_SPACE_2 : character;
		
		begin
		
		file_open(file_VECTORS, "D:\Eeshaan\IIT\SemThree\Digital\SemProj\tb.txt", read_mode); --Absolute location of txt file 
		file_open(file_RESULTS, "D:\Eeshaan\IIT\SemThree\Digital\SemProj\output_results.txt", write_mode); --We will write to this file
		
		while not endfile(file_VECTORS) loop --Looping till file ends
			readline(file_VECTORS, v_ILINE);  --Reading Line : The format of line is : '16bitvectorA 16bitvectorB ctrl'
			read(v_ILINE, v_A); 					 --Reads 16bitvectorA i.e A
			read(v_ILINE, v_SPACE_1);			 --Reads space
			read(v_ILINE, v_B); 					 --Reads 16bitvectorB i.e B
			read(v_ILINE, v_SPACE_2);			 --Reads space
			read(V_ILINE, v_ctrl);				 --Reads ctrl bits
			
			
			A <= v_A;                     -- A is v_A i.e 16bitvector A
			B <= v_B;							-- B is v_B i.e 16bitvector B
			ALU_ctrl <= v_ctrl;				-- ALU_ctrl is v_ctrl i.e ctrl bits
			
			wait for 5 ns;
			
			write(v_OLINE, ALU_out, right, 15);   --Write the output ALU_out to output_results.txt
			write(v_OLINE, carry_out, right, 15); --Write the output carry_out to output_results.txt
			write(v_OLINE, zero_bit, right, 15);  --Write the output zero_bit to output_results.txt
			writeline(file_RESULTS, v_OLINE);     --Line end
			
		end loop;  --Loop end
		
		file_close(file_VECTORS); --Close both files
		file_close(file_RESULTS);
		wait;

		end process;
	end behav1;