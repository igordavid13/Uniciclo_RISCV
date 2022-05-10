library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.riscv_pkg.all;

entity ram is
   port (
       clock : in std_logic;
       memWrite : in std_logic;
       memRead: in std_logic;
       address : in std_logic_vector(11 downto 0);
       datain : in std_logic_vector(31 downto 0);
       dataout : out std_logic_vector
   );
end entity ram;


architecture a of ram is
  Type ram_type is array (0 to  (2**address'length)-1) of 	std_logic_vector(datain'range); 

  impure function init_ram_hex return ram_type is
    file text_file : text open read_mode is "C:\Users\igord\Desktop\7_SEMESTRE\OAC\PROJETO FINAL - UNICICLO\GIT\Uniciclo_RISCV\data.txt";  --Caminho pro arquivo
    variable text_line : line;
    variable ram_content : ram_type;
    variable i : natural := 0; 

    begin

    while(not endfile(text_file)) loop
      readline(text_file, text_line);
      hread(text_line, ram_content(i));
      i := i+1;
    end loop;
   
    return ram_content;
  end function;

  signal ram : ram_type := init_ram_hex;
  begin
    process(address)
    begin  
      if memRead = '1' then
        dataout <= ram(to_integer(unsigned(address and b"011111111111"))); -- Confere se o endereço começa em x2000. Se o endereço for x2004(8196), o address recebe X801(2049), converte para a posição 1, logo: 2049-2048 =  1.
      else
        dataout <= x"00000000";
      end if;
    end process;
      
    process (clock)
    begin
    if rising_edge(clock) then
      if memWrite = '1' then
        ram(to_integer(unsigned(address and b"011111111111"))) <= datain;
      end if;
    end if;
      
    end process;

end a;

