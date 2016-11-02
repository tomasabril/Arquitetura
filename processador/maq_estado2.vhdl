--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estado2 is
	port(
		clk      : in std_logic;
		rst      : in std_logic;
		data_out : out unsigned(1 downto 0)
	);
end entity;

architecture a_maq_estado2 of maq_estado2 is
	signal estado : unsigned(1 downto 0);	--valor guardado pelo registrador
begin

	process(clk,rst)
	begin
		if rst='1' then
			estado_s <= "00";
		elsif rising_edge(clk) then
			if estado_s="10" then -- se agora esta em 2
				estado_s <= "00"; -- o prox vai voltar ao zero
			else
				estado_s <= estado_s+1; -- senao avanca
		end if;
		end if;
	end process;

	data_out <= estado;		--escreve o valor guardado na saida
end architecture;

