----------------------------------------------------------------------------------------------
--  PROBLEMA 5
--
-- Obtén una descripción VHDL sintetizable para un circuito secuencial síncrono que genere
-- las señales de control necesarias para que una memoria RAM dinámica realice una opera-
-- ción de escritura. El circuito tiene las siguientes entradas: RESET (inicialización), CLK
-- (sincronización activa por flanco de subida), START y FAST. Como señales de salida tie-
-- ne las siguientes: RAS, CAS, OE y RDY.
-- El diagrama de estados a seguir es el de la figura y la descripción debe incluir una iniciali-
-- zación asíncrona hacia el estado READ0 cuando RESET = 1.
--
------------------------------------------------------------------------------------------------

library IEEE;
use IEEE_STD_LOGIC_1164.ALL;

entity RAM_CONTROL is
    PORT ( RESET_I in STD_LOGIC;
           CLK_I in STD_LOGIC;
           START in STD_LOGIC;
           FAST in STD_LOGIC;
           RAS out STD_LOGIC;
           CAS out STD_LOGIC;
           OE out STD_LOGIC;
           RDY out STD_LOGIC
         );
end RAM_CONTROL;

architecture Behavioral of RAM_CONTROL is

    type STATE_TYPE is (READ0, READ1, READ2, READ3, READ04);
    signal STATE: STATE_TYPE;

begin

    process (CLK_I, RESET_I)
    begin
        if (RESET = '1') then
            STATE <= READ0;
        elsif (rising_edge(CLK_I)) then
            case STATE is 
                when READ0 =>
                    if START = '1' or RAS = '1' then
                        STATE <= READ0;
                    else
                        state <= READ1;
                    end if;
                when READ1 =>
                    if FAST = '0' then 
                        STATE <= READ2;
                    else
                        STATE <= READ3;
                    end if;
                when READ2 =>
                    STATE <= READ3;
                when READ3 =>
                    STATE <= READ4;
                when READ4 =>
                    if START = '0' then
                        STATE <= READ4;
                    else
                        STATE <= READ0;
                    end if;
            end case;
        end if;
    end process;

    process (STATE, START, FAST)
    begin
        case STATE is
            when READ0 =>
				RAS <= START;
				CAS <= '1';
				OE <= '1';
				RDY <= '0';
			when READ1 =>
				RAS <= '0';
				CAS <= '0';
				OE <= '1';
				RDY <= '0';
			when READ2 =>
				RAS <= '0';
				CAS <= '0';
				OE <= '1';
				RDY <= '0';
			when READ3 =>
				RAS <= '0';
				CAS <= '0';
				OE <= '0';
				RDY <= '0';
			when READ4 =>
				RAS <= '0';
				CAS <= '0';
				OE <= '0';
				RDY <= '1';
		end casE;
    end process;

end Behavioral;
                    


















