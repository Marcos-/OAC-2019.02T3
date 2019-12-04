library	ieee;
use		ieee.std_logic_1164.all;
use		ieee.numeric_std.all;

entity alu is
	generic (DATA_WIDTH	: natural := 32);
	port (
		A, B		: in	std_logic_vector(DATA_WIDTH-1 downto 0);
		opALU			: in	std_logic_vector(DATA_WIDTH-1 downto 0);
		result	: out	std_logic_vector(DATA_WIDTH-1 downto 0)
		zero	: out	std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity alu;

architecture behavioral of alu is
	signal op: std_logic_vector(3 downto 0);
begin
	op <= opALU(3 downto 0);
	zero <= result;
	op_case : process (A, B, op)
	begin
		case op is
			when "0000" => result <= std_logic_vector(signed(A) + signed(B));				-- add
			when "0001" => result <= std_logic_vector(signed(A) - signed(B));				-- sub
			when "0010" => result <= std_logic_vector(shift_left(signed(A), to_integer(unsigned(B))));	-- sll
			when "0011" =>											-- slt
				if(signed(a)<signed(b)) then
					result <= x"00000001";
				else result <= (others => '0');
				end if;
			when "0100" =>											-- sltu
				if(unsigned(a)<unsigned(b)) then
					result <= x"00000001";
				else result <= (others => '0');
				end if;
			when "0101" => result <= A xor B;								-- xor
			when "0110" => result <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));	-- srl
			when "0111" => result <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));	-- sra
			when "1000" => result <= A or B;								-- or
			when "1001" => result <= A and B;								-- and
			when "1010" =>											-- seq
				if(a=b) then
					result <= x"00000001";
				else result <= (others => '0');
				end if;
			when "1011" =>											-- sne
				if(a/=b)	then
					result <= x"00000001";
				else result <= (others => '0');
				end if;
			when "1100" =>											-- sge
				if(signed(a)>=signed(b)) then
					result <= x"00000001";
				else result <= (others => '0');
				end if;
			when "1101" =>											-- sgeu
				if(unsigned(a)>=unsigned(b)) then
					result <= x"00000001";
				else result <= (others => '0');
				end if;
			when others => result <= (others => '0');
		end case;
	end process op_case;
end architecture behavioral;