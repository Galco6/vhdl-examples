----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2018 10:57:08
-- Design Name: 
-- Module Name: Filter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Filter is
    Port ( CLK : in STD_LOGIC;
           DATA_I : in STD_LOGIC_VECTOR (15 downto 0);
           RST : in STD_LOGIC;
           START_I : in STD_LOGIC;
           DATA_O : out STD_LOGIC_VECTOR (15 downto 0)
          );
end Filter;

architecture Behavioral of Filter is

type MATRIZ is array (0 to 18) of UNSIGNED(11 downto 0);
constant COEFF: MATRIZ := ( to_unsigned(24, 12),
                            to_unsigned(75, 12),
                            to_unsigned(107, 12),
                            to_unsigned(177, 12),
                            to_unsigned(244, 12),
                            to_unsigned(320, 12),
                            to_unsigned(389, 12),
                            to_unsigned(446, 12),
                            to_unsigned(483, 12),
                            to_unsigned(497, 12),
                            to_unsigned(483, 12),
                            to_unsigned(446, 12),                          
                            to_unsigned(389, 12),
                            to_unsigned(320, 12),
                            to_unsigned(244, 12),
                            to_unsigned(177, 12),
                            to_unsigned(107, 12),
                            to_unsigned(75, 12),
                            to_unsigned(24, 12)
                            );
signal DATA: MATRIZ;
signal START_FLAG: STD_LOGIC;

begin

process (RST,CLK) --Almacenamiento del dato
variable RESULT: UNSIGNED (23 downto 0);
begin
    if RST ='1' then
        DATA_O <= (others => '0');
        START_FLAG <= '0';
        for I in 0 to 18 loop
            DATA(I) <= (others => '0');
        end loop;
    elsif (CLK'event and CLK = '1') then
        if START_I = '1' then
            START_FLAG <= '1';
            for I in 0 to 17 loop
                DATA(I + 1) <= DATA(I);
            end loop;            
            DATA(0) <= unsigned(DATA_I (11 downto 0));

        elsif START_FLAG = '1' then
            START_FLAG <= '0';
            RESULT := (others =>'0');
            for I in 0 to 18 loop
               RESULT := RESULT + (COEFF(I)*DATA(I));
            end loop;
                DATA_O <= "0000" & std_logic_vector(RESULT(23 downto 12));
        end if;
    end if;
end process;

end Behavioral;
