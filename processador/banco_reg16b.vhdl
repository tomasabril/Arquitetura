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

	process(rst)	--reseta tudo
	begin
		if(rst = '1') then
			read_data1 <= "0000000000000000";
			read_data2 <= "0000000000000000";
		end if;
	end process;

	process(clk, wr_en)	-- acionado se houver mudança
	begin
		-- Seleção de qual registrador escrever
		if (wr_en = '1') then
			if rising_edge(clk) then
				case write_reg is
					when "000" => 	wr_en_interno0 <= '1';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '0';
					when "001" => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '1';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '0';
					when "010" => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '1';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '0';
					when "011" => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '1';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '0';
					when "100" => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '1';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '0';
					when "101" => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '1';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '0';
					when "110" => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '1';
							wr_en_interno7 <= '0';
					when "111" => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '1';
					when others => 	wr_en_interno0 <= '0';
							wr_en_interno1 <= '0';
							wr_en_interno2 <= '0';
							wr_en_interno3 <= '0';
							wr_en_interno4 <= '0';
							wr_en_interno5 <= '0';
							wr_en_interno6 <= '0';
							wr_en_interno7 <= '0';
				end case;
			end if;
		else (wr_en = '0') then
			wr_en_interno0 <= '0';
			wr_en_interno1 <= '0';
			wr_en_interno2 <= '0';
			wr_en_interno3 <= '0';
			wr_en_interno4 <= '0';
			wr_en_interno5 <= '0';
			wr_en_interno6 <= '0';
			wr_en_interno7 <= '0';
		end if;
	end process;

	process(clk) -- acionado se houver mudança
	begin
	--selecao de quais registradores vao pra saida do banco
		if rising_edge(clk) then
			case read_reg1 is
				when "000" => read_data1 <= data_out0;
				when "001" => read_data1 <= data_out1;
				when "010" => read_data1 <= data_out2;
				when "011" => read_data1 <= data_out3;
				when "100" => read_data1 <= data_out4;
				when "101" => read_data1 <= data_out5;
				when "110" => read_data1 <= data_out6;
				when "111" => read_data1 <= data_out7;
				when others => read_data1 <= "0000000000000000";
			end case;
			case read_reg2 is
				when "000" => read_data2 <= data_out0;
				when "001" => read_data2 <= data_out1;
				when "010" => read_data2 <= data_out2;
				when "011" => read_data2 <= data_out3;
				when "100" => read_data2 <= data_out4;
				when "101" => read_data2 <= data_out5;
				when "110" => read_data2 <= data_out6;
				when "111" => read_data2 <= data_out7;
				when others => read_data2 <= "0000000000000000";
			end case;

		--------------
--			read_data1 <=	data_out0 when read_reg_1 = "000" else
--					data_out1 when read_reg_1 = "001" else
--					data_out2 when read_reg_1 = "010" else
--					data_out3 when read_reg_1 = "011" else
--					data_out4 when read_reg_1 = "100" else
--					data_out5 when read_reg_1 = "101" else
--					data_out6 when read_reg_1 = "110" else
--					data_out7 when read_reg_1 = "111"
--					else "0000000000000000";
--			read_data2 <=	data_out0 when read_reg_2 = "000" else
--					data_out1 when read_reg_2 = "001" else
--					data_out2 when read_reg_2 = "010" else
--					data_out3 when read_reg_2 = "011" else
--					data_out4 when read_reg_2 = "100" else
--					data_out5 when read_reg_2 = "101" else
--					data_out6 when read_reg_2 = "110" else
--					data_out7 when read_reg_2 = "111"
--					else "0000000000000000";
		--------------

		end if;
	end process;

end architecture;










