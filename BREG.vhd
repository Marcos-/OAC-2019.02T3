library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BREG is
	port (
		endleitura1 : in std_logic_vector(31 downto 0);
		endleitura2 : in std_logic_vector(31 downto 0);
		endleitura3 : in std_logic_vector(31 downto 0);
		endescrita : in std_logic_vector(31 downto 0);
		dados : in std_logic_vector(31 downto 0);
		clock : in std_logic;
		dadosleitura1 : out std_logic_vector(31 downto 0);
		dadosleitura2 : out std_logic_vector(31 downto 0);
		dadosleitura3 : out std_logic_vector(31 downto 0)
	);
end BREG;

architecture arch_BREG of BREG is

type BREGI is array (31 downto 0) of std_logic_vector(31 downto 0); --eh criado um array de vetores, sendo cada um um registrador
signal BREG_1 : BREGI;
signal read_address_1 : std_logic_vector(31 downto 0);
signal read_address_2 : std_logic_vector(31 downto 0);
signal read_address_3 : std_logic_vector(31 downto 0);
begin
	P1: process(clock) is
	begin
		if rising_edge(clock) then
			if to_integer(unsigned(endescrita)) /= 0 then --se o registrador for diferente de 0, proximo comando eh executado
				BREG_1(to_integer(unsigned(endescrita))) <= dados; --o registrador eh sobrescrito baseado no endereco de escrita
			else
				BREG_1(0)<= "00000000000000000000000000000000"; --registrador x0 sempre eh 0
			end if;
			read_address_1 <= endleitura1;
			read_address_2 <= endleitura2;
			read_address_3 <= endleitura3;

		end if;
	end process P1;

	dadosleitura1<= BREG_1(to_integer(unsigned(read_address_1 ))); --os dados de leitura recebem o valor do registrador baseado nos enderecos de leitura 
	dadosleitura2<= BREG_1(to_integer(unsigned(read_address_2)));
	dadosleitura3<= BREG_1(to_integer(unsigned(read_address_3 )));
end architecture arch_BREG;