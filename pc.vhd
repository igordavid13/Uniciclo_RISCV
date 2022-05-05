library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(
		pc_in:	in std_logic_vector(31 downto 0) := x"00000000";
		clock:	in std_logic;
		
		pc_new:	out std_logic_vector(31 downto 0) := X"00000000"
	);
end PC;

architecture a of PC is
	
	begin
	
	proc_pc: process (clock)
	begin
		if rising_edge(clock) then
			pc_new <= pc_in;
            
		end if;
	end process;
end architecture a;