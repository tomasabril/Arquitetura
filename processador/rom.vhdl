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
			0  => "01010010001000000",	--COC R2, 2
			1  => "01010011001000000",	--COC R3, 2
			2  => "01010100000000000",	--COC R4, 0
			3  => "01010101000000000",	--COC R5, 0
			4  => "01010110000000000",	--COC R6, 0
			5  => "01010111000100000",	--COC R7, 32
			-- Loop 0:
			6  => "11110010001100000", --SW R2, @R3
			7  => "01100011000000001", --ADDC R3, 1
			8  => "01100011000000001", --ADDC R2,1
			9  => "01000011011100000", --CMP R3, R7
			10 => "10110000000000100", --JL loop 0
			11 => "01010011000100000", --COC R3,1
			-- Loop 1:
			12 => "01100011000000001", --ADDC R3, 1
			13 => "11010101001100000", --LW R5, R3
			14 => "11000000000000010", --JEQ loop 1
			15 => "00010100010100000", --ADD R4,R5 
			-- Loop 2:
			16 => "01100100000000001", -- ADD R4, 1
			17 => "00110110010000000", -- MOV R6, R4
			-- Loop 3: 
			18 => "00100100010100000", --SUB R4, R5
			19 => "01000101001000000", --CMP R5, R4
			20 => "10110000000000010", --JL loop 3
			21 => "11001000000000100", --JEQ remove
			-- End A
			22 => "01000101011100000", --CMP R5,R7
			23 => "10110000000001100", --JL loop1
			24 => "11001000000011011", --JEQ fim
			25 => "11110000011000000", --SW 0,R6
			26 => "10100000000010110", --JMP end_a
			-- FIN
			27 => "00000000000000000",
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



