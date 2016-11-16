library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_tb is
end entity;

architecture a_uc_tb of uc_tb is

	component uc is 
		port(
		clk : in std_logic;
		rst : in std_logic
		);
	end component;
	
	signal clk, rst: std_logic;


	begin
	utt: uc port map(
			clk => clk,
			rst => rst
			);

	process
	begin
		clk <= '0';		--clock em loop
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process
	begin
		rst <= '1';		--reset do inicio
		wait for 100 ns;
		rst <= '0';
		wait for 100 ns;
		wait;
	end process;
		
end architecture;


