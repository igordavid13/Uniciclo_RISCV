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
    variable text_line : line ;
    variable ram_content : ram_type;
    variable i : natural := 0;

    begin
    --write(text_line, string'("00000000"));
    --hread(text_line,ram_content(2047));
    while(not endfile(text_file)) loop
      readline(text_file, text_line);
      hread(text_line, ram_content(i));
      i := i+1;
    end loop;

    return ram_content;
  end function;

  signal ram : ram_type := init_ram_hex;
  signal read_address :std_logic_vector(address'range):=address;
  begin
    process (clock)
    begin
    read_address <= address;  
    if rising_edge(clock) then
      if memWrite = '1' then
        ram(to_integer(unsigned(read_address and b"011111111111"))) <= datain;     
      end if;
    end if;


    if memRead = '0' and memWrite = '0' then
      read_address <= x"111";
    end if;

  end process;

  dataout <= ram(to_integer(unsigned(read_address and b"011111111111"))); 
    
end a;

