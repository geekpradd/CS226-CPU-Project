library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 


entity Controller is
  port(
    clk,rst     : in  std_logic;
	 op : out std_logic_vector(3 downto 0));
end entity;

architecture behave of Controller is

----------------------------------------------------------------------------------------------------------------------------------------

type FSMState is (Sres, S0, S00, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20);
signal state: FSMState;
signal pc_in, pc_out, ir_in, ir_out, m_add, m_data_in, m_data_out, alu_a, alu_b, alu_c :std_logic_vector(15 downto 0);
signal rf_a1, rf_a2, rf_a3 :std_logic_vector(2 downto 0);
signal rf_d1, rf_d2, rf_d3, t1, t2, t3 :std_logic_vector(15 downto 0);
signal c_in, c_out, z_in, z_out, alu_carry, alu_zero, ir_write, pc_write, t1_write, t2_write, t3_write, rf_write, memory_write, c_write, z_write :std_logic;
signal alu_op :std_logic_vector(1 downto 0);

begin

process(clk,state)	
	variable op_code :std_logic_vector(3 downto 0);
	variable next_state: FSMState;
	  
begin
	next_state := state;
  case state is
		when Sres =>
			 c_write <= '0';
			 z_write <= '0';
			 ir_write <= '0';
			 pc_write <= '0';
			 t1_write <= '0';
			 t2_write <= '0';
			 t3_write <= '0';
			 rf_write <= '0';
			 memory_write <= '0';
			 next_state := S0;
----------------------------------------------------------
		when S0 =>
			m_add <= pc_out;
			ir_in <= m_data_out;
			ir_write <= '1';
			op_code := ir_out(15 downto 12);
			case op_code is
				when "0000" =>
					next_state := S00;
				when "0001" =>
					next_state := S00;
				when "0010" =>
					next_state := S00;
				when "0011" =>
					next_state := S00;
				when "0100" =>
					next_state := S00;
				when "0101" =>
					next_state := S00;
				when "0110" =>
					next_state := S00;
				when "0111" =>
					next_state := S00;
				when others => null;
			end case;
----------------------------------------------------------
		when S00 =>
				pc_write <= '1';
				alu_op <= "00";
				alu_a <= pc_out;
				alu_b <= "0000000000000001";
				pc_in <= alu_c;

				if (op_code = "0000" or op_code = "0010") then
					if ( ((not ir_out(0)) and (not ir_out(1))) or (ir_out(0) and z_out) or (ir_out(1) and c_out) = '1' ) then
						next_state := S1;
					else
						next_state := S0;
					end if;
				elsif (op_code = "0001") then
					next_state := S4;
				elsif (op_code = "0101" or op_code = "0100") then
					next_state := S8;
				elsif (op_code = "0011") then
					next_state := S6;
				elsif (op_code = "0110" or op_code = "0111") then
					next_state := S11;
				else
					next_state := S0;
				end if;
				
----------------------------------------------------------
		when S1 =>
				t1_write <= '1';
				t2_write <= '1';
				rf_a1 <= ir_out(11 downto 9);
				rf_a2 <= ir_out(8 downto 6);
				t1 <= rf_d1;
				t2 <= rf_d2;

				if (op_code = "0000" or op_code = "0010") then
					next_state := S2;
				elsif (op_code = "1100") then
					next_state := S16;
				else
					next_state := S0;
				end if;
----------------------------------------------
		when S2 =>
				t3_write <= '1';
				c_write <= '1';
				z_write <= '1';
				if(op_code="0010") then
				  alu_op <="10";
				else 
				  alu_op <= "00";
				end if;
				alu_a <= t1;
				alu_b <= t2;
				t3 <= alu_c;
				c_in <= alu_carry;
				z_in <= alu_zero;

				case op_code is
					when "0000" =>
						next_state := S3;
					when "0010" =>
						next_state := S3;
					when "0001" =>
						next_state := S5;
					when "0101" =>
						next_state := S10;
					when "0100" =>
						next_state := S9;
					when others =>
						next_state := S0;
				end case;
---------------------------------------------------------------			 
		when S3 =>
			   rf_write <= '1';
				rf_d3 <= t3;
				rf_a3 <= ir_out(5 downto 3);
				next_state := S0;
-----------------------------------------------------------------
		when S4 =>
				t1_write <= '1';
				t2_write <= '1';
				rf_a1 <= ir_out(11 downto 9);
				t1 <= rf_d1;
				t2 <= "0000000000" & ir_out(5 downto 0);

				if (op_code = "0001") then
					next_state := S2;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------				
		when S5 =>
				rf_write <= '1';
				rf_d3 <= t3;
				rf_a3 <= ir_out(8 downto 6);
				next_state := S0;
-----------------------------------------------------------------				
		when S6 =>
			   t3_write <= '1';
				alu_a <= "0000000" & ir_out(8 downto 0);

				if (op_code = "0011") then
					next_state := S7;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------
		when S7 =>
			   rf_write <= '1';
				rf_d2 <= t3;
				rf_a3 <= ir_out(11 downto 9);
				next_state := S0;
-----------------------------------------------------------------
      when S8 =>
				rf_a2 <= ir_out(8 downto 6);
				t2 <= rf_d2;
				t1 <= "0000000000" & ir_out(5 downto 0);

				if (op_code = "0100" or op_code = "0101") then
					next_state := S2;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------
      when S9 =>
				rf_write <= '1';
				m_add <= t3;
				rf_d3 <= m_data_out;
				rf_a3 <= ir_out(11 downto 9);
				next_state := S0;
-----------------------------------------------------------------
      when S10 =>
				memory_write <= '1';
            	m_add <= t3;
				rf_a1 <= ir_out(11 downto 9);
				m_data_in <= rf_d1;
				next_state := S0;
-----------------------------------------------------------------
	   when S11 =>
				t1_write <= '1';
				t2_write <= '1';
				rf_a1 <= ir_out(11 downto 9);
				t1 <= rf_d1;
				t2 <= "000";

				if (op_code = "0111") then
					next_state := S15;
				elsif (op_code = "0110") then
					next_state := S12;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------
      when S12 =>
				rf_write <= '1';
				m_add <= t1;
				rf_d3 <= m_data_out;
				rf_a3 <= t2;

				if (op_code = "0110") then
					next_state := S13;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------
      when S13 =>
				t1_write <= '1';
				alu_op <= "00";
				alu_a <= t1;
				alu_b <= "0000000000000001";
				t1 <= alu_c;

				if (op_code = "0110" or op_code = "0111") then
					next_state := S14;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------
      when S14 =>
				t2_write <= '1';
				alu_op <= "00";
				alu_a <= t2;
				alu_b <= "0000000000000001";
				t2 <= alu_c;

				if (t2(2 downto 0) = "000") then
					next_state := S0;
				else
					if (op_code = "0111") then
						next_state := S15;
					elsif (op_code = "0110") then
						next_state := S12;
					else
						next_state := S0;
					end if;
				end if;
-----------------------------------------------------------------				  
      when S15 =>
				memory_write <= '1';
				rf_a1 <= t2;
				m_data_in <= rf_d1;
				m_add <= t1;

				if (op_code = "0111") then
					next_state := S13;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------
      when S16 =>
				alu_op <= "01";
				alu_a <= t1;
				alu_b <= t2;
				t3 <= alu_c;

				if (t3(2 downto 0) = "000") then
					next_state := S17;
				else
					next_state := S00;
				end if;
-----------------------------------------------------------------
      when S17 =>
				pc_write <= '1';
				alu_op <= "00";
				alu_a <= pc_out;
				alu_b <= "0000000000" & ir_out(5 downto 0);
				pc_in <= alu_c;
				next_state := S0;
-----------------------------------------------------------------
      when S18 =>
				rf_write <= '1';
				rf_a3 <= ir_out(11 downto 9);
				rf_d3 <= pc_out;

				if (op_code = "1000") then
					next_state := S19;
				elsif (op_code = "1001") then
					next_state := S20;
				else
					next_state := S0;
				end if;
-----------------------------------------------------------------
      when S19 =>
				pc_write <= '1';
				alu_op <= "00";
				alu_a <= pc_out;
				alu_b <= "0000000" & ir_out(8 downto 0);
				pc_in <= alu_c;
				next_state := S0;
-----------------------------------------------------------------
      when S20 =>
				pc_write <= '1';
				rf_a1 <= ir_out(8 downto 6);
				pc_in <= rf_d1;
				next_state := S0;
-----------------------------------------------------------------				
		when others => null;
  end case;		
  
-- if(clk'event and clk = '0') then
--          if(rst = '1') then
--             state <= Sres;
--          else
--             state <= next_state;
--				 mem_addr<=next_ip;
--          end if;
--     end if;
end process;
end behave;