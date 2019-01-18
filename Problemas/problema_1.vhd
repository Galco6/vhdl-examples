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
           Z_O : out STD_LOGIC
         );
end secuence;

architecture Behavioral of secuence is

signal SEC: STD_LOGIC_VECTOR (3 downto 0);

begin

process (RESET_I, CLK_I)
begin
    if RESET = '1' then
        SEC <= "0000"
    elsif (rising_edge(CLK_I)) then
        SEC (3 downto 1) <= SEC (2 downto 0)
        SEC (0) <= X_I;
        if (SEC = "1101") then
            Z_O <= 1;
        else
            Z_O <= 0;
        end if;
    end if;
    end if;
end process

end Behavioral;
