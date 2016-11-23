library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 17 bits
entity rom is
	port(
		clk      : in std_logic;
		endereco : in unsigned(6 downto 0);
		dado     : out unsigned(16 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(16 downto 0);
	constant conteudo_rom : mem := (
			-- caso endereco => conteudo
			0  => "01010011000000000",	-- CAC R3,0
			1  => "01010100000000001",	-- CAC R4,0
			2  => "00010100001100000",	-- ADD R4,R3
			3  => "01100011000000001",	-- ADD R3,1
			4  => "11100011000011110",	-- CMPC R3,30
			5  => "10110000000000010",	-- JL 0000011
			6  => "00110101010000000",	-- MOV R5,R4
			7  => "00000000000000000",	-- 
			8  => "00000000000000000",
			9  => "00000000000000000",
			10 => "00000000000000000",
			11 => "00000000000000000",
			12 => "00000000000000000",
			13 => "00000000000000000",
			14 => "00000000000000000",
			15 => "00000000000000000",
			16 => "00000000000000000",
			17 => "00000000000000000",
			18 => "00000000000000000",
			19 => "00000000000000000",
			20 => "00000000000000000",
			21 => "00000000000000000",
			22 => "00000000000000000",
			23 => "00000000000000000",
			-- abaixo: casos omissos => (zero em todos os bits)
			others => (others=>'0')
			);
			
	begin
		process(clk)
			begin
				if(rising_edge(clk)) then
					dado <= conteudo_rom(to_integer(endereco));
				end if;
		end process;
		
end architecture;



