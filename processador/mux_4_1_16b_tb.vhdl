--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4_1_16b is 
end;

architecture a_mux_4_1_16b of mux_4_1_16b is
	component mux_4_1_16b
		port(
			entrada0 : in unsigned(15 downto 0);
			entrada1 : in unsigned(15 downto 0);
			entrada2 : in unsigned(15 downto 0);
			entrada3 : in unsigned(15 downto 0);
			selecao: in unsigned(1 downto 0);
			saida : out unsigned(15 downto 0)

		);
	end component;

	signal selecao: unsigned (1 downto 0);
	signal saida, entrada0, entrada1, entrada2, entrada3 : unsigned(15 downto 0);

	begin 
		utt: ula port map(
							entrada0 => entrada0,
							entrada1 => entrada1,
							entrada2 => entrada2,
							entrada3 => entrada3,
							selecao => selecao
							saida => saida
						);

	process
		begin

			entrada0 <= "0000000001010100";--84
			entrada1 <= "0000000000001101";--15
			entrada2 <= "0111111110000101";--32645
			entrada3 <= "0000000000000010";--2

			selecao <= "00";
			wait for 50 ns;

			selecao <= "01";
			wait for 50 ns;

			selecao <= "10";
			wait for 50 ns;

			selecao <= "11";
			wait for 50 ns;

			wait;

		end process;
end architecture;
