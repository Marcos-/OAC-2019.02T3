library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity somador is
generic(
  N : integer := 32);
port (
  opcode : in    std_logic_vector(N-1 downto 0);
  EscreveReg : out    std_logic_vector(N-1 downto 0);
  OrigULA : out    std_logic_vector(N-1 downto 0);
  JAL : out    std_logic_vector(N-1 downto 0);
  ULAop : out    std_logic_vector(N-1 downto 0);
  LeMem : out    std_logic_vector(N-1 downto 0);
  EscreveMem : out    std_logic_vector(N-1 downto 0);
  Mem2Reg : out    std_logic_vector(N-1 downto 0);
  Branch   : out   std_logic_vector(N-1 downto 0));
end somador;
architecture somador_arch of somador is
begin
    process(opcode)
    begin
        case opcode is
            --tipo-r ou tipo-r com imediato
            when x"00000033" =>
                EscreveReg <= x"00000001";
                OrigULA <= x"00000000";
                JAL <= x"00000000";
                ULAop <= x"00000002";
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000000";
                Branch <= x"00000000";
                JALR <= x"00000000";
            --lw
            when x"00000003" =>
                EscreveReg <= x"00000001";
                OrigULA <= x"00000001";
                JAL <= x"00000000";
                ULAop <= x"00000000";
                LeMem <= x"00000001";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000001";
                Branch <= x"00000000";
                JALR <= x"00000000";
            -- imediato
            when x"00000013" =>
                EscreveReg <= x"00000001";
                OrigULA <= x"00000001";
                JAL <= x"00000000";
                ULAop <= x"00000002";
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000000";
                Branch <= x"00000000";
                JALR <= x"00000000";

            --jump n link register
            when x"00000067" =>
                EscreveReg <= x"00000001";
                OrigULA <= x"00000001";
                JAL <= x"00000000";
                ULAop <= x"00000000"; -- pc=(x[rs1]+sext(offset))&∼1
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000002"; -- R[rd] = pc + 4
                Branch <= x"00000001";
                JALR <= x"00000001";

            --sw
            when x"00000023" =>
                EscreveReg <= x"00000000";
                OrigULA <= x"00000001";
                JAL <= x"00000000";
                ULAop <= x"00000000";
                LeMem <= x"00000000";
                EscreveMem <= x"00000001";
                Mem2Reg <= x"00000000";
                Branch <= x"00000000";
                JALR <= x"00000000";

            --branch
            when x"00000063" =>
                EscreveReg <= x"00000000";
                OrigULA <= x"00000000";
                JAL <= x"00000000";
                ULAop <= x"00000001";
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000000";
                Branch <= x"00000001";
                JALR <= x"00000000";

            --AUIPC
            when x"00000017" =>
                EscreveReg <= x"00000001";
                OrigULA <= x"00000000";
                JAL <= x"00000000";
                ULAop <= x"00000000";
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000002";
                Branch <= x"00000000";
                JALR <= x"00000000";

            --LUI
            when x"00000037" =>
                EscreveReg <= x"00000001";
                OrigULA <= x"00000000";
                JAL <= x"00000000";
                ULAop <= x"00000000";
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000002";
                Branch <= x"00000000";
                JALR <= x"00000000";

            --JAL
            when x"0000006F" =>
                EscreveReg <= x"00000001";
                OrigULA <= x"00000000";
                JAL <= x"00000001";
                ULAop <= x"00000000";
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000002";
                Branch <= x"00000000";
                JALR <= x"00000000";
            when others =>
                EscreveReg <= x"00000000";
                OrigULA <= x"00000000";
                JAL <= x"00000000";
                ULAop <= x"00000000";
                LeMem <= x"00000000";
                EscreveMem <= x"00000000";
                Mem2Reg <= x"00000000";
                Branch <= x"00000000";
                JALR <= x"00000000";
        end case;
    end process;
end somador_arch;

