library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is 
	
	port(
		clock_geral	: in std_logic
	);
	
end processador;

architecture rtl of processador is
	
	--Signals
	
	-- PC
	signal pc_in					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_out					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_4					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_branch					: std_logic_vector(31 downto 0) := X"00000000";
    signal pc_definitivo			: std_logic_vector(31 downto 0) := X"00000000";

	
	-- BREG
	alias rd: std_logic_vector (4 downto 0) is instruction (11 downto 7);
    alias rs1: std_logic_vector (4 downto 0) is instruction (19 downto 15);
	alias rs2: std_logic_vector (4 downto 0) is instruction (24 downto 20);
	signal ro1					: std_logic_vector(31 downto 0) := X"00000000";
	signal ro2				: std_logic_vector(31 downto 0) := X"00000000";
	signal data_rd				: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Controle
	alias opcode: std_logic_vector (6 downto 0) is instruction (6 downto 0);
	signal branch		: std_logic := '0';
	signal memRead	    : std_logic := '0';
	signal memWrite	: std_logic := '0';
	signal memToReg	: std_logic := '0';
	signal regWrite	: std_logic := '0';
	signal ALUsrc		: std_logic := '0';
	signal ALUop		: std_logic_vector(1 downto 0) := "00";
    signal jalr_jal_ctrl : std_logic := '0';
    signal auipc_jal_ctrl : std_logic := '0';

    --ROM

    signal instruction  : std_logic_vector(31 downto 0) := X"00000000";
    
    

	-- RAM
	signal read_data				: std_logic_vector(31 downto 0) := X"00000000";
	signal saida_mux_ram            : std_logic_vector(31 downto 0) := X"00000000";
	-- ULA

    signal ent_ula1                 : std_logic_vector(31 downto 0) := X"00000000";
    signal ent_ula2                 : std_logic_vector(31 downto 0) := X"00000000";
    signal zero                     : std_logic := '0';
	signal ula_result				: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Gerador_imediato
	signal imm_result				: signed(31 downto 0) := X"00000000";
	
    --Controle ULA
    alias funct3: std_logic_vector (3 downto 0) is instruction (14 downto 12);   
    alias funct7: std_logic_vector (6 downto 0) is instruction (31 downto 25);
    signal controlULA_result                : std_logic_vector(31 downto 0) := X"00000000";



begin

xreg: entity work.xreg port map(
		
	clk 		=> clock_geral,
	wren 		=> regWrite,
	rst 		=> '0',
	rs1 		=> rs1,
	rs2 		=> rs2,
	rd 		=> rd,
	data 		=> data_rd,
	ro1 		=> ro1,
	ro2 		=> ro2
	
);
	

ULA: entity work.ULA port map(
		
	opcode 		=> opcode,
	A 		=> ent_ula1,
	B 		=> ent_ula2,
	Z 		=> ula_result,
	zero 		=> zero
	
);

pc: entity work.pc port map(	
    -- sinais do pc => sinais do processador 
    pc_in	=> pc_in,
    pc_out => pc_out,
    clock 		=> clockgeral    
);

rom: entity work.rom port map(	
    -- sinais do pc => sinais do processador 
    adress	=> resize(signed(pc_out),12),
    dataout => instruction 
);



end    
