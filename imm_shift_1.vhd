library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.riscv_pkg.all;



entity imm_shift_1 is

    generic (WSIZE : natural := 32);
    
    port (
        entrada : in std_logic_vector(WSIZE-1 downto 0);
        saida : out std_logic_vector(WSIZE-1 downto 0) := X"00000000");
    end imm_shift_1;
    
    architecture behavioral of imm_shift_1 is
    begin    
        process(entrada) begin
            saida <= entrada(30 downto 0) & '0';
    end process;
end architecture behavioral;