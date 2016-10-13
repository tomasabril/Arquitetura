--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg16b_tb is
end entity;

architecture a_banco_reg16b_tb of banco_reg16b_tb is
	component banco_reg16b is
		port(
			read_reg1  : in unsigned(2 downto 0);	--seleciona 1 dos registradores pra ler os dados
			read_reg2  : in unsigned(2 downto 0);	--igual ao de cima
			write_data : in unsigned(15 downto 0);	--caso seja imediato taca a data
			write_reg  : in unsigned(2 downto 0);	--Seleciona 1 dos registradores pra ser escrito
			wr_en      : in std_logic;
			clk        : in std_logic;
			rst        : in std_logic;
			--saidas de dados
			read_data1 : out unsigned(15 downto 0);
			read_data2 : out unsigned(15 downto 0)
		);
	end component;

	signal clk, rst, wr_en : std_logic;
	signal write_reg, read_reg1, read_reg2 : unsigned(2 downto 0);
	signal write_data, read_data1, read_data2 : unsigned(15 downto 0);

	begin
		uut: banco_reg16b port map(
			read_reg1  => read_reg1,
			read_reg2  => read_reg2,
			write_data => write_data,
			write_reg  => write_reg,
			wr_en      => wr_en,
			clk        => clk,
			rst        => rst,
			read_data1 => read_data1,
			read_data2 => read_data2
			);

		process
		begin
			clk <= '0';		--clock fica em loop pra sempre
			wait for 50 ns;
			clk <= '1';
			wait for 50 ns;
		end process;

		process
		begin
			rst <= '1';		--reseta no inicio
			wait for 100 ns;
			rst <= '0';
			wait for 100 ns;
			wait;
		end process;

		process
		begin
			read_reg1 <= "001";	--le registradores, mas naoé pra ter nada por enquanto
			read_reg2 <= "010";
			wait for 100 ns;

			wr_en <= '0';		--tenta escrever mas wr_en está desablitado
			write_reg <= "001";
			write_data <= "0111111111111110";
			wait for 100 ns;
			write_reg <= "010";
			write_data <= "1000000000000000";
			wait for 100 ns;

			wr_en <= '1';		--grava coisas nos registradores
			write_reg <= "001";
			write_data <= "0111111111111110";
			wait for 100 ns;
			write_reg <= "010";
			write_data <= "1000000000000000";
			wait for 100 ns;
			write_reg <= "000";	--grava no registrador 0, etao nada acontece
			write_data <= "0000000000000010";
			wait for 100 ns;
			wr_en <= '0';

			read_reg1 <= "000";	--le s valores escritos
			wait for 100 ns;
			read_reg2 <= "000";
			wait for 100 ns;
			read_reg1 <= "001";
			wait for 100 ns;
			read_reg2 <= "010";
			wait for 100 ns;
			read_reg2 <= "011";
			wait for 100 ns;

			wr_en <= '1';		--reescreve um valor diferente
			write_reg <= "001";
			write_data <= "0000000000000110";
			wait for 100 ns;
			wr_en <= '0';
			read_reg1 <= "001";
			wait for 100 ns;

			rst <= '1';
			wait for 100 ns;
			rst <= '0';
			wait for 100 ns;
			read_reg1 <= "001";
			wait for 100 ns;

			wait;

		end process;

end architecture;



