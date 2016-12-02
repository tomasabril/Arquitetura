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
			0  => "01010010000000010",	--COC R2, 2
			1  => "01010011000000010",	--COC R3, 2
			2  => "01010100000000000",	--COC R4, 0
			3  => "01010101000000000",	--COC R5, 0
			4  => "01010110000000000",	--COC R6, 0
			5  => "01010111000001000",	--COC R7, 32--7
			-- Loop 0:
			6  => "11110010001100000", --SW R2, @R3
			7  => "01100011000000001", --ADDC R3, 1
			8  => "01100010000000001", --ADDC R2,1
			9  => "01000011011100000", --CMP R3, R7
			10 => "10110000000000100", --JL loop 0
			11 => "01010011000000001", --COC R3,1
			-- Loop 1:
			12 => "01100011000000001", --ADDC R3, 1
			13 => "11010101001100000", --LW R5, R3
			14 => "01000101000000000",  --CMP R5,R0
			15 => "11000000000000011", --JEQ loop 1
			16 => "00010100010100000", --ADD R4,R5 
			-- Loop 2:
			17 => "01100100000000001", -- ADDC R4, 1
			18 => "00110110010000000", -- MOV R6, R4
			-- Loop 3: 
			19 => "00100100010100000", --SUB R4, R5
			20 => "01000101010000000", --CMP R5, R4
			21 => "10110000000000010", --JL loop 3
			22 => "11001000000000100", --JEQ remove
			-- End A
			23 => "01000101011100000", --CMP R5,R7
			24 => "10110000000001100", --JL loop1
			25 => "11001000000000011", --JEQ fim
			-- REMOVE
			26 => "11110000011000000", --SW 0,R6
			27 => "10100000000010111", --JMP end_a
			-- FIN
			28 => "00000000000000000",
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



