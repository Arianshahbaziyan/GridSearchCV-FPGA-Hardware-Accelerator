LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GSCVTB IS

END ENTITY GSCVTB;

ARCHITECTURE Test OF GSCVTB IS

    COMPONENT GSCV
    	PORT (
        Clock, Reset : IN STD_LOGIC;
        Best_parameter : OUT NATURAL;
        Accuracy : OUT NATURAL;
        status : OUT STD_LOGIC
    	);
    END COMPONENT;

    SIGNAL Clock, Reset, status : STD_LOGIC;
    SIGNAL Best_parameter, Accuracy : NATURAL;

BEGIN

    DUT : GSCV PORT MAP
    (
        Clock => Clock,
        Reset => Reset,
        Best_parameter => Best_parameter,
        Accuracy => Accuracy,
	status => status
    );

    TB : PROCESS
    BEGIN
        Reset <= '1';
        Clock <= '0';
        WAIT FOR 40 ns;
        Reset <= '0';
        WHILE status = '0' LOOP
            Clock <= not Clock;
            WAIT FOR 5 ns; 
        END LOOP;        
	Clock <= not Clock;
        WAIT FOR 5 ns; 
	Clock <= not Clock;
        WAIT FOR 5 ns;
	Clock <= not Clock;
        WAIT FOR 5 ns; 
	Clock <= not Clock;
        WAIT; 
    END PROCESS TB;

END ARCHITECTURE Test;
