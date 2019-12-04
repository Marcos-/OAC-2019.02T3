library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity pc is
generic(
  N : integer := 32);
port (
  pcIN : in    std_logic_vector(N-1 downto 0);
  pcOUT : out    std_logic_vector(N-1 downto 0);
end pc;
architecture pc_arch of pc is
begin
  pcOUT <= pcIN;
end pc_arch;
