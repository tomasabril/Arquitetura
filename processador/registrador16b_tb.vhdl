-- -- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrador16b_tb is
end;

architecture a_registrador16b_tb of registrador16b_tb is 

	component registrador16b is
	port(
		clk      : in std_logic;
		rst      : in std_logic;
		wr_en    : in std_logic;
		data_in  : in unsigned (15 downto 0);
		data_out : out unsigned (15 downto 0)
	);
	end component;

	signal data_in, data_out : unsigned(15 downto 0);
	signal wr_en, clk, rst : std_logic;

	begin
		utt : registrador16b port map(
					clk => clk,
					rst => rst,
					wr_en => wr_en,
					data_in => data_in,
					data_out => data_out
					);

	process
		begin
			clk <= '0';
			wait for 50 ns;
			clk <= '1';
			wait for 50 ns;		--como não tem o wait final fica em loop
	end process;

	process
		begin
			rst <= '1';
			wait for 100 ns;
			rst <= '0';
			wait;
	end process;

	process
		begin
			wait for 100 ns;
			wr_en <= '0';
			data_in <= "1111111111111111";
			wait for 100 ns;
			wr_en <= '0';
			data_in <= "1010101010010111";
			wait for 100 ns;
			wr_en <= '1';
			data_in <= "1010101000010111";
			wait for 100 ns;
			wr_en <= '0';
			data_in <= "1010111010010111";
			wait for 100 ns;
			wr_en <= '1';
			data_in <= "1010111010010111";
			wait for 100 ns;
			wr_en <= '1';
			data_in <= "1010111010111111";
			wait;
	end process;

end architecture;

