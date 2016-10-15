--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_reg16b is
	port(		--definindo pinos externos
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
end entity;

architecture a_banco_reg16b of banco_reg16b is

	component registrador16b is		--componente que será usado
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			wr_en    : in std_logic;
			data_in  : in unsigned (15 downto 0);
			data_out : out unsigned (15 downto 0)
			);
	end component;

	--sinais internos
	signal wr_en_interno0, wr_en_interno1, wr_en_interno2, wr_en_interno3,
		wr_en_interno4, wr_en_interno5, wr_en_interno6, wr_en_interno7,
		wr_en_interno8 : std_logic;
	signal data_out0fake, data_out0, data_out1, data_out2, data_out3, data_out4,
	data_out5, data_out6, data_out7, data_out8 : unsigned (15 downto 0);


	begin
		--criando os registradores internos
		reg16b_0 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno0,
						data_in  => write_data,
						data_out => data_out0fake
						);
		reg16b_1 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno1,
						data_in  => write_data,
						data_out => data_out1
						);
		reg16b_2 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno2,
						data_in  => write_data,
						data_out => data_out2
						);
		reg16b_3 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno3,
						data_in  => write_data,
						data_out => data_out3
						);
		reg16b_4 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno4,
						data_in  => write_data,
						data_out => data_out4
						);
		reg16b_5 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno5,
						data_in  => write_data,
						data_out => data_out5
						);
		reg16b_6 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno6,
						data_in  => write_data,
						data_out => data_out6
						);
		reg16b_7 : registrador16b port map (
						clk      => clk,
						rst      => rst,
						wr_en    => wr_en_interno7,
						data_in  => write_data,
						data_out => data_out7
						);

		data_out0 <= "0000000000000000";

		--reseta tudo
		read_data1 <= "0000000000000000" when rst = '1';
		read_data2 <= "0000000000000000" when rst = '1';

		--liga o enable do registrador a ser escrito
		wr_en_interno0 <= '1' when write_reg = "000" and wr_en = '1'
		else '0';
		wr_en_interno1 <= '1' when write_reg = "001" and wr_en = '1'
		else '0';
		wr_en_interno2 <= '1' when write_reg = "010" and wr_en = '1'
		else '0';
		wr_en_interno3 <= '1' when write_reg = "011" and wr_en = '1'
		else '0';
		wr_en_interno4 <= '1' when write_reg = "100" and wr_en = '1'
		else '0';
		wr_en_interno5 <= '1' when write_reg = "101" and wr_en = '1'
		else '0';
		wr_en_interno6 <= '1' when write_reg = "110" and wr_en = '1'
		else '0';
		wr_en_interno7 <= '1' when write_reg = "111" and wr_en = '1'
		else '0';

		--coloca valor do registrador na saida 1 com base no seletor read_reg1
		read_data1 <=
					data_out0 when read_reg1 = "000" else
					data_out1 when read_reg1 = "001" else
					data_out2 when read_reg1 = "010" else
					data_out3 when read_reg1 = "011" else
					data_out4 when read_reg1 = "100" else
					data_out5 when read_reg1 = "101" else
					data_out6 when read_reg1 = "110" else
					data_out7 when read_reg1 = "111"
					else "0000000000000000";
		--coloca valor do registrador na saida 2 com base no seletor read_reg2
		read_data2 <=
					data_out0 when read_reg1 = "000" else
					data_out1 when read_reg1 = "001" else
					data_out2 when read_reg1 = "010" else
					data_out3 when read_reg1 = "011" else
					data_out4 when read_reg1 = "100" else
					data_out5 when read_reg1 = "101" else
					data_out6 when read_reg1 = "110" else
					data_out7 when read_reg1 = "111"
					else "0000000000000000";

end architecture;

