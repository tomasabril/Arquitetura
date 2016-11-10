--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- estado_pulo é um estado da conta anterior pra ver se vai fazer o pulo condicional
-- 000 outros casos
-- 001 a conta anterior deu zero
-- 010 a conta anterior deu positivo
-- 011 a conta anterior deu negativo
-- 


entity estado_pulo is
	port(
		clk      : in std_logic;
		rst      : in std_logic;
		wr_en    : in std_logic;
		data_in  : in unsigned(2 downto 0);
		data_out : out unsigned (2 downto 0)
	);
end entity;

architecture a_estado_pulo of estado_pulo is
	signal registro:	unsigned(3 downto 0);	--valor guardado pelo registrador
begin

	process(clk,rst,wr_en)		-- processo comeca apenas quando um desses sinais mudar
	begin
		if rst='1' then		--ligando o reset apaga imediatamente
			registro <= "000";
		elsif wr_en='1' then
			if rising_edge(clk) then
				registro <= data_in;
			end if;
		end if;
	end process;

	data_out <= registro;		--escreve o valor guardado na saida
end architecture;

