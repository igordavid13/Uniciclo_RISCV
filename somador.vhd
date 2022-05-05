library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is

	port 
	(
		entrada_A: in std_logic_vector  (31 downto 0);
		entrada_B: in std_logic_vector  (31 downto 0);
		saida: out std_logic_vector(31 downto 0)
	);

end somador;

architecture a of somador is
begin

	saida <= std_logic_vector(signed(entrada_A) + signed(entrada_B));

end a;
