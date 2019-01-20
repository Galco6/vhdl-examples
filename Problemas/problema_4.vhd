----------------------------------------------------------------------------------------------
--  PROBLEMA 4
--
-- Obtén una descripción VHDL sintetizable para un circuito secuencial síncrono que genere
-- una salida Z = 1 cuando se haya producido en la entrada X una secuencia predeterminada
-- de cuatro valores (por ejemplo 1101). Si la secuencia se rompe se debe incializar el fun-
-- cionamiento del detector. La descripción debe permitir variar fácilmente la secuencia (in-
-- dica cómo se haría), y debe incluir un reset síncrono activado cuando la señal RESET = 0.
--
------------------------------------------------------------------------------------------------

library IEEE;
use IEEE_STD_LOGIC_1164.ALL

entity secuence is
    generic (pattern: STD_LOGIC_VECTOR (3 downto 0) := "1101");  --Secuencia que se debe detectar
    PORT ( CLK_I in STD_LOGIC;
           RESET_I in STD_LOGIC;
           X_I in STD_LOGIC;
           Z_O in STD_LOGIC
         );

architecture Behavioral of secuence is 
    
    signal SEC: STD_LOGIC_VECTOR (3 downto 0);
    signal N: STD_LOGIC;
    signal DETECTOR: STD_LOGIC;

begin

    process (CLK_I, RESET_I)
    begin
        if (rising_edge(CLK_I)) then
            if RESET_I = '0' then
                N <= '0';
                SEC <= "0000";
                Z <= '0';
            else            
                if SEC(N) = X_I then
                    if N = '4' then
                        Z <= '1'
                        N <= '0';
                    else
                        N <= N + 1;
                    end if;
                else
                    DETECTOR <= '1';
                    N <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
                 
            
           
