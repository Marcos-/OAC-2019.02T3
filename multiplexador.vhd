library IEEE;
use IEEE.std_logic_1164.all;
entity multiplexador is
generic(
  N : integer := 32);
port (
  muxA : in    std_logic_vector(N-1 downto 0);
  muxB : in    std_logic_vector(N-1 downto 0);
  muxC : in    std_logic_vector(N-1 downto 0);
  muxSel : in    std_logic_vector(N-1 downto 0);
  muxOut   : out   std_logic_vector(N-1 downto 0));
end multiplexador;
architecture multiplexador_arch of multiplexador is
begin
  muxOut <= muxA when (muxSel = x"00000000") else
       muxB when (muxSel = x"00000001") else
       muxC when (muxSel = x"00000002") else
       "0";
end multiplexador_arch;

