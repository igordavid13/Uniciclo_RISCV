-- Comparação com sinal servem para comparar o número binário em complemento de 2 podendo ser, números positivos e negativos, as sem sinal consideram o número binário sendo somento positivo, aumentando o range de alcance de representação. 

--Nesse trabalho foi simulado o funcionamento de uma Unidade Lógica Aritmética sendo realizadas operações de aritméticas e de comparações nos testes.


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.riscv_pkg.all;



entity ULA is

generic (WSIZE : natural := 32);

port (
	opcode : in std_logic_vector(3 downto 0);
	A, B : in std_logic_vector(WSIZE-1 downto 0);
	Z : out std_logic_vector(WSIZE-1 downto 0);
	zero : out std_logic);
end ULA;


architecture behavioral of ULA is
	signal a32 : std_logic_vector(31 downto 0);
	constant ADD_OP : std_logic_vector(3 downto 0) := "0000";
    constant SUB_OP : std_logic_vector(3 downto 0) := "0001";
    constant AND_OP : std_logic_vector(3 downto 0) := "0010";
    constant OR_OP : std_logic_vector(3 downto 0) := "0011";
    constant XOR_OP : std_logic_vector(3 downto 0) := "0100";
    constant SLL_OP : std_logic_vector(3 downto 0) := "0101";
    constant SRL_OP : std_logic_vector(3 downto 0) := "0110";
    constant SRA_OP : std_logic_vector(3 downto 0) := "0111";
    
    constant SLT_OP : std_logic_vector(3 downto 0) := "1000";
    constant SLTU_OP : std_logic_vector(3 downto 0) := "1001";
    constant SGE_OP : std_logic_vector(3 downto 0) := "1010";
    constant SGEU_OP : std_logic_vector(3 downto 0) := "1011";
    constant SEQ_OP : std_logic_vector(3 downto 0) := "1100";
    constant SNE_OP : std_logic_vector(3 downto 0) := "1101";

    constant LUI_OP : std_logic_vector(3 downto 0) := "1110";	
begin
	Z <= a32;
	proc_ula : process (A,B,opcode,a32) begin
		if(a32 = X"00000001") then zero <= '1'; else zero <= '0'; end if;
		case opcode is
			when ADD_OP => 
				a32 <= std_logic_vector(signed(A) + signed(B));
            when SUB_OP => 
				a32 <= std_logic_vector(signed(A) - signed(B));
            when AND_OP => 
				a32 <=  A and B;
            when OR_OP => 
				a32 <=  A or B;
            when XOR_OP => 
				a32 <=  A xor B;   
            when SLL_OP => 
            	a32 <= std_logic_vector(SHIFT_LEFT(unsigned(A), to_integer(unsigned(B))));   
            when SRL_OP => 
				a32 <= std_logic_vector(SHIFT_RIGHT(unsigned(A), to_integer(unsigned(B))));     
            when SRA_OP => 
				a32 <= std_logic_vector(SHIFT_RIGHT(signed(A), to_integer(unsigned(B))));
            
            when SLT_OP => 
				if(signed(A) < signed(B)) then a32 <= X"00000001"; else a32 <= X"00000000"; end if;
            when SLTU_OP => 
				if(unsigned(A) < unsigned(B)) then a32 <= X"00000001"; else a32 <= X"00000000"; end if;
            when SGE_OP => 
				if(signed(A) >= signed(B)) then a32 <= X"00000001"; else a32 <= X"00000000"; end if;
            when SGEU_OP => 
				if(unsigned(A) >= unsigned(B)) then a32 <= X"00000001"; else a32 <= X"00000000"; end if;
            when SEQ_OP => 
				if(signed(A) = signed(B)) then a32 <= X"00000001"; else a32 <= X"00000000"; end if;
            when SNE_OP => 
				if(signed(A) /= signed(B)) then a32 <= X"00000001"; else a32 <= X"00000000"; end if;    
                               
            when LUI_OP =>     
				a32 <= std_logic_vector(signed(B)); 
	    when others => null;
		end case;
	end process proc_ula;
end architecture behavioral;	








