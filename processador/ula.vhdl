--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port
		(
			entrada0 : in unsigned(15 downto 0);
			entrada1 : in unsigned(15 downto 0);
			selecao: in unsigned(2 downto 0);
			saida : out unsigned(15 downto 0);
			maior : out std_logic;
			igual : out std_logic;
			zero : out std_logic
		);
end entity;

-- 000 soma
-- 001 subtração
-- 010 multiplicação
-- 011 divisão
-- 100 maior
-- 101 é zero
-- 110 é igual

architecture a_ula of ula is
	begin
		saida <= entrada0 + entrada1 when selecao = "000" else
			entrada0-entrada1 when selecao = "001" else
			entrada0*entrada1 when selecao = "010" else
			entrada0/entrada1 when selecao = "011" else
			"0000000000000000";

		maior <= '1' when entrada0 > entrada1 and selecao = "100" else
			'0';

		zero <= '1' when entrada0 = 0 and selecao = "101" else
			'0';

		igual <= '1' when entrada0 = entrada1 and selecao = "110" else
			'0';

	end
architecture;

