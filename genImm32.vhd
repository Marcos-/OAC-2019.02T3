library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entidade Gerador de imediatos
entity genImm32 is
	port (
		inst : in std_logic_vector(31 downto 0);
		imm32 : out std_logic_vector(31 downto 0)
	);
end genImm32;

--Arquitetura Gerador de imediatos
architecture arch_genImm32 of genImm32 is 
	signal opcode : std_logic_vector(6 downto 0);
begin
	opcode <= inst(6 downto 0);
	--named associantion assignments:
	op_case : process(inst, opcode)
	begin
	case opcode is
		when "0110011" => -- tipo R
			imm32 <= (others => '0');
		when "0000011" | "0010011" | "1100111" => --tipo I
			imm32(11 downto 0) <= inst(31 downto 20);
			imm32(31 downto 12) <= (others => inst(31));	--extensao de sinal
		when "0100011" => --tipo S
			imm32(11 downto 5) <= inst(31 downto 25);
			imm32(4 downto 0) <= inst(11 downto 7);
			imm32(31 downto 12) <= (others => inst(31));	--extensao de sinal
		when "1100011" => --tipo B
			imm32(12) <= inst(31);
			imm32(10 downto 5) <= inst(30 downto 25);
			imm32(4 downto 1) <=	inst(11 downto 8);
			imm32(11) <= inst(7);
			imm32(0) <=	'0';	-- Multiplo de 2
			imm32(31 downto 13) <=	(others => inst(31));	--extensao de sinal
		when "0010111" | "0110111" => --tipo U
			imm32(31 downto 12) <= inst(31 downto 12);
			imm32(11 downto 0)<= (others => '0');
		when "1101111" => --tipo J
			imm32(20) <= inst(31);
			imm32(10 downto 1) <= inst(30 downto 21);
			imm32(11) <= inst(20);
			imm32(19 downto 12) <= inst(19 downto 12);
			imm32(0) <=	'0';	-- Multiplo de 2
			imm32(31 downto 21) <= (others => inst(31));	--extensao de sinal
		when others => --tipo invalido
			imm32 <= (others => '1');
	end case;
	end process op_case;
 end arch_genImm32;