
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- primeira unidade de controle para ser entregue dia 21/out
entity uc is
	port(
		clk : in std_logic;
		rst : in std_logic
		);
end entity;

architecture a_uc of uc is

	signal pc_out, pc_in : unsigned(6 downto 0);
	signal wr_en_pc, jmp_en, wr_en_estado_pulo, wr_en_banco_reg16b : std_logic;
	signal instrucao : unsigned(16 downto 0);
	signal opcode : unsigned(3 downto 0);
	signal estado : unsigned(1 downto 0);	-- fetch decode execute
	signal select_reg1, select_reg2 : unsigned(2 downto 0);
	signal bancoreg_datain : unsigned(15 downto 0);
	signal sel_writereg : unsigned(2 downto 0);	--Seleciona 1 dos registradores pra ser escrito
	signal bancoreg_out1, bancoreg_out2 : unsigned(15 downto 0);
	signal in2_ula : unsigned(15 downto 0);
	signal select_ula : unsigned(2 downto 0);
	signal out_ula : unsigned(15 downto 0);
	signal in_estado_pulo, out_estado_pulo : unsigned(2 downto 0);

	component pc is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			wr_en    : in std_logic;
			data_in  : in unsigned(6 downto 0);
			data_out : out unsigned(6 downto 0)
		);
	end component;

	component banco_reg16b is
				port(
				read_reg1  : in unsigned(2 downto 0);	--seleciona 1 dos registradores pra ler os dados
				read_reg2  : in unsigned(2 downto 0);	--igual ao de cima
				write_data : in unsigned(15 downto 0);	--caso seja imediato taca a data
				write_reg  : in unsigned(2 downto 0);	--Seleciona 1 dos registradores pra ser escrito
				wr_en      : in std_logic;
				clk        : in std_logic;
				rst        : in std_logic;
				--saidas de dados
				read_data1 : out unsigned(15 downto 0);
				read_data2 : out unsigned(15 downto 0)
				);
	end component;

	component rom is
		port(
			clk      : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado     : out unsigned(16 downto 0)
			);
	end component;

	component maq_estado2 is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			data_out : out unsigned(1 downto 0)
			);
	end component;
	
	component estado_pulo is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			wr_en    : in std_logic;
			data_in  : in unsigned(2 downto 0);
			data_out : out unsigned (2 downto 0)
		);
	end component;
	component ula is
		port(
			entrada0 : in unsigned(15 downto 0);
			entrada1 : in unsigned(15 downto 0);
			selecao  : in unsigned(2 downto 0);
			saida    : out unsigned(15 downto 0);
			estado   : out unsigned(2 downto 0)
		);

	begin------------------------------------------------

	pc0 : pc port map (
		clk      => clk,
		rst      => rst,
		wr_en    => wr_en_pc,
		data_in  => pc_in,
		data_out => pc_out
		);
	rom0 : rom port map (
		clk      => clk,
		endereco => pc_out,
		dado     => instrucao
		);
	maq_estado20 : maq_estado2 port map (
		clk      => clk,
		rst      => rst,
		data_out => estado
		);
	banco_reg16b0 : banco_reg16b port map (
		read_reg1  => select_reg1,	--seleciona 1 dos registradores pra ler os dados
		read_reg2  => select_reg2,	--igual ao de cima
		write_data => bancoreg_datain,	--caso seja imediato taca a data
		write_reg  => sel_writereg,	--Seleciona 1 dos registradores pra ser escrito
		wr_en      : wr_en_banco_reg16b,
		clk        => clk,
		rst        => rst,
		--saidas de dados
		read_data1 => bancoreg_out1,
		read_data2 => bancoreg_out2
		);
	estado_pulo0 : estado_pulo port map (
		clk      => clk,
		rst      => rst,
		wr_en    => wr_en_estado_pulo,
		data_in  => in_estado_pulo,
		data_out => out_estado_pulo
		);
	ula0 : ula port map (
		entrada0 => bancoreg_out1,
		entrada1 => in2_ula,
		selecao  => select_ula,
		saida    => out_ula,
		estado   => in_estado_pulo
		);

-------------------------------
-- 00 fetch
-- 01 decode
-- 10 execute

--lista de opcodes:
--0000 nop
--0001 soma entre registradores, resultado fica no primeiro
--0010 subtracao entre registradores, rersultado fica no primeiro
--0011 move de registrador para registrador
--0100 move constante para registrador ou ram dependendo da flag
--
--1101 jmp se a conta anterior deu negativo
--1110 jmp se a conta anterior deu zero 
--1111 jmp incondicional

------------------------------------

	opcode <= instrucao(16 downto 13) when estado = "00"
		else "0000";
	
	pc_in <= --proxima instrução normal
		pc_out + 1 when wr_en_pc = '1' and jmp_en = '0' and estado = "10" else
		--pulo incondicional
		instrucao(6 downto 0) when wr_en_pc = '1' and jmp_en = '1'
		and opcode = "1111" and estado = "10"
		
		else "0000000";

	wr_en_pc <= 
		'1' when estado = "10"
		else '0';

	jmp_en <= '1' when opcode = "1111" or opcode = "1110" or opcode = "1101"
		and estado = "01"
		else '0';

	-- 
	select_reg1 <= instrucao(12 downto 9) when opcode = "0001"
		and estado = "00"
		else "0000";
	select_reg2 <= instrucao(8 downto 5) when opcode = "0001"
		and estado = "00"
		else "0000";
	
	in2_ula <= bancoreg_out2 when opcode = "0001"
		and estado = "01"
		else "0000000000000000";
	select_ula <= "000" when opcode = "0001"
		and estado = "01"
		else "000";
	
	bancoreg_datain <= out_ula when opcode = "0001"
		and estado = "10"
		else "0000000000000000";

	sel_writereg <= instrucao(8 downto 5) when opcode = "0001"
		and estado = "10"
		else "0000000000000000";
	
	wr_en_banco_reg16b <= '1' when opcode = "0001"
		and estado = "10"
		else '0';


end architecture;





















