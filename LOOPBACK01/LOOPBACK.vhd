----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2018 11:07:14
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
           AD_CS_O : out STD_LOGIC;
           AD_SCLK_O : out STD_LOGIC;
           AD_SDATA_I : in STD_LOGIC;
           DA_SYNC_O : out STD_LOGIC;
           DA_SCLK_O : out STD_LOGIC;
           DA_DIN_O : out STD_LOGIC);
end LOOPBACK;

architecture Behavioral of LOOPBACK is

signal SCLK : STD_LOGIC;

component SCLK_GEN is
  port (
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
end component;

begin

SCLK_GEN_0: SCLK_GEN
  port map (
    clk_out1 => SCLK,
    reset => RESET_I,
    locked => OPEN,
    clk_in1 => CLK_I
  );

AD_SCLK_O <= SCLK;
DA_SCLK_O <= SCLK;

end Behavioral;
