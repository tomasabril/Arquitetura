--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is 
end;

architecture a_ula_tb of ula_tb is
	component ula
		port(
			entrada0 : in unsigned(15 downto 0);
			entrada1 : in unsigned(15 downto 0);
			selecao: in unsigned(2 downto 0);
			saida : out unsigned(15 downto 0);
			maior : out std_logic;
			igual : out std_logic;
			zero : out std_logic
		);
	end component;

-- 000 soma
-- 001 subtração
-- 010 multiplicação
-- 011 divisão
-- 100 maior
-- 101 é zero
-- 110 é igual

	signal maior, igual, zero : std_logic;
	signal selecao: unsigned (2 downto 0);
	signal saida, entrada0, entrada1: unsigned(15 downto 0);

	begin 
		utt: ula port map(
							entrada0 => entrada0,
							entrada1 => entrada1,
							selecao => selecao
							saida => saida,
							maior => maior,
							igual => igual,
							zero => zero
						);

	process
		begin

			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "000";	--soma
			wait for 50 ns;
			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "001";	--subtracao 
			wait for 50 ns;
			entrada0 <= "0000000000001101";--15
			entrada1 <= "0000000001010100";--84
			selecao <= "001";	--subtracao com resultado negativo
			wait for 50 ns;
			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "010";	--multiplicacao
			wait for 50 ns;
			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "01";	--divisao
			wait for 50 ns;
			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "100";	--maior
			wait for 50 ns;
			entrada0 <= "0000000000001101";--15
			entrada1 <= "0000000001010100";--84
			selecao <= "100";	--maior
			wait for 50 ns;
			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "100";	--zero
			wait for 50 ns;
			entrada0 <= "0000000000000000";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "100";	--zero
			wait for 50 ns;
			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			selecao <= "100";	--igual
			wait for 50 ns;
			entrada0 <= "0000000000001101";--15
			entrada1 <= "0000000000001101";--15
			selecao <= "100";	--igual
			wait for 50 ns;


			entrada0 <= "0000000000000000";
			entrada1 <= "0000000000000000";
			selecao <= "000";
			wait for 200 ns;


			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0000000000000010";--2
			selecao <= "000";	--soma
			wait for 50 ns;
			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0000000000000010";--2
			selecao <= "001";	--subtracao 
			wait for 50 ns;
			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0000000000000010";--2
			selecao <= "010";	--multiplicacao
			wait for 50 ns;
			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0000000000000010";--2
			selecao <= "01";	--divisao
			wait for 50 ns;
			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0000000000000010";--2
			selecao <= "100";	--maior
			wait for 50 ns;
			entrada0 <= "0000000000000010";--2
			entrada1 <= "0111111110000101";--32645
			selecao <= "100";	--maior
			wait for 50 ns;
			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0000000000000000";--0
			selecao <= "100";	--zero
			wait for 50 ns;
			entrada0 <= "0000000000000000";--0
			entrada1 <= "0000000000000001";--1
			selecao <= "100";	--zero
			wait for 50 ns;
			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0000000000001101";--15
			selecao <= "100";	--igual
			wait for 50 ns;
			entrada0 <= "0111111110000101";--32645
			entrada1 <= "0111111110000101";--32645
			selecao <= "100";	--igual
			wait for 50 ns;


			wait;

		end process;
end architecture;
