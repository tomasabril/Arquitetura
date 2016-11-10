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
			estado   : out unsigned(2 downto 0)
		);
end entity;
--estado da operação
-- 000 outros casos
-- 001 a conta deu zero
-- 010 a conta deu positivo
-- 011 a conta deu negativo

-- 000 soma
-- 001 subtração
-- 010 multiplicação	!!NAO TEM
-- 011 divisão
-- 100 maior		!!NAO TEM
-- 101 é zero		!!NAO TEM
-- 110 é igual		!!NAO TEM

architecture a_ula of ula is
	begin
		saida <=
			entrada0 + entrada1 when selecao = "000" else
			entrada0-entrada1 when selecao = "001" else
			--(entrada0 * entrada1) when selecao = "010" else
			--multiplicacao da um problemao, retorna 32 bits em vez de 16
			entrada0/entrada1 when selecao = "011"
			else "0000000000000000";

		estado <=
			"001" when saida = "0000000000000000" else
			"010" when saida(15 downto 14) = '0' else
			"011" when saida(15 downto 14) = '1'
			else "000";

end architecture;





























