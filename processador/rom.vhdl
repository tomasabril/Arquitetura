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
			0  => "01010001000000010",	--CAC R1 2
			1  => "01010010000000101",	--CAC R2 5
			2  => "11110010000100000",	--SW R2,R1	endereco 2 tem valor 5
			3  => "11010101000100000",	--LW R5,R1	R5 tem 5
			4  => "00000000000000000",
			5  => "00000000000000000",
			6  => "00000000000000000",
			7  => "00000000000000000",
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



