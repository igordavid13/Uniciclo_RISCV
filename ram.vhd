library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
   port (
       clock : in std_logic;
       we : in std_logic;
       address : in std_logic_vector(11 downto 0);
       datain : in std_logic_vector(31 downto 0);
       dataout : out std_logic_vector
   );
end entity ram;


architecture a of ram is
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

