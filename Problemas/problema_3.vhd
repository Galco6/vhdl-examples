----------------------------------------------------------------------------------------------
--  PROBLEMA 3
--
-- Obtén una descripción VHDL sintetizable para un circuito secuencial síncrono que genere
-- el ciclo de refresco de una memoria RAM dinámica.
-- El circuito tiene las siguientes entradas: RESET (inicialización), CLK (sincronización acti-
-- va por flanco de subida) y START. Como señales de salida tiene las siguientes: RAS y CAS.
-- Partiendo de un estado inicial que podemos denominar de inactividad, mientras la señal
-- START=1 el circuito permanecerá en dicho estado, caracterizado por RAS=1 y CAS=1.
-- Cuando START=0 se puede pasar al primer estado de actividad caracterizado por RAS=1 y
-- CAS=0, esta situación debe mantenerse durante N ciclos (3 por ej.), tras lo cual se pasa al
-- estado final caracterizado por RAS=0 y CAS=0 . Tras este estado se vuelve a la situación
-- inicial de inactividad. La descripción debe permitir variar fácilmente el valor de N (indica
-- cómo se haría), y debe incluir un reset síncrono hacia el estado inicial activado cuando la
-- señal RESET = 1.
--
------------------------------------------------------------------------------------------------

library IEEE;
use IEEE_STD_LOGIC_1164.ALL;

entity RAM_control is
    generic(N: INTEGER :=4);
    PORT ( CLK_I in STD_LOGIC;
           RESET_I in STD_LOGIC;
           START_I in STD_LOGIC;
           RAS out STD_LOGIC;
           CAS out STD_LOGIC
         );

architecture Behavioral of RAM_control is

    type STATE_TYPE is (STATE0, STATE1, STATE2)
    signal STATE: STATE_TYPE;

begin

    process(CLK_I, RESET_I)
    begin
        if (CLK'event and CLK ='1') then
            if RESET = '1' then
                STATE <= STATE0;
                N = '0';
            else
                
                case STATE is 
                    when STATE0 =>
                        if START = '0' then
                            STATE <= STATE1;
                        else 
                            STATE <= STATE0;
                        end if;
                    when STATE1 =>
                        if N = '4' then
                            STATE <= STATE2;
                            N = '0';
                        else
                            STATE <= STATE1;
                            N = N + 1;
                        end if;
                    when STATE2 => 
                        STATE <= STATE0;
                end case;
            end if;
        end if;
    end process;

    process (CLK_I, RESET_I, STATE)
    begin
        case ESTADO is 
            when STATE0 =>
                RAS <= '1';
                CAS <= '1';  
            when STATE1 =>  
                RAS <= '1';
                CAS <= '0';      
            when STATE2 =>
                RAS <= '0';
                CAS <= '0';
        end case;
    end process;

end Behavioral;
    
