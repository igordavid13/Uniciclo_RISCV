library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX is

	port(
		s:	in std_logic;
		entrada_A:	in std_logic_vector(31 downto 0);
		entrada_B:	in std_logic_vector(31 downto 0);
		saida:	out std_logic_vector(31 downto 0)
	);
end MUX;

architecture a of MUX is
	
	begin
    	proc_mux : process (s, entrada_A, entrada_B) begin
          if (s = '1') then
              saida <= entrada_A;
          else
              saida <= entrada_B;
          end if;
		end process proc_mux;
end a;