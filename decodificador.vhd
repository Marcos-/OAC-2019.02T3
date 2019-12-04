library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity decodificador is
generic(
  N : integer := 32);
port (
  instDecod : in    std_logic_vector(N-1 downto 0);
  rs1Decod : out    std_logic_vector(N-1 downto 0);
  rs2Decod : out    std_logic_vector(N-1 downto 0);
  rdDecod : out    std_logic_vector(N-1 downto 0);
  opcodeDecod : out    std_logic_vector(N-1 downto 0);
  funct3Decod : out    std_logic_vector(N-1 downto 0);
  funct7Decod : out    std_logic_vector(N-1 downto 0);
  imm32Decod : out    std_logic_vector(N-1 downto 0);
end decodificador;

component genImm32 is
	port (
		inst : in std_logic_vector(31 downto 0);
		imm32 : out std_logic_vector(31 downto 0)
	);
end component;

architecture decodificador_arch of decodificador is
begin
	rs1Decod <= std_logic_vector(resize(signed(instDecod(19 downto 15)), rs1Decod'length));
	rs2Decod <= std_logic_vector(resize(signed(instDecod(24 downto 20)), rs2Decod'length));
	rdDecod <= std_logic_vector(resize(signed(instDecod(11 downto 7)), rdDecod'length));
	opcodeDecod <= std_logic_vector(resize(signed(instDecod(6 downto 0)), opcodeDecod'length));
	funct3Decod <= std_logic_vector(resize(signed(instDecod(14 downto 12)), funct3Decod'length));
	funct7Decod <= std_logic_vector(resize(signed(instDecod(31 downto 25)), funct7Decod'length));
  	G1: genImm32 port map (instDecod, imm32Decod);
end decodificador_arch;
