LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Accuracy_memory IS
    PORT (
        Clock, Reset : IN STD_LOGIC;
        finishing : IN STD_LOGIC;
        
        K_hyperparameter_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Best_parameter : OUT NATURAL;

        hyperparameter_result : IN NATURAL;
        Accuracy : OUT NATURAL
    );
END ENTITY Accuracy_memory;

ARCHITECTURE BEHAV OF Accuracy_memory IS
    SIGNAL hp_p, hp_n : NATURAL;
    SIGNAL ac_p, ac_n : NATURAL;
BEGIN

    PROCESS (Clock, Reset)
    BEGIN
        IF Reset = '1' THEN
            hp_p <= 0;
            ac_p <= 0;
        ELSIF Clock'event AND Clock = '1' THEN
            hp_p <= hp_n;
            ac_p <= ac_n;
        END IF;
    END PROCESS;
    
    PROCESS (hp_p, ac_p, K_hyperparameter_in, hyperparameter_result)
    BEGIN
        IF (ac_p < hyperparameter_result) THEN
            ac_n <= hyperparameter_result;
            hp_n <= to_integer(unsigned(K_hyperparameter_in));
        ELSE
            ac_n <= ac_p;
            hp_n <= hp_p;
        END IF;
    END PROCESS;

    Best_parameter <= hp_p WHEN finishing = '1' else 0;
    accuracy <= ac_p WHEN finishing = '1' else 0;
END ARCHITECTURE BEHAV;