--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port
		(
			entrada0 : in unsigned(15 downto 0);
			entrada1 : in unsigned(15 downto 0);
			selecao  : in unsigned(2 downto 0);
			
			saida    : out unsigned(15 downto 0);
			estado   : out unsigned(1 downto 0)
		);
end entity;
-- Estado da operação
-- 00:os dois são iguais
-- 01: maior
-- 10: menor

-- Seleçãp
-- 000 soma
-- 001 subtração
-- 010 multiplicação	!!NAO TEM
-- 011 divisão
-- 100 maior		
-- 101 é zero		
-- 110 é igual		

architecture a_ula of ula is

	signal cmp_en: std_logic; --da enable apenas se for feita uma comparação
	
	begin
		saida <=
			entrada0 + entrada1 when selecao = "000" else
			entrada0-entrada1 when selecao = "001" else
			entrada0 * entrada1 when selecao = "010" else --multiplicacao da um problemao, retorna 32 bits em vez de 16
			entrada0/entrada1 when selecao = "011"
			else "0000000000000000";
		
		-- Compara os dois registradores e guarda a resposta em resposta_p_mux
		cmp_en <=
			'1' when selecao = "100" else
			'1' when selecao = "101" else
			'1' when selecao = "110" else
			'0';
		
		-- Multiplexador para os branchs
		estado <= "00" when entrada0 = entrada1 and cmp_en = '1' else
				  "01" when entrada0 > entrada1 and cmp_en = '1' else
				  "10" when entrada0 < entrada1 and cmp_en = '1' else
				  "11";
	
end architecture;





























