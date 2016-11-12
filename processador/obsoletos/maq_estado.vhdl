--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estado is
	port(
		clk      : in std_logic;
		rst      : in std_logic;
		--data_in  : in unsigned(15 downto 0);
		data_out : out std_logic
	);
end entity;

architecture a_maq_estado of maq_estado is
	signal estado:	std_logic;	--valor guardado pelo registrador
begin

	process(clk,rst)	-- processo comeca apenas quando um desses sinais mudar
	begin
		if rst='1' then	--ligando o reset apaga imediatamente
			estado <= '0';
		elsif rising_edge(clk) then
			estado <= not estado;
		end if;
	end process;

	data_out <= estado;		--escreve o valor guardado na saida
end architecture;

