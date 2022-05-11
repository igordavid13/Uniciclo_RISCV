library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity controlULA is
  port ( funct7 : in std_logic_vector(6 downto 0);
      funct3 : in std_logic_vector(2 downto 0);
       aluop : in std_logic_vector(2 downto 0);
      aluctr : out std_logic_vector(3 downto 0));
end entity;

architecture a of controlULA is
begin
    process(funct7, funct3, aluop) begin
     case aluop is

         when "000" => -- LW, SW, JAL, JALR and AUIPC
         	aluctr <= "0000";


         when "001" => -- Branch
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
                    
         when "010" => -- Operações aritméticas
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
				when "010" =>  
					aluctr <= "1000"; --SLT
				when "011" => 	 
					aluctr <= "1001"; --SLTU

				when others => null;		  
			end case;		  

		when "011" => -- Lui
			aluctr <= "1110"; --LUI

		when "111"=> --Operaçõesa aritméticas com imediato
		case funct3 is
			when "000" =>
				aluctr <= "0000"; --ADDi
			when "111" =>
				aluctr <= "0010"; --ANDi
			when "110" =>
				aluctr <= "0011"; --ORi
			when "100" =>
				aluctr <= "0100"; --XORi
			when "001" =>
				aluctr <= "0101"; --SLLi
			when "101" =>
				if (funct7(5)='1')
					  then aluctr <= "0111"; --SRAi
				  else 
					  aluctr <= "0110"; --SRLi
				  end if;
			when "010" =>
				aluctr <= "1000"; --slti
			when "011" => 	 
				aluctr <= "1001"; --SLTUi	
			when others => null;		  
		end case;	
			
		when others => null;	  	      		
    end case;
	end process;
end architecture;
