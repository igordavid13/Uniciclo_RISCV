library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity rom_rv is
   port (
     address : in std_logic_vector;
     dataout : out std_logic_vector
   );
end entity rom_rv;


architecture a of rom_rv is
  Type rom_type is array (0 to (2**address'length)-1) of std_logic_vector(dataout'range);
  
  impure function init_rom_hex return rom_type is
  file text_file : text open read_mode is "teste_arquivo.txt";
  variable text_line : line;
  variable rom_content : rom_type;
  variable i : natural := 0; 
begin
  while(not endfile(text_file)) loop
    readline(text_file, text_line);
    hread(text_line, rom_content(i));
    i := i+1;
  end loop;
 
  return rom_content;
end function;
  signal rom : rom_type := init_rom_hex;
  begin
     process (address)
    	begin
        	dataout <= rom(to_integer(unsigned(address)));
    end process;
end a;