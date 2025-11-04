LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Controller IS
    PORT (
        Clock, Reset : IN STD_LOGIC;
        Test_clas_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);

        Test_clas_out : OUT STD_LOGIC;
        K_hyperparameter_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Address_test, Address_train : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
        Reading : OUT STD_LOGIC;
        Adding, Averaging : OUT STD_LOGIC;
        Finishing : OUT STD_LOGIC;
        forcing_reset_CD, forcing_reset_DM : OUT STD_LOGIC
    );
END ENTITY Controller;

ARCHITECTURE BEHAV OF Controller IS

    TYPE states IS (Idle, Calculation, Class_Detection, Hp_Avrageing, Reseting_DM, Reseting_CD, Ending);
    SIGNAL Pstate, Nstate : states;
    SIGNAL PCounter1, PCounter2, PHp_counter : NATURAL;
    SIGNAL NCounter1, NCounter2, NHp_counter : NATURAL;

BEGIN

    PROCESS (Clock, Reset)
    BEGIN
        IF Reset = '1' THEN
            Pstate <= Idle;
            PCounter1 <= 1;
            PCounter2 <= 1;
            PHp_counter <= 1;
        ELSIF Clock'event AND Clock = '1' THEN
            Pstate <= Nstate;
            PCounter1 <= NCounter1;
            PCounter2 <= NCounter2;
            PHp_counter <= NHp_counter;
        END IF;
    END PROCESS;

    ------------------------

    Next_state_logic : PROCESS (PCounter1, PCounter2, PHp_counter, Pstate, Test_clas_in, Reset)
    BEGIN
        NCounter1 <= PCounter1;
        NCounter2 <= PCounter2;
        NHp_counter <= PHp_counter;
        Nstate <= Idle;
        CASE Pstate IS
            WHEN Idle =>
                IF (Reset = '0') THEN
                    Nstate <= Calculation;
                ELSE
                    Nstate <= Idle;
                END IF;
                --------------------
            WHEN Calculation =>
                IF (PCounter1 < 253680) THEN
                    IF (PCounter2 < 253680) THEN
                        NCounter2 <= PCounter2 + 1;
                        Nstate <= Calculation;
                    ELSE
                        Nstate <= Class_Detection;
                    END IF;
                ELSE
                    Nstate <= Hp_Avrageing;
                END IF;
                --------------------
            WHEN Class_Detection =>
                NCounter1 <= PCounter1 + 1;
                NCounter2 <= 1;
                Nstate <= Reseting_DM;
                --------------------
            WHEN Reseting_DM =>
                Nstate <= Calculation;
                --------------------
            WHEN Hp_Avrageing =>
                IF PHp_counter < 8 THEN
                    NCounter1 <= 1;
                    NCounter2 <= 1;
                    NHp_counter <= PHp_counter + 1;
                    Nstate <= Reseting_CD;
                ELSE
                    Nstate <= Ending;
                END IF;
                --------------------
            WHEN Reseting_CD =>
                Nstate <= Calculation;
                --------------------
            WHEN Ending =>
                Nstate <= Ending;
                --------------------
            WHEN OTHERS =>
                Nstate <= Idle;
        END CASE;
    END PROCESS Next_state_logic;

    ------------------------

    Moore_output_logic : PROCESS (PCounter1, PCounter2, PHp_counter, Pstate)
    BEGIN
        K_hyperparameter_out <= STD_LOGIC_VECTOR(to_unsigned(PHp_counter, K_hyperparameter_out'length));
        Address_test <= STD_LOGIC_VECTOR(to_unsigned(PCounter1, Address_test'length));
        Address_train <= STD_LOGIC_VECTOR(to_unsigned(PCounter2, Address_train'length));
        forcing_reset_CD <= '0';
        forcing_reset_DM <= '0';
        CASE Pstate IS
            WHEN Idle =>
                Test_clas_out <= '0';
                Reading <= '0';
                Adding <= '0';
                Averaging <= '0';
                Finishing <= '0';
                --------------------
            WHEN Calculation =>
                IF PCounter1 /= PCounter2 THEN
                    Reading <= '1';
                ELSE
                    Reading <= '0';
                END IF;
                Test_clas_out <= test_clas_in(0);
                Adding <= '0';
                Averaging <= '0';
                Finishing <= '0';
                --------------------
            WHEN Class_Detection =>
                Test_clas_out <= test_clas_in(0);
                Reading <= '0';
                Adding <= '1';
                Averaging <= '0';
                Finishing <= '0';
                --------------------
            WHEN Reseting_DM =>
                Test_clas_out <= '0';
                Reading <= '0';
                Adding <= '0';
                Averaging <= '0';
                Finishing <= '0';
                forcing_reset_DM <= '1';
                --------------------
            WHEN Hp_Avrageing =>
                Test_clas_out <= test_clas_in(0);
                Reading <= '0';
                Adding <= '0';
                Averaging <= '1';
                Finishing <= '0';
                --------------------
            WHEN Reseting_CD =>
                Test_clas_out <= '0';
                Reading <= '0';
                Adding <= '0';
                Averaging <= '0';
                Finishing <= '0';
                forcing_reset_CD <= '1';
                forcing_reset_DM <= '1';
                --------------------
            WHEN Ending =>
                Test_clas_out <= Test_clas_in(0);
                Reading <= '0';
                Adding <= '0';
                Averaging <= '0';
                Finishing <= '1';
                --------------------
            WHEN OTHERS =>
                Test_clas_out <= '0';
                Reading <= '0';
                Adding <= '0';
                Averaging <= '0';
                Finishing <= '0';
        END CASE;
    END PROCESS Moore_output_logic;

END ARCHITECTURE BEHAV;
