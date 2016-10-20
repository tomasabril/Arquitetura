--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity uc1_tb is
end entity;

architecture a_uc1_tb of uc1_tb is
	component uc1 is
		port(
			clk : in std_logic;
			rst : in std_logic
			);
	end component;

	signal clk, rst : std_logic;

	begin
		uut: uc1 port map(
						clk => clk,
						rst => rst
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
			
			wait for 1000 ns;

			wait for 100 ns;

			wait;

		end process;

end architecture;

