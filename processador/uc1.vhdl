library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- primeira unidade de controle para ser entregue dia 21/out
entity uc1 is
	port(
		);
end entity;

architecture a_uc1 of uc1 is

	signal pc_out, pc_in : unsigned(15 downto 0);
	signal clk, rst, wr_en_pc : std_logic;
	signal instrucao : unsigned(16 down to 0);

	component pc is
		port(
			clk      : in std_logic;
			rst      : in std_logic;
			wr_en    : in std_logic;
			data_in  : in unsigned(15 downto 0);
			data_out : out unsigned(15 downto 0)
		);
	end component;

	component rom is
		port(
			clk      : in std_logic;
			endereco : in unsigned(6 downto 0);
			dado     : out unsigned(16 downto 0)
			);
	end component;


	begin

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
					)

	pc_in <= pc_out + 1 when wr_en_pc = '1';

end architecture;

