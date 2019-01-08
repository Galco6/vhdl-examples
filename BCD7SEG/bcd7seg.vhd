----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2018 10:43:39
-- Design Name: 
-- Module Name: bcd7seg - Behavioral
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

entity bcd7seg is
    Port ( BCD_I : in STD_LOGIC_VECTOR (3 downto 0);
           A_O : out STD_LOGIC;
           B_O : out STD_LOGIC;
           C_O : out STD_LOGIC;
           D_O : out STD_LOGIC;
           E_O : out STD_LOGIC;
           F_O : out STD_LOGIC;
           G_O : out STD_LOGIC;
           AN0_O: out STD_LOGIC);
           
end bcd7seg;

architecture Behavioral of bcd7seg is
signal LED : STD_LOGIC_VECTOR (6 downto 0);
begin
--HEX-to-seven-segment decoder
--   HEX:   in    STD_LOGIC_VECTOR (3 downto 0);
--   LED:   out   STD_LOGIC_VECTOR (6 downto 0);
--
-- segment encoinputg
--      a
--     ---
--  f |   | b
--     ---   <- g
--  e |   | c
--     ---
--      d

    with BCD_I select
   LED<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0
         
A_O <= LED(0);
B_O <= LED(1);
C_O <= LED(2);
D_O <= LED(3);
E_O <= LED(4);
F_O <= LED(5);
G_O <= LED(6);

AN0_O <= '0';

end Behavioral;
