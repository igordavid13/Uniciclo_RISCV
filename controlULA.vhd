library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity controlULA is
  port ( funct7 : in std_logic_vector(6 downto 0);
      funct3 : in std_logic_vector(2 downto 0);
       aluop : in std_logic_vector(1 downto 0);
      aluctr : out std_logic_vector(3 downto 0));
end entity;

architecture a of controlULA is
begin
    process(funct7, funct3, aluop) begin
     case aluop is

         when "00" => -- LW, SW, JAL, JALR and AUIPC
         	aluctr <= "0000";


         when "01" => -- Branch
         	case funct3 is
            	-- BEQ
        		when "000" =>
        			aluctr <= "1100";
                -- BNE
       			when "001" =>
                	aluctr <= "1101";
                -- BLT
       			when "100" =>
                	aluctr <= "1000";
                -- BLTU
       			when "110" =>
                	aluctr <= "1001";
        		-- BGE
       			when "101" =>
                	aluctr <= "1010";
                -- BGEU
       			when "111" =>
                	aluctr <= "1011";
				when others => null;	
			 end case;		
                    
         when "10" => -- Operações aritméticas
         	case funct3 is
        		when "000" =>
                  	   if (funct7(5)='1')
                      		then aluctr <= "0001"; --SUB
                  	   else 
                      		aluctr <= "0000"; --ADD
                  	   end if;
        		when "111" =>
        			aluctr <= "0010"; --AND
       			when "110" =>
                		aluctr <= "0011"; --OR
        		when "100" =>
          	      		aluctr <= "0100"; --XOR
				when "001" =>
          	      		aluctr <= "0101"; --SLL
				when "101" =>
			    	if (funct7(5)='1')
                      	then aluctr <= "0111"; --SRA
                  	else 
                      	aluctr <= "0110"; --SRL
                  	end if;
				when others => null;		  
			end case;		  

		when "11" => -- Lui
			aluctr <= "1110"; --LUI
			
		when others => null;	  	      		
    end case;
	end process;
end architecture;
