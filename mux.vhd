library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

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
		p_mux : process(s,entrada_A,entrada_B)
		begin
		  case s is
			when '0' => 
				saida <= entrada_A ;
			when '1' => 	
				saida <= entrada_B ;
			when others => 
				saida <= X"00000000";
		  end case;
		end process p_mux;	
end a;