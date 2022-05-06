library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;


entity xreg is
    generic (WSIZE : natural := 32);
    port (
        clk, wren, rst : in std_logic;
        rs1, rs2, rd : in std_logic_vector(4 downto 0);
        data : in std_logic_vector(WSIZE-1 downto 0);
        ro1, ro2 : out std_logic_vector(WSIZE-1 downto 0));
end xreg;


architecture behavioral of xreg is
    type registerFile is array(0 to WSIZE-1) of std_logic_vector(WSIZE-1 downto 0);
    signal registers : registerFile;
    begin
         regFile : process (clk) is
          begin
            if(rst = '1') then
                for I in 0 to WSIZE-1 loop
                    registers(I) <= X"00000000";
                end loop;
                   elsif rising_edge(clk) then
                ro1 <= registers(to_integer(unsigned(rs1)));
                ro2 <= registers(to_integer(unsigned(rs2)));
                        if(wren = '1' and (to_integer(unsigned(rd))) > 0) then
                            registers(to_integer(unsigned(rd))) <= data;
                       end if;
            end if;
        end process regFile;
end architecture behavioral;