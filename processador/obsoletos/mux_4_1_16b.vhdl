--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4_1_16b is
	port
		(
			entrada0 : in unsigned(15 downto 0);
			entrada1 : in unsigned(15 downto 0);
			entrada2 : in unsigned(15 downto 0);
			entrada3 : in unsigned(15 downto 0);
			selecao: in unsigned(1 downto 0);
			saida : out unsigned(15 downto 0);
		);
end entity;

-- 00
-- 01
-- 10
-- 11

architecture a_mux_4_1_16b of mux_4_1_16b is
	begin
		saida <=
			entrada0 when selecao = "00" else
			entrada1 when selecao = "01" else
			entrada2 when selecao = "10" else
			entrada3 when selecao = "11" else
			"0000000000000000";

	end
architecture;

