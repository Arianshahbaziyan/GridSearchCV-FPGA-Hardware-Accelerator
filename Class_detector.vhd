LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY class_detector IS
    PORT (
        Clock, Reset, forcing_reset_CD : IN STD_LOGIC;
        Adding, Averaging : IN STD_LOGIC;
        Test_class_in : IN STD_LOGIC;
        Neighbour1, Neighbour2, Neighbour3, Neighbour4, Neighbour5, Neighbour6, Neighbour7, Neighbour8 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        K_hyperparameter_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        hyperparameter_result : OUT NATURAL
    );
END ENTITY class_detector;

ARCHITECTURE BEHAV OF class_detector IS
    SIGNAL N1, N2, N3, N4, N5, N6, N7, N8 : unsigned(1 downto 0);
    SIGNAL hyperparameter_resultP, hyperparameter_resultN : NATURAL;
    SIGNAL temp_class, divison, Detected : NATURAL;
    SIGNAL class_avg : STD_LOGIC;
BEGIN

    PROCESS (Clock, Reset, forcing_reset_CD)
    BEGIN
        IF Reset = '1' or forcing_reset_CD = '1' THEN
            hyperparameter_resultP <= 0;
        ELSIF Clock'event AND Clock = '1' THEN
            hyperparameter_resultP <= hyperparameter_resultN;
        END IF;
    END PROCESS;

    divison <= to_integer(unsigned(K_hyperparameter_in)) / 2;

    N1 <= unsigned(neighbour1); 
    N2 <= unsigned(neighbour2); 
    N3 <= unsigned(neighbour3); 
    N4 <= unsigned(neighbour4); 
    N5 <= unsigned(neighbour5);
    N6 <= unsigned(neighbour6); 
    N7 <= unsigned(neighbour7); 
    N8 <= unsigned(neighbour8);

    WITH K_hyperparameter_in SELECT temp_class <=
        to_integer((N1)) + to_integer((N2)) + to_integer((N3)) + to_integer((N4)) + to_integer((N5)) + to_integer((N6)) + to_integer((N7)) + to_integer((N8)) WHEN "1000",
        to_integer((N1)) + to_integer((N2)) + to_integer((N3)) + to_integer((N4)) + to_integer((N5)) + to_integer((N6)) + to_integer((N7)) WHEN "0111",
        to_integer((N1)) + to_integer((N2)) + to_integer((N3)) + to_integer((N4)) + to_integer((N5)) + to_integer((N6)) WHEN "0110",
        to_integer((N1)) + to_integer((N2)) + to_integer((N3)) + to_integer((N4)) + to_integer((N5)) WHEN "0101",
        to_integer((N1)) + to_integer((N2)) + to_integer((N3)) + to_integer((N4)) WHEN "0100",
        to_integer((N1)) + to_integer((N2)) + to_integer((N3)) WHEN "0011",
        to_integer((N1)) + to_integer((N2)) WHEN "0010",
        to_integer((N1)) WHEN OTHERS;

    class_avg <= '1' WHEN divison < temp_class ELSE
        '0';

    Detected <= 1 WHEN Test_class_in = class_avg ELSE
        0;

    hyperparameter_resultN <= hyperparameter_resultP + Detected WHEN Adding = '1' ELSE
        hyperparameter_resultP;

    hyperparameter_result <= ((hyperparameter_resultP * 100) / 253679) WHEN Averaging = '1' ELSE
        0;
END ARCHITECTURE BEHAV;