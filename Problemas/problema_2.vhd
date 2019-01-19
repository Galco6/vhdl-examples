--------------------------------------------------------------------------------------
--  PROBLEMA 2
--
-- Obtén una descripción VHDL sintetizable para un contador BCD. La descripción debe
-- incluir una función de carga paralela síncrona activada cuando la señal LOAD = 1, 
-- y un reset asíncrono activado cuando la señal RESET = 1.
--
--------------------------------------------------------------------------------------

library IEEE;
use IEEE_STD_LOGIC_1164.ALL;

entity BCD_counter is
    Port ( CLK_I in STD_LOGIC;
           RESET_I in STD_LOGIC;
           LOAD in STD_LOGIC;
           COUNT_0 out STD_LOGIC_VECTOR (3 downto 0)
         );
end BCD_counter;

architecture Behavioral of BCD_counter is

signal BCD: STD_LOGIC_VECTOR (3 downto 0);

begin

process (CLK_I, RESET_I)
begin
    if (RESET = '1') then
        BCD <= "0000";
    elsif (rising_edge(CLK_I)) then
        if (BCD = "1001") then
            BCD <= "0000";
        else
            BCD <= BCD + 1;
        end if;
        if (LOAD = 1) then
            COUNT_0 <= BCD;
        else 
            COUNT_0 <= "0000";
        end if;
    end if;
    end if;
end process;

end Behavioral;
        
