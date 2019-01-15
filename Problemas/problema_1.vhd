----------------------------------------------------------------------------------
--  PROBLEMA 1
--
--  Obtén una descripción VHDL sintetizable para un circuito secuencial síncrono 
--  que genere una salida Z = 1 cuando se haya producido en la entrada X 
--  la secuencia 1101. La descripción debe incluir un reset asíncrono activado 
--  cuando la señal RESET = 1. 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity secuence is
    Port ( CLK_I in STD_LOGIC;
           RESET: in STD_LOGIC;
           X_I : in STD_LOGIC;
           Y_O : out STD_LOGIC
         );
end secuence;

architecture Behavioral of secuence is

signal secuence: STD_LOGIC_VECTOR;

begin


end Behavioral;
