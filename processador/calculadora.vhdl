
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- primeira unidade de controle para ser entregue dia 21/out
entity calculadora is
	port(
		clk : in std_logic;
		rst : in std_logic
		);
end entity;

architecture a_calculadora of calculadora is

	signal pc_out, pc_in : unsigned(6 downto 0);
	signal wr_en_pc, jmp_en : std_logic;
	signal instrucao : unsigned(16 downto 0);
	signal opcode : unsigned(2 downto 0);
	signal estado : unsigned(1 downto 0);

	component pc is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			wr_en    : in std_logic;
			data_in  : in unsigned(6 downto 0);
			data_out : out unsigned(6 downto 0)
		);
	end component;

	component banco_reg16b is
				port(
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
	end component;

	component rom is
		port(
			clk      : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado     : out unsigned(16 downto 0)
			);
	end component;

	component maq_estado2 is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			data_out : out unsigned(1 downto 0)
			);
	end component;

	begin		-----------------------------

	pc0 : pc port map (
			clk      => clk,
			rst      => rst,
			wr_en    => wr_en_pc,
			data_in  => pc_in,
			data_out => pc_out
			);
	rom0 : rom port map (
			clk      => clk,
			endereco => pc_out,
			dado     => instrucao
			);
	maq_estado20 : maq_estado port map (
					clk      => clk,
					rst      => rst,
					data_out => estado
					);
	banco_reg16b0 : banco_reg16b port map (
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

	pc_in <= 
		pc_out + 1 when wr_en_pc = '1' and jmp_en = '0' else
		instrucao(6 downto 0) when wr_en_pc = '1' and jmp_en = '1'
		else "0000000";

	wr_en_pc <= 
		'1' when estado = '10'
		else '0';

	--opcode 111 é jump
	--000 carrega registador com valor imediato
	-- 111 + 000 + 000 + 7 bits de endereco

	opcode <= instrucao(16 downto 14);

	jmp_en <= '1' when opcode = "111"
		else '0';

	-- soma
	


end architecture;

