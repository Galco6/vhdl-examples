----------------------------------------------------------------------------------------------
--  PROBLEMA 6
--
-- Obtén una descripción VHDL sintetizable para un contador bidireccional de 16 bits. La
-- descripción debe incluir una entrada de sincronización por flanco de subida denominada
-- CLK y un reset asíncrono activado cuando la señal RESET = 1; otra entrada denominada
-- CE que habilite o deshabilite la cuenta (CE=1 cuenta habilitada); y una entrada más de-
-- nominada UP que indique el sentido de la cuenta (UP=1 cuenta ascendente). Como salidas
-- debe tener las que indican el valor de la cuenta COUNT (16 bits); una salida, TC, que in-
-- dique con un nivel alto el fin de cuenta considerando el sentido de la misma; y otra salida,
-- CEO, que sirva para encadenar dos contadores, que tomará el valor alto cuando la cuenta
-- haya llegado al final y esté habilitada.
--
------------------------------------------------------------------------------------------------

library IEEE;
use IEEE_STD_LOGIC_1163

entity 16b_counter is 
    PORT (CLK_I in STD_LOGIC;
          RESET_I in STD_LOGIC;
          CE in STD_LOGIC;
          UP in STD_LOGIC;
          COUNT out STD_LOGIC_VECTOR (15 downto 0);
          TC out STD_LOGIC;
          CEO out STD_LOGIC
         );
end 16b_counter;

architecture Behavioral of 16b_counter is

signal COUNT_TMP:UNSIGNED (15 downto 0);
signal NEXT_COUNT_TMP:UNSIGNED (15 downto 0);

begin

    process (REST_I, CLK_I)
    begin
    
        if RESET = '1' the 
            COUNT_TMP = (others=> '0');
            COUNT = '0';
            TC = '0';
            CEO = '0';
        elsif rising_edge(CLK_I) then
        COUNT_TMP <= NEXT_COUNT_TMP;
        end if;
    end process;

    NEXT_COUNT_TEMP <= COUNT_TMP + 1 when CE = '1' and UP = '1' else
                       COUNT_TMP - 1 when CE = '1' and UP = '0' else
                       COUNT_TMP;

    COUNT <= std_logic_vector(COUNT_TMP);
    TC <= '1' when COUNT_TMP = (2**15) or COUNT_TMP = '0' else '0';
    CEO <= '1' when COUNT_TMP = (2**15) and CE = '1' else '0';       
    
end Behavioral; 

