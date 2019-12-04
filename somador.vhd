library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity somador is
generic(
  N : integer := 32);
port (
  addA : in    std_logic_vector(N-1 downto 0);
  addB : in    std_logic_vector(N-1 downto 0);
  addResult   : out   std_logic_vector(N-1 downto 0));
end somador;
architecture somador_arch of somador is
begin
  addResult <= std_logic_vector(signed(addA) + signed(addB));
end somador_arch;
