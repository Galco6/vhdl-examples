----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2018 11:05:14
-- Design Name: 
-- Module Name: LOOPBACK - Behavioral
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

entity LOOPBACK is
    Port ( CLK_I : in STD_LOGIC;
           RESET_I : in STD_LOGIC;
           AD_SDATA_I : in STD_LOGIC;
           AD_SCLK_O : out STD_LOGIC;
           AD_CS_O : out STD_LOGIC;
           DA_SYNC_O : out STD_LOGIC;
           DA_SCLK_O : out STD_LOGIC;
           DA_DIN_O : out STD_LOGIC;
           DA_DATA_I : in STD_LOGIC_VECTOR (15 downto 0)
     );

end LOOPBACK;

architecture Behavioral of LOOPBACK is

signal SCLK : STD_LOGIC;  --Declaramos señal interna
signal RESET: STD_LOGIC;  --Declaramos señal interna
signal LOCKED: STD_LOGIC; --Declaramos señal interna

component SCLK_GEN is  -- Divisor de frecuencia
  port (
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
 
end component;


component DA_Control is             --Convertidor DC
    Port ( RESET_I : in STD_LOGIC;
           CLK_I : in STD_LOGIC;
           SYNC_O : out STD_LOGIC;
           DIN_O : out STD_LOGIC;
           DATA_I : in STD_LOGIC_VECTOR (15 downto 0));
end component;


begin


Instancia_0: SCLK_GEN   --Cada llamada a cada componente tiene un nombre unico
  port map(
    clk_out1 => SCLK,
    reset => RESET_I,
    locked => LOCKED,
    clk_in1 => CLK_I
  );
  
  
Instancia_1: DA_Control              
      port map ( 
             RESET_I => RESET,
             CLK_I => SCLK,
             SYNC_O => DA_SYNC_O,
             DIN_O => DA_DIN_O,
             DATA_I => DA_DATA_I
  );  
  
RESET <= RESET_I or not LOCKED; -- RESET es interno. Si pulsamos RESET_I (externo) o LOCKED está a nivel bajo, mantenemos toda la parte sincrona parada, para evitar que avance mientras el reloj no es estable
AD_SCLK_O <= SCLK;
DA_SCLK_O <= SCLK; 
 
end Behavioral;


