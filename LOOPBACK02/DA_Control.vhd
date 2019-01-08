----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2018 11:02:59
-- Design Name: 
-- Module Name: DA_Control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DA_Control is
    Port ( RESET_I : in STD_LOGIC;
           CLK_I : in STD_LOGIC;
           SYNC_O : out STD_LOGIC;
           DIN_O : out STD_LOGIC;
           DATA_I : in STD_LOGIC_VECTOR (15 downto 0)
   );
end DA_Control;

architecture Behavioral of DA_Control is

signal COUNT: integer range 0 to 19; --Señal interna que representa al contador
signal REG: STD_LOGIC_VECTOR (15 downto 0);

begin

process (RESET_I,CLK_I)
begin
   if RESET_I ='1' then
     COUNT <=0;
   elsif (CLK_I'event and CLK_I = '1') then --Es lo mismo que decir rising_edge(CLK_I), que significa que compruebe el flanco de subida de la señal CLK_I
      if COUNT=19 then
         COUNT <=0;
      else
         COUNT <= COUNT + 1;
      end if;
   end if;
end process;

process (RESET_I,CLK_I)
begin
   if RESET_I ='1' then
     REG <= "0000000000000000";
   elsif (CLK_I'event and CLK_I = '1') then --Es lo mismo que decir rising_edge(CLK_I), que significa que compruebe el flanco de subida de la señal CLK_I
      if COUNT=1 then
         REG <=DATA_I;             -- Carga en paralelo de los 16 bits
      elsif COUNT > 1 then
         REG (15 downto 1) <= REG (14 downto 0); --Desplazamiento a la izquierad
      end if;
   end if;
end process;

DIN_O <= REG(15); --Mandamos por la salida el bit mas significativo. Esta asignacion podemos hacerla al principio del todo, no importa su posicion


process (RESET_I,CLK_I)
begin
   if RESET_I ='1' then
     SYNC_O <='0';
   elsif (CLK_I'event and CLK_I = '0') then --Es lo mismo que decir rising_edge(CLK_I), que significa que compruebe el flanco de subida de la señal CLK_I
      if COUNT=0 then
         SYNC_O <='1';
      else
         SYNC_O <= '0';
      end if;
   end if;
end process;


end Behavioral;
