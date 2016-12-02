
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity uc is
	port(
		clk : in std_logic;
		rst : in std_logic
	);
end entity;

architecture a_uc of uc is

	signal pc_out, pc_in : unsigned(6 downto 0);
	signal wr_en_pc, jmp_en, wr_en_estado_pulo, wr_en_banco_reg17b : std_logic;
	signal instrucao : unsigned(16 downto 0);
	signal opcode : unsigned(3 downto 0);
	signal estado : unsigned(1 downto 0);			-- fetch, decode/execute, wr-b
	signal select_reg1, select_reg2 : unsigned(3 downto 0);
	signal bancoreg_datain : unsigned(16 downto 0);
	signal sel_writereg : unsigned(3 downto 0);		--Seleciona 1 dos registradores pra ser escrito
	signal bancoreg_out1, bancoreg_out2 : unsigned(16 downto 0);
	signal in2_ula : unsigned(16 downto 0);
	signal select_ula : unsigned(2 downto 0);
	signal out_ula : unsigned(16 downto 0);
	signal in_estado_pulo, out_estado_pulo : unsigned(1 downto 0);
	signal end_ram : unsigned (6 downto 0);
	signal in_ram, out_ram : unsigned (16 downto 0);
	signal wr_en_ram : std_logic;

	component pc is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			wr_en    : in std_logic;
			data_in  : in unsigned(6 downto 0);
			data_out : out unsigned(6 downto 0)
		);
	end component;

	component banco_reg17b is
				port(
				read_reg1  : in unsigned(3 downto 0);	--seleciona 1 dos registradores pra ler os dados
				read_reg2  : in unsigned(3 downto 0);	--igual ao de cima
				write_data : in unsigned(16 downto 0);	--caso seja imediato taca a data
				write_reg  : in unsigned(3 downto 0);	--Seleciona 1 dos registradores pra ser escrito
				wr_en      : in std_logic;
				clk        : in std_logic;
				rst        : in std_logic;
				--saidas de dados
				read_data1 : out unsigned(16 downto 0);
				read_data2 : out unsigned(16 downto 0)
				);
	end component;

	component rom is
		port(
			clk      : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado     : out unsigned(16 downto 0)
			);
	end component;

	component maq_estado2b is
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
			data_in  : in unsigned(1 downto 0);
			data_out : out unsigned (1 downto 0)
		);
	end component;

	component ula is
		port(
			entrada0 : in unsigned(16 downto 0);
			entrada1 : in unsigned(16 downto 0);
			selecao  : in unsigned(2 downto 0);
			saida    : out unsigned(16 downto 0);
			estado   : out unsigned(1 downto 0)
		);
	end component;

	component ram is
		port(
			clk      :	in std_logic;
			endereco :	in unsigned(6 downto 0);
			wr_en    :	in std_logic;
			dado_in  :	in unsigned(16 downto 0);
			dado_out :	out unsigned(16 downto 0)
		);
	end component;

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
	maq_estado2b0 : maq_estado2b port map (
		clk      => clk,
		rst      => rst,
		data_out => estado
		);
	banco_reg17b0 : banco_reg17b port map (
		read_reg1  => select_reg1,	--seleciona 1 dos registradores pra ler os dados
		read_reg2  => select_reg2,	--igual ao de cima
		write_data => bancoreg_datain,	--caso seja imediato taca a data
		write_reg  => sel_writereg,	--Seleciona 1 dos registradores pra ser escrito
		wr_en      => wr_en_banco_reg17b,
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

	ram0: ram port map (
		clk		=> clk,
		endereco	=> end_ram,
		wr_en		=> wr_en_ram,
		dado_in		=> in_ram,
		dado_out	=> out_ram
		);
-------------------------------
-- 00 fetch
-- 01 decode/execute
-- 10 write back
-- 11 prepare next

--lista de opcodes:
--formato 1
--0000 nop
--0001 soma entre registradores, resultado fica no primeiro
--0010 subtracao entre registradores, rersultado fica no primeiro
--0011 move de registrador para registrador    endereçamento = 00
--0100 comparacao entre registradores

--formato 2
--0101 carga de constante
--0110 soma constante ao registrador
--0111 Subtrai cosntante do registrador
--1110 Comparação com constante
--1101 LW carrega para um registrador o valor de um endereco de outro registrador
--1111 SW salva na ram a partir de um endereco de u registrador

--formato 3
--1010 Jump incondicional	--pula para endereco absoluto
--1011 Jump se menor		--pula para endereco relativo ao atual
--1100 Jump caso igual		--pula para endereco relativo ao atual

-- bit 12 do formato 3 indica se ele vai pular para um endereco com valor maior que o atual ou anterior
-- 1 soma com o pc_ou atual / 0 subtrai do pc_out atual

------------------------------------

	-- Vê o Opcode da instrução
	opcode <= instrucao(16 downto 13);

	-- Enables do JMP
	wr_en_pc <= '1' when estado = "10"
		else '0';

	jmp_en <= '1' when (opcode = "1010" or opcode = "1011" or opcode = "1100")
		else '0';


	---------------- Instruções ------------------------

	------------- Atualização do PC ou JUMP incondiconal -------------------
	pc_in <= --proxima instrução normal
		pc_out + 1 when wr_en_pc = '1' and jmp_en = '0' and estado = "10"  else
		--pulo incondicional
		instrucao(6 downto 0) when wr_en_pc = '1' and jmp_en = '1'
			and opcode = "1010" and estado = "10" else
		--pulo caso menor
		(instrucao(6 downto 0) + pc_out) when wr_en_pc = '1' and jmp_en = '1'
			and opcode = "1011" and estado = "10" and instrucao(12) = '1'
			and out_estado_pulo = "10" else
		(pc_out - instrucao(6 downto 0)) when wr_en_pc = '1' and jmp_en = '1'
			and opcode = "1011" and estado = "10" and instrucao(12) = '0'
			and out_estado_pulo = "10" else
		pc_out + 1 when wr_en_pc = '1' and jmp_en = '1'
			and opcode = "1011" and estado = "10"
			and out_estado_pulo /= "10" else
		--pulo caso igual
		(instrucao(6 downto 0) + pc_out) when wr_en_pc = '1' and jmp_en = '1'
			and opcode = "1100" and estado = "10" and instrucao(12) = '1'
			and out_estado_pulo = "00" else
		(pc_out - instrucao(6 downto 0)) when wr_en_pc = '1' and jmp_en = '1'
			and opcode = "1100" and estado = "10" and instrucao(12) = '0'
			and out_estado_pulo = "00" else
		pc_out + 1 when wr_en_pc = '1' and jmp_en = '1'
			and opcode = "1100" and estado = "10"
			and out_estado_pulo /= "00"
		else "0000000";



	--------- Fetch --///////////////////////////////////////////
	
	select_reg1 <=
		-- Soma e subtração entre registradores
		instrucao(12 downto 9) when (opcode = "0001" or opcode = "0010")
			and (estado = "00" or estado = "01") else
		--mover registradores
		instrucao(12 downto 9) when opcode = "0011"
			and (estado = "00" or estado = "01")
			else
		--Comparação de valor entre dois registradores
		instrucao(12 downto 9) when opcode = "0100"
			and (estado = "00" or estado = "01") else
		--Comparação de valor entre cosntante e registrador
		instrucao(12 downto 9) when opcode = "1110"
			and (estado = "00" or estado = "01") else
		--Carga de constante
		instrucao(12 downto 9) when opcode = "0101"
			and (estado = "00" or estado = "01") else
		-- Soma e subtração de constantes ao registrador
		instrucao(12 downto 9) when (opcode = "0110" or opcode = "0111")
			and (estado = "00" or estado = "01") else
		-- SW
		instrucao(12 downto 9) when opcode = "1111"
			and (estado = "00" or estado = "01")
		else "0000";


	select_reg2 <=
		-- Soma e subtração entre registradores
		instrucao(8 downto 5) when (opcode = "0001" or opcode = "0010")
			and (estado = "00" or estado = "01") else
		--mover registradores
		instrucao(8 downto 5) when opcode = "0011" 
			and (estado = "00" or estado = "01") else
		--Comparação de valor entre dois registradores
		instrucao(8 downto 5) when opcode = "0100"
			and (estado = "00" or estado = "01") else
		-- SW
		instrucao(8 downto 5) when opcode = "1111"
			and (estado = "00" or estado = "01") else
		-- LW
			instrucao(8 downto 5) when opcode = "1101"
			and (estado = "00" or estado = "01" or estado = "10")
		else "0000";


	--------- Decode/Execute ---///////////////////////////////
	
	in2_ula <= 
		--Soma e subtração entre registradores
		bancoreg_out2 when (opcode = "0001" or opcode = "0010")
			and estado = "01" else
		--Comparação de valor entre dois registradores
		bancoreg_out2 when opcode = "0100" and estado = "01" else
		--Comparação de valor entre cosntante e registrador
		"0000000000"&instrucao(6 downto 0) when opcode = "1110" and estado = "01"
			and instrucao(6) = '0' else
		"1111111111"&instrucao(6 downto 0) when opcode = "1110" and estado = "01"
			and instrucao(6) = '1' else
		-- Carga de constante
		"0000000000"&instrucao(6 downto 0) when opcode = "0101"
			and instrucao(6) = '0' and estado = "01" else
		"1111111111"&instrucao(6 downto 0) when opcode = "0101"
			and instrucao(6) = '1' and estado = "01" else
		-- Soma e subtração de constantes ao registrador
		"0000000000"&instrucao(6 downto 0) when (opcode = "0110" or opcode = "0111")
			and instrucao(6) = '0' and estado = "01" else
		"1111111111"&instrucao(6 downto 0) when (opcode = "0110" or opcode = "0111")
			and instrucao(6) = '1' and estado = "01" 
		else "00000000000000000";


	select_ula <=
		-- Soma entre registradores
		"000" when opcode = "0001" and estado = "01" else
		-- subtração entre registradores
		"001" when opcode = "0010" and estado = "01" else
		--Comparação de valor entre dois registradores
		"100" when opcode = "1110" and estado = "01" else
		"100" when opcode = "0100" and estado = "01" else
		-- Carga de constante
		"101" when opcode = "0101" and estado = "01" else
		-- Soma e subtração de constantes ao registrador
		"000" when opcode = "0110" and estado = "01" else
		"001" when opcode = "0111" and estado = "01" else
		-- SW
		"101" when opcode = "1111" and estado = "01"
		else "000";

	end_ram <=
		-- SW
		bancoreg_out2(6 downto 0) when opcode = "1111"
			and estado = "01" else
		-- LW
		bancoreg_out2(6 downto 0) when opcode = "1101"
			and (estado = "01" or estado = "10")
		else "0000000";

	in_ram <= 
		-- SW
		out_ula when opcode = "1111"
			and estado = "01"
			else "00000000000000000";

	wr_en_ram <=
		-- SW
		'1' when opcode = "1111"
			and estado = "01"
		else '0';


	--------- Write/Back --/////////////////////////////////////

	bancoreg_datain <=
		out_ula when (opcode = "0001" or opcode = "0010")
			and (estado = "10" or estado = "01") else
		bancoreg_out2 when opcode = "0011"
			and (estado = "10" or estado = "01") else
		-- Carga de constante
		"00000000"&instrucao(8 downto 0) when opcode = "0101"
			and (estado = "10" or estado = "01")
			and instrucao(8) = '0' else
		"11111111"&instrucao(8 downto 0) when opcode = "0101"
			and (estado = "10" or estado = "01")
			and instrucao(8) = '1' else
		-- Soma e subtração de constantes ao registrador
		out_ula when (opcode = "0110" or opcode = "0111")
			and (estado = "10" or estado = "01") else
		-- LW
		out_ram when opcode = "1101"
			and estado = "10"
		else "00000000000000000";


	sel_writereg <=
		--
		instrucao(12 downto 9) when (opcode = "0001" or opcode = "0010")
			and (estado = "10" or estado = "01") else
		instrucao(12 downto 9) when opcode = "0011"
			and (estado = "10" or estado = "01") else
		-- Carga de constante
		instrucao(12 downto 9) when opcode = "0101" 
			and (estado = "10" or estado = "01") else
		-- Soma e subtração de constantes ao registrador
		instrucao(12 downto 9) when (opcode = "0110" or opcode = "0111")
			and (estado = "10" or estado = "01") else
		-- LW
		instrucao(12 downto 9) when opcode = "1101"
			and estado = "10"
		else "0000";



	wr_en_banco_reg17b <=
		'1' when (opcode = "0001" or opcode = "0010")
			and estado = "01" else
		'1' when opcode = "0011" and estado = "01" else
		-- Carga de constante
		'1' when opcode = "0101" and estado = "01" else
		-- Soma e subtração de constantes ao registrador
		'1' when (opcode = "0110" or opcode = "0111")
			and estado = "01" else 
		-- LW
		'1' when opcode = "1101"
			and estado = "10"
		else '0';


	wr_en_estado_pulo <=
		--Comparação de valor entre dois registradores
		'1' when opcode = "0100" and estado = "01" else
		--Comparação de valor entre cosntante e registrador
		'1' when opcode = "1110" and estado = "01"
		else '0';




end architecture;













