library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is 
end;

architecture a_ula_tb of ula_tb is
	component ula
		port
		(
			entrada0 : in unsigned(15 downto 0);
			entrada1 : in unsigned(15 downto 0);
			selecao  : in unsigned(2 downto 0);
			
			saida    : out unsigned(15 downto 0);
			estado   : out unsigned(1 downto 0)
		);
	end component;
	
	signal estado   : unsigned(1 downto 0);
	signal selecao: unsigned (2 downto 0);
	signal saida, entrada0, entrada1: unsigned(15 downto 0);
	
	begin 
		utt: ula port map(
							entrada0 => entrada0,
							entrada1 => entrada1,
							selecao => selecao,
							saida => saida,
							estado => estado
						);
						
	process
		begin
			
			entrada0 <= "0000000001010100"; --84
			entrada1 <= "0000000000001101";  --15
			selecao <= "100";
			wait for 50 ns;
			entrada0 <= "0000000001010100"; --84
			entrada1 <= "0000000000001101";  --15
			selecao <= "101";
			wait for 50 ns;
			entrada0 <= "0000000001010100"; --84
			entrada1 <= "0000000000001101";  --15
			selecao <= "100";
			wait for 50 ns;
			entrada0 <= "0000000001010100"; --84
			entrada1 <= "0000000000001101";  --15
			selecao <= "110";
			wait for 50 ns;
			
			entrada0 <= "0101011111111111"; --22527
			entrada1 <= "0101011111111111"; -- 65632
			selecao <= "110";
			wait for 50 ns;
			entrada0 <= "0101011111111111"; 
			entrada1 <= "1111111101011100"; 
			selecao <= "110";
			wait for 50 ns;
			entrada0 <= "0101011111111111"; 
			entrada1 <= "1111111101011100"; 
			selecao <= "110";
			wait for 50 ns;
			entrada0 <= "0101011111111111"; 
			entrada1 <= "1111111101011100"; 
			selecao <= "110";
			wait for 50 ns;
		
			
			
			wait;
			
			
			
			
		end process;
end architecture;
			
