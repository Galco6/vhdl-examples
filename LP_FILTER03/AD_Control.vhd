----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2018 10:45:52
-- Design Name: 
-- Module Name: AD_Control - Behavioral
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

entity AD_Control is
    Port ( AD_CS_O : out STD_LOGIC;
           AD_SCLK_O : out STD_LOGIC;
           AD_SDATA_I : in STD_LOGIC;
           CLK_I : in STD_LOGIC;
           RESET_I : in STD_LOGIC;
           AD_DATA_O: out STD_LOGIC_VECTOR (15 downto 0);
           RDY_O: out STD_LOGIC
          );
end AD_Control;

architecture Behavioral of AD_Control is

signal COUNT: integer range 0 to 19; --Señal interna que representa al contador
signal REG: STD_LOGIC_VECTOR (15 downto 0);

begin

process (RESET_I,CLK_I) --Contador
begin
   if RESET_I ='1' then
     COUNT <= 0;
   elsif (CLK_I'event and CLK_I = '1') then --Es lo mismo que decir rising_edge(CLK_I), que significa que compruebe el flanco de subida de la señal CLK_I
      if COUNT=19 then
         COUNT <=0;
      else
         COUNT <= COUNT + 1;
      end if;
   end if;
end process;

process (RESET_I,CLK_I) -- Señal CS
begin
   if RESET_I ='1' then
     AD_CS_O <='0';
   elsif (CLK_I'event and CLK_I = '1') then --Es lo mismo que decir rising_edge(CLK_I)
      if COUNT=0 then
         AD_CS_O <='1';
      else
         AD_CS_O <= '0';
      end if;
   end if;
end process;

process (RESET_I,CLK_I) --Lectura de SDATA
begin
   if RESET_I ='1' then         --No hace falta el reset
     REG  <= "0000000000000000";
   elsif (CLK_I'event and CLK_I = '0') then
    if COUNT > 1 and COUNT < 18 then
        REG(0) <= AD_SDATA_I;
        REG (15 downto 1) <= REG (14 downto 0);
    elsif COUNT = 18 then
        AD_DATA_O  <= "0" & REG(14 downto 0);
    end if;
   end if;
end process;

process (RESET_I,CLK_I) 
begin
   if RESET_I ='1' then        
     RDY_O <= '0';
   elsif (CLK_I'event and CLK_I = '1') then
    if COUNT = 18 then
        RDY_O <= '1';
    else 
        RDY_O <= '0';
    end if;
   end if;
end process;
end Behavioral;
