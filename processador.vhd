library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity processador is 
	
	port(
		clock_geral	: in std_logic
	);
	
end processador;

architecture rtl of processador is
	
	--Signals
	
	--ROM
	signal instruction              : std_logic_vector(31 downto 0) := X"00000000";

	-- PC
	signal pc_in					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_out					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_4					    : std_logic_vector(31 downto 0) := X"00000000";
	signal pc_branch			    : std_logic_vector(31 downto 0) := X"00000000";
    signal pc_definitivo			: std_logic_vector(31 downto 0) := X"00000000";

	-- BREG
	alias rd                        : std_logic_vector (4 downto 0) is instruction (11 downto 7);
    alias rs1                       : std_logic_vector (4 downto 0) is instruction (19 downto 15);
	alias rs2                       : std_logic_vector (4 downto 0) is instruction (24 downto 20);
	signal ro1					    : std_logic_vector(31 downto 0) := X"00000000";
	signal ro2				        : std_logic_vector(31 downto 0) := X"00000000";
	signal data_rd				    : std_logic_vector(31 downto 0) := X"00000000";
	
	-- Controle
	alias opcode                   : std_logic_vector (6 downto 0) is instruction (6 downto 0);
	signal branch		           : std_logic := '0';
	signal memRead	               : std_logic := '0';
	signal memWrite	               : std_logic := '0';
	signal memToReg	               : std_logic := '0';
	signal regWrite	               : std_logic := '0';
	signal ALUsrc		           : std_logic := '0';
	signal ALUop		           : std_logic_vector(2 downto 0) := "000";
   	signal jalr_jal_ctrl           : std_logic := '0';
    signal auipc_jal_ctrl          : std_logic := '0';
	signal ANDResult	           : std_logic := '0';

	--imm_shift_1
	signal result_shift              : std_logic_vector(31 downto 0) := X"00000000";
    
	-- RAM
	signal read_data				: std_logic_vector(31 downto 0) := X"00000000";
	signal saida_mux_ram            : std_logic_vector(31 downto 0) := X"00000000";

	-- ULA
    signal ent_ula1                 : std_logic_vector(31 downto 0) := X"00000000";
    signal ent_ula2                 : std_logic_vector(31 downto 0) := X"00000000";
    signal zero                     : std_logic := '0';
	signal ula_result				: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Gerador_imediato
	signal imm_result				: std_logic_vector(31 downto 0) := X"00000000";

	
    --Controle ULA
    alias funct3: std_logic_vector (2 downto 0) is instruction (14 downto 12);   
    alias funct7: std_logic_vector (6 downto 0) is instruction (31 downto 25);
    signal controlULA_result                : std_logic_vector(3 downto 0) := X"0";



begin

process(clock_geral)
begin
end process;



controlador: entity work.controlador port map(
	
	opcode => opcode,
	branch => branch,
	memRead => memRead,
	memWrite => memWrite, 
	memToReg=> memToReg, 
	regWrite=> regWrite, 
	ALUsrc=> ALUsrc, 
	jalr_jal_ctrl=> jalr_jal_ctrl  , 
	auipc_jal_ctrl => auipc_jal_ctrl, 
	ALUop => ALUop 
);






xreg: entity work.xreg port map(
		
	clk 		=> clock_geral,
	wren 		=> regWrite,
	rst 		=> '0',
	rs1 		=> rs1,
	rs2 		=> rs2,
	rd 		    => rd,
	data 		=> data_rd,
	ro1 		=> ro1,
	ro2 		=> ro2
);
	

ULA: entity work.ULA port map(
		
	opcode 		=> controlULA_result,
	A 		    => ent_ula1,
	B 		    => ent_ula2,
	Z 		    => ula_result,
	zero 		=> zero
	
);

controlULA: entity work.controlULA port map(
	funct7	   => funct7,
	funct3 	   => funct3,
	aluop	   => ALUop,
	aluctr     => controlULA_result
);


imm_shift_1: entity work.imm_shift_1 port map(
	entrada => imm_result,
	saida => result_shift
);
	

pc: entity work.pc port map(	
    -- sinais do pc => sinais do processador 
    pc_in	=> pc_in,
    pc_new  => pc_out,
    clock 	=> clock_geral    
);

rom: entity work.rom port map(	
    -- sinais do pc => sinais do processador 
    address	=> pc_out(11 downto 0),  -- Conecta apenas os 12 bits menos significativos de pc_out
    dataout => instruction 
);

ram: entity work.ram port map(	
	clock => clock_geral,
    memWrite => memWrite,
	memRead => memRead,
    address => ula_result(13 downto 2), 
    datain => ro2,
    dataout => read_data
);
	
somador1: entity work.somador port map(
	entrada_A => pc_out,
	entrada_B => x"00000004",
	saida => pc_4
	
);

somador2: entity work.somador port map(
	
	entrada_A => pc_out,
	entrada_B => result_shift, 
	saida => pc_branch
	
);
	
mux1: entity work.mux port map(
	
	s => ANDResult,
	entrada_A => pc_4,
	entrada_B => pc_branch,
	saida => pc_definitivo
);
	
mux2: entity work.mux port map(
	
	s => jalr_jal_ctrl,
	entrada_A => pc_definitivo,
	entrada_B => ula_result,
	saida => pc_in
);
	
mux3: entity work.mux port map(
	
	s => memToReg,
	entrada_A => ula_result,
	entrada_B => read_data,
	saida => saida_mux_ram
);
	
mux4: entity work.mux port map(
	
	s => ALUsrc,
	entrada_A => ro2,
	entrada_B => imm_result,
	saida => ent_ula2
);

mux5: entity work.mux port map(
	
	s => auipc_jal_ctrl,
	entrada_A => ro1,
	entrada_B => pc_out,
	saida => ent_ula1
);

	
mux6: entity work.mux port map(
	
	s => jalr_jal_ctrl,
	entrada_A => saida_mux_ram,
	entrada_B => pc_4,
	saida => data_rd
);

genImm32: entity work.genImm32 port map(
	
	instr => instruction,
	imm32 => imm_result	
);

	
end;    
