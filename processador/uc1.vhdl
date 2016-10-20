library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- primeira unidade de controle para ser entregue dia 21/out
entity uc1 is
	port(
		clk : in std_logic;
		rst : in std_logic
		);
end entity;

architecture a_uc1 of uc1 is

	signal pc_out, pc_in : unsigned(6 downto 0);
	signal wr_en_pc, jmp_en : std_logic;
	signal instrucao : unsigned(16 downto 0);
	signal opcode : unsigned(2 downto 0);
	signal estado : std_logic;

	component pc is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			wr_en    : in std_logic;
			data_in  : in unsigned(6 downto 0);
			data_out : out unsigned(6 downto 0)
		);
	end component;

	component rom is
		port(
			clk      : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado     : out unsigned(16 downto 0)
			);
	end component;

	component maq_estado is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			data_out : out std_logic
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
					endereco => pc_out, -- Os tamanhos são diferentes, ajuestei pc_out pro mesmo tamanaho do numero de enreços da rom
					dado     => instrucao
					);
	maq_estado0 : maq_estado port map (
										clk      => clk,
										rst      => rst, -- não havia no declarado para esse sinal
										data_out => estado
										);

	pc_in <= pc_out + 1 when wr_en_pc = '1' and jmp_en = '0';
	pc_in <= instrucao(6 downto 0) when wr_en_pc = '1' and jmp_en = '1'; -- Mudei pra pegar os 7 primeiros bits em vez dos 8 primeiros

	wr_en_pc <= '1' when estado = '1';
	wr_en_pc <= '0' when estado = '0';

	--opcode 111 é jump
	-- 111 + 000 + 000 + 7 bits de endereco

	opcode <= instrucao(16 downto 14);

	jmp_en <= '1' when opcode = "111"
		else '0';


end architecture;

