library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture tb of tb is

		signal pc			: std_logic_vector(31 downto 0) := (others => '0');
        signal inst			: std_logic_vector(31 downto 0);
        signal inst_board	: std_logic_vector(31 downto 0);
   
begin

	UUT : entity work.imem
	port map ( 
		address		=> pc(8 downto 2),
		inst	  	=> inst,
		inst_board 	=> inst_board
	);
	
	process
		variable address : integer := 0;
    begin
    
		for i in 0 to 127 loop
			pc <= std_logic_vector(to_unsigned(address,32));
			address := address + 4;
			wait for 1 ns;
		end loop;
		
	end process;
  

end tb;
