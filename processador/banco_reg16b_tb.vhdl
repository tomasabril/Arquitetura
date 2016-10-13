--nao é o certo por enquanto

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg16bits_tb is
end entity;

architecture a_bancoreg16bits_tb of bancoreg16bits_tb is
	component bancoreg16bits is

		port(	readreg1	:	in unsigned(2 downto 0);
				readreg2	:	in unsigned(2 downto 0);
				wr_en 		:	in std_logic;
				clock		:	in std_logic;
				reset		:	in std_logic;
				wr_data		:	in unsigned(15 downto 0);
				readdata1	:	out unsigned(15 downto 0);
				readdata2	:	out unsigned(15 downto 0)

		);
	end component;

	signal clk,rst,wr_en:	std_logic;
	signal rreg1,rreg2 	:	unsigned(2 downto 0);
	signal datain,dataout: unsigned(15 downto 0);

	begin
	uut: bancoreg16bits port map(
		readreg1=>rreg1,
		readreg2=>rreg2,
		wr_data=>datain,
		readdata1=>dataout,
		readdata2=>dataout,
		clock=>clk,
		reset=>rst,
		wr_en=>wr_en
		);

	process
	begin
		clk <='0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process
	begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
	end process;

	process
	begin
		wait for 100 ns;
		wr_en <='0';
		datain <= "1111111111111111";
		wait for 100 ns;
		datain <= "1000000000000000";
	end process;

	process
	begin
	rreg1 <= "001";
			datain <= "0000000000000001";
			wait for 50 ns;			
			wait;
		end process;

	process
	begin
	rreg2 <= "001";
			datain <= "0000000000000101";
			wait for 50 ns;			
			wait;
		end process;

end architecture;



