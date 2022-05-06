library ieee;                                               
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;                                

entity testbench is
end testbench;

architecture behavioral OF testbench IS

component processador
	port (
	clock_geral : in std_logic
	);
end component;

signal clock_geral_in:  std_logic;

begin
    DUT: processador port map(clock_geral => clock_geral_in);

    process -- sinal de clock
	begin
		clock_geral_in <= '0';
        wait for 5 ns;
        clock_geral_in <= '1';
        wait for 5 ns;
    end process;


                                         
end behavioral;