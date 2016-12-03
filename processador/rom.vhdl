library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Erros encontrados
--1º : tinha faltado as linhas 23 e 24 pra pegar os proximos a serem testados
--2º : O R4  não mantinha o valor pois era subtraido no teste, o mesmo valor modificado era usado pra pegar o
-- o próximo a ser textado, foi usado o R6 para testes e R4 manteve o valor, modifiuqei as instruções dependentes 
-- de R4 relaxa
--3° Linha 16, tava ADD em vez de MOV

entity rom is
	port(
		clk      : in std_logic;
		endereco : in unsigned(6 downto 0);
		dado     : out unsigned(16 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(16 downto 0);
	constant conteudo_rom : mem := (
			-- caso endereco => conteudo
			0  => "01010010000000010",	--COC R2, 2
			1  => "01010011000000010",	--COC R3, 2
			2  => "01010100000000000",	--COC R4, 0
			3  => "01010101000000000",	--COC R5, 0
			4  => "01010110000000000",	--COC R6, 0
			5  => "01010111000100001",	--COC R7, 32
			
			-- Loop 0: Coloca os numeros na memoria
			6  => "11110010001100000", --SW R2, @R3
			7  => "01100011000000001", --ADDC R3, 1
			8  => "01100010000000001", --ADDC R2,1
			9  => "01000011011100000", --CMP R3, R7
			10 => "10110000000000100", --JL loop 0
			11 => "01010011000000001", --COC R3,1		Pega primeiro primo da sequencia menos 1
			
			-- Loop 1: Pega numero da sequencia pra ver se outros são divisiveis por ele
			12 => "01100011000000001", --ADDC R3, 1	(endereço do próximo/primeiro primo da sequencia)
			13 => "11010101001100000", --LW R5, R3	 Pega valor do próximo/primeiro primo da sequencia
			14 => "01000101000000000",  --CMP R5,R0
			15 => "11000000000000011", --JEQ loop 1
			16 => "00110100010100000", --MOV R4,R5 
			
			-- Loop 2: Vai percorrendo  a sequencia comparando com o primeiro até o limite da lista
			17 => "01100100000000001", -- ADDC R4, 1	incrementa os numeros a serem testados em 1
			18 => "00110110010000000", -- MOV R6, R4 	Armazena valor pra ser testado com o primo 
			
			-- Loop 3: Remove elementos divisiveis
			19 => "00100110010100000", --SUB R6, R5
			20 => "01000101011000000", --CMP R5, R6		Compara o que é testado com o primo 
			21 => "10110000000000010", --JL loop 3
			22 => "11001000000000110", --JEQ remove
			-- Vê se chegou ao fim da sequencia
			23 => "01000100011100000", --CMP R4, R7
			24 => "10110000000000111", --JL loop 2
			
			-- Loop 4: Confere se algoritmo terminou caso contrário repete tudo para o proximo primo
			25 => "01000101011100000", --CMP R5,R7
			26 => "10110000000001110", --JL loop1 
			27 => "11001000000000011", --JEQ fim
									  
			-- REMOVE
			28 => "11110000010000000", --SW 0,R4 
			29 => "10100000000010111", --JMP Loop4
			
			-- FIN
			30 => "00000000000000000",
			-- abaixo: casos omissos => (zero em todos os bits)
			others => (others=>'0')
			);
			
	begin
		process(clk)
			begin
				if(rising_edge(clk)) then
					dado <= conteudo_rom(to_integer(endereco));
				end if;
		end process;
		
end architecture;



