library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package riscv_pkg is	
	constant WORD_SIZE 	: natural := 32;

	component ULA is
		port (
			opcode: 	in  std_logic_vector(3 downto 0);
			A, B:		in  std_logic_vector(WORD_SIZE-1 downto 0);
			Z:	out std_logic_vector(WORD_SIZE-1 downto 0);
			zero:		out std_logic
			);
		end component;

	component controlULA is
		port (
			aluop		: in std_logic_vector(1 downto 0);
			funct3		: in std_logic_vector(2 downto 0);
			funct7		: in std_logic;
			aluctr	   : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component controlador is
		port (
			opcode : in std_logic_vector(6 downto 0);
			ALUop :	out std_logic_vector(1 downto 0);
			memRead,
			regWrite,
			branch,
			memToReg,
			memWrite,
			ALUsrc,
			jalr_jal_ctrl, 
			auipc_jal_ctrl:	out std_logic
			);
	end component;	
	
	component genImm32 is
		port (
			instr	: in std_logic_vector(WORD_SIZE - 1 downto 0);
			imm32 : out std_logic_vector(WORD_SIZE-1 downto 0)
			);
	end component;

	component MUX is
		port (	
			entrada_A, entrada_B	: in std_logic_vector(WORD_SIZE-1 downto 0);
			s		    			: in std_logic;
		saida					: out std_logic_vector(WORD_SIZE-1 downto 0)
	);
	end component;
	
	component PC is
		port
		(
			pc_in	 :in std_logic_vector(31 downto 0)  := x"00000000";
			clock    :out std_logic;
			pc_new   :out std_logic_vector(31 downto 0) := X"00000000"
			);
			
		end component;

	component ram_rv is
		port
		(
			address	    : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			clock		: IN STD_LOGIC;
			datain		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			we		    : IN STD_LOGIC ;
			dataout	    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
			);
		end component;
		
	component rom_rv is
	port (
		adress  : in STD_LOGIC_VECTOR (11 downto 0);
		dataout : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

		component somador is
	port (
		entrada_A, entrada_B	: in std_logic_vector(31 downto 0);
		saida                   : out std_logic_vector (31 downto 0)
	);
	end component;
	
	component xreg is
	port 
	(
		clk, wren, rst		: in  std_logic;
		rs1, rs2, rd		: in  std_logic_vector(4 downto 0);
		data                : in std_logic_vector(31 downto 0);
		ro1, ro2            : out std_logic_vector(31 downto 0)
	);

	end component;
	
	
	
	
	



	
--	procedure mux2x1 (signal x0, x1	: in std_logic_vector(WORD_SIZE-1 downto 0); 
--							signal sel	: in std_logic;
--							signal z 	: out std_logic_vector(WORD_SIZE-1 downto 0) );
	
	
end riscv_pkg;

