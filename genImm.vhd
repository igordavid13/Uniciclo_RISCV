library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity genImm32 is
port (
	instr : in std_logic_vector(31 downto 0);
	imm32 : out signed(31 downto 0));
end genImm32;


architecture a of genImm32 is
	begin    
    process(instr) is
      begin

        case (resize(UNSIGNED(instr(6 downto 0)), 8)) is
        when (X"33") =>            -- R_type
        	imm32 <= resize((X"00000000"), 32);
     	when (X"03") | (X"13") | (X"67") =>     --I_type
     		imm32 <= resize(signed(instr(31 downto 20)), 32);    
        when (X"23") =>            -- S_type
        	imm32 <= resize(signed(instr(31 downto 25) & instr(11 downto 7)), 32);
        when (X"63") =>            -- SB_type
        	imm32 <= resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32);
        when (X"37") =>            -- U_type
        	imm32 <= resize(signed(instr(31 downto 12) & X"000"), 32);	 
        when (X"6F") =>            -- UJ_type
       		imm32 <= resize(signed(instr(31) & instr(19 downto 12) & instr(20)  & instr(30 downto 21) & '0'), 32);
        when (X"17") =>    -- AUIPC
    		imm32 <= resize(signed(instr(31 downto 12) & X"000"), 32);    
            
        when others =>       -- Mop up the rest
        	null;              -- no action, no assignments made
        end case;

    end process;    

end a;

