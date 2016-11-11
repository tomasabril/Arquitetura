--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- estado_pulo é um estado da conta anterior pra ver se vai fazer o pulo condicional
-- Estado da operação
-- 00: os dois são iguais
-- 01: maior
-- 10: menor
-- 


entity estado_pulo is
	port(
		clk      : in std_logic;
		rst      : in std_logic;
		wr_en    : in std_logic;
		data_in  : in unsigned(1 downto 0);
		data_out : out unsigned (1 downto 0)
	);
end entity;

architecture a_estado_pulo of estado_pulo is
	signal registro:	unsigned(1 downto 0);	--valor guardado pelo registrador
begin

	process(clk,rst,wr_en)		-- processo comeca apenas quando um desses sinais mudar
	begin
		if rst='1' then		--ligando o reset apaga imediatamente
			registro <= "00";
		elsif wr_en='1' then
			if rising_edge(clk) then
				registro <= data_in;
			end if;
		end if;
	end process;

	data_out <= registro;		--escreve o valor guardado na saida
end architecture;

