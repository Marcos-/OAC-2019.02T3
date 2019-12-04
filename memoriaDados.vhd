--Este módulo armazena dados para leitura e escrita na memória.
--Ele possui endereços de 7 bits e dados de 32 bits e, assim como a MI, foi endereçada a word,
--desta forma cada endereço armazena um dado de tamanho 32 bits. A MD é escrita na borda de
--subida de clock, e como não há sinal LeMem, fornece-se o endereço que o dado é lido,
--de forma similar a uma ROM. Além disso, ela possui duas entradas de endereço de leitura:
--uma para a obtenção do dado a ser lido e utilizado na implementação do processador e outra
--para mostrar o dado de uma determinada posição de memória nos displays de 7 segmentos da placa.

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY memoriaDados IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock			: IN STD_LOGIC  := '1';
		data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren			: IN STD_LOGIC ;
		q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END memoriaDados;


ARCHITECTURE SYN OF memoriadados IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (31 DOWNTO 0);



	COMPONENT altsyncram
	GENERIC (
		clock_enable_input_a			: STRING;
		clock_enable_output_a		: STRING;
		init_file						: STRING;
		intended_device_family		: STRING;
		lpm_hint							: STRING;
		lpm_type							: STRING;
		numwords_a						: NATURAL;
		operation_mode					: STRING;
		outdata_aclr_a					: STRING;
		outdata_reg_a					: STRING;
		power_up_uninitialized		: STRING;
		widthad_a						: NATURAL;
		width_a							: NATURAL;
		width_byteena_a				: NATURAL
	);
	PORT (
			address_a	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock0		: IN STD_LOGIC ;
			data_a		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren_a		: IN STD_LOGIC ;
			q_a			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	q    <= sub_wire0(31 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => "dados.mif",
		intended_device_family => "Cyclone II",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		lpm_type => "altsyncram",
		numwords_a => 256,
		operation_mode => "SINGLE_PORT",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "FALSE",
		widthad_a => 8,
		width_a => 32,
		width_byteena_a => 1
	)
	PORT MAP (
		address_a => address,
		clock0 => clock,
		data_a => data,
		wren_a => wren,
		q_a => sub_wire0
	);



END SYN;