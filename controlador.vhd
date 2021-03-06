library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity controlador is
    generic (WSIZE : natural := 32);
    port(opcode: in std_logic_vector(6 downto 0);
		 branch, 
     memRead, 
     memWrite, 
     memToReg,
     regWrite,
     ALUsrc,
     jalr_jal_ctrl,
     auipc_jal_ctrl: out std_logic:='0'; 
		 ALUop : out std_logic_vector (2 downto 0)
          );
end controlador;

architecture a of controlador is
begin
  process_control: process(opcode) begin
    case unsigned(opcode) is
    
   
-- Branch
        when "1100011" =>
                  ALUsrc <= '0';
                  memToReg <= '0';
                  regWrite <= '0';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '1';
                  ALUop <= "001";
		  jalr_jal_ctrl <= '0';
 		  auipc_jal_ctrl <= '0';

--R 
	when "0110011" =>
                  ALUsrc <= '0';
                  memToReg <= '0';
                  regWrite <= '1';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '0';
                  ALUop <= "010";
		  jalr_jal_ctrl <= '0';
 		  auipc_jal_ctrl <= '0';

--Jal 
	when "1101111" =>
                  ALUsrc <= '1';
                  memToReg <= '0';
                  regWrite <= '1';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '1';
                  ALUop <= "000";
		  jalr_jal_ctrl <= '1';
 		  auipc_jal_ctrl <= '1';

--Jalr 
	when "1100111" =>
                  ALUsrc <= '1';
                  memToReg <= '0';
                  regWrite <= '1';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '1';
                  ALUop <= "000";
		  jalr_jal_ctrl <= '1';
 		  auipc_jal_ctrl <= '0';

--Auipc 
	when "0010111" =>
                  ALUsrc <= '1';
                  memToReg <= '0';
                  regWrite <= '1';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '0';
                  ALUop <= "000";
		  jalr_jal_ctrl <= '0';
 		  auipc_jal_ctrl <= '1';

--Lui 
	when "0110111" =>
                  ALUsrc <= '1';
                  memToReg <= '0';
                  regWrite <= '1';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '0';
                  ALUop <= "011";
		  jalr_jal_ctrl <= '0';
 		  auipc_jal_ctrl <= '0';

--I Opera????es aritm??ticas com imediato
	when "0010011" =>
                  ALUsrc <= '1';
                  memToReg <= '0';
                  regWrite <= '1';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '0';
                  ALUop <= "111";
		  jalr_jal_ctrl <= '0';
 		  auipc_jal_ctrl <= '0';

--LW 
	when "0000011" =>
                  ALUsrc <= '1';
                  memToReg <= '1';
                  regWrite <= '1';
                  memWrite <= '0';
                  memRead <= '1';
                  branch <= '0';
                  ALUop <= "000";
		  jalr_jal_ctrl <= '0';
 		  auipc_jal_ctrl <= '0';

--SW 
	when "0100011" =>
                  ALUsrc <= '1';
                  memToReg <= '0';
                  regWrite <= '0';
                  memWrite <= '1';
                  memRead <= '0';
                  branch <= '0';
                  ALUop <= "000";
		  jalr_jal_ctrl <= '0';
 		  auipc_jal_ctrl <= '0';


            
         when others => 
		 ALUsrc <= '0';
                  memToReg <= '0';
                  regWrite <= '0';
                  memWrite <= '0';
                  memRead <= '0';
                  branch <= '0';
                  ALUop <= "100";
      end case;   
  end process;
end a;
