library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_rv is
   port (
       clock : in std_logic;
       we : in std_logic;
       address : in std_logic_vector;
       datain : in std_logic_vector;
       dataout : out std_logic_vector
   );
end entity ram_rv;


architecture a of ram_rv is
  Type ram_type is array (0 to (2**address'length)-1) of 	std_logic_vector(datain'range);
  signal ram : ram_type;
  signal read_address : std_logic_vector(address'range);
  begin
     process (clock)
     begin
      if rising_edge(clock) then
        if we = '1' then
          ram(to_integer(unsigned(address))) <= datain;
        end if;
        read_address <= address;
      end if;
     end process;
     dataout <= ram(to_integer(unsigned(read_address)));
end a;

