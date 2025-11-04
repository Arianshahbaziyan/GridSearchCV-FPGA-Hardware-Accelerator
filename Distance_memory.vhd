LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Distance_memory IS
    PORT (
        Clock, Reset, forcing_reset_DM : IN STD_LOGIC;
        Distance : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        Train_class_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        Neighbour1, Neighbour2, Neighbour3, Neighbour4, Neighbour5, Neighbour6, Neighbour7, Neighbour8 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY Distance_memory;

ARCHITECTURE BEHAV OF Distance_memory IS
    SIGNAL class_Distance : STD_LOGIC_VECTOR(10 DOWNTO 0);
    SIGNAL ps1, ps2, ps3, ps4, ps5, ps6, ps7, ps8 : STD_LOGIC_VECTOR(10 DOWNTO 0);
    SIGNAL ns1, ns2, ns3, ns4, ns5, ns6, ns7, ns8 : STD_LOGIC_VECTOR(10 DOWNTO 0);
BEGIN
    class_Distance <= Distance & Train_class_in(0);
    ClockING : PROCESS (Clock, Reset, forcing_reset_DM)
    BEGIN
        IF RESET = '1' OR forcing_reset_DM = '1' THEN
            ps1 <= (OTHERS => '0');
            ps2 <= (OTHERS => '0');
            ps3 <= (OTHERS => '0');
            ps4 <= (OTHERS => '0');
            ps5 <= (OTHERS => '0');
            ps6 <= (OTHERS => '0');
            ps7 <= (OTHERS => '0');
            ps8 <= (OTHERS => '0');
        ELSIF Clock'event AND Clock = '1' THEN
            ps1 <= ns1;
            ps2 <= ns2;
            ps3 <= ns3;
            ps4 <= ns4;
            ps5 <= ns5;
            ps6 <= ns6;
            ps7 <= ns7;
            ps8 <= ns8;
        END IF;
    END PROCESS ClockING;

    SORTING : PROCESS (class_Distance)
    BEGIN
        ns1 <= ps1;
        ns2 <= ps2;
        ns3 <= ps3;
        ns4 <= ps4;
        ns5 <= ps5;
        ns6 <= ps6;
        ns7 <= ps7;
        ns8 <= ps8;
        IF (((class_Distance(10 DOWNTO 1)) < (ps1(10 DOWNTO 1))) OR ps1 = "00000000000") AND Distance /= "0000000000" THEN
            ns1 <= class_Distance;
            IF (((ps1(10 DOWNTO 1)) < (ps2(10 DOWNTO 1))) OR ps2 = "00000000000")THEN
                ns2 <= ps1;
                IF (((ps2(10 DOWNTO 1)) < (ps3(10 DOWNTO 1))) OR ps3 = "00000000000") THEN
                    ns3 <= ps2;
                    IF (((ps3(10 DOWNTO 1)) < (ps4(10 DOWNTO 1))) OR ps4 = "00000000000") THEN
                        ns4 <= ps3;
                        IF (((ps4(10 DOWNTO 1)) < (ps5(10 DOWNTO 1))) OR ps5 = "00000000000") THEN
                            ns5 <= ps4;
                            IF (((ps5(10 DOWNTO 1)) < (ps6(10 DOWNTO 1))) OR ps6 = "00000000000") THEN
                                ns6 <= ps5;
                                IF (((ps6(10 DOWNTO 1)) < (ps7(10 DOWNTO 1))) OR ps7 = "00000000000") THEN
                                    ns7 <= ps6;
                                    IF (((ps7(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000") THEN
                                        ns8 <= ps7;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        ELSIF (((class_Distance(10 DOWNTO 1)) < (ps2(10 DOWNTO 1))) OR ps2 = "00000000000") AND Distance /= "0000000000" THEN
            ns2 <= class_Distance;
            IF (((ps2(10 DOWNTO 1)) < (ps3(10 DOWNTO 1))) OR ps3 = "00000000000") THEN
                ns3 <= ps2;
                IF (((ps3(10 DOWNTO 1)) < (ps4(10 DOWNTO 1))) OR ps4 = "00000000000") THEN
                    ns4 <= ps3;
                    IF (((ps4(10 DOWNTO 1)) < (ps5(10 DOWNTO 1))) OR ps5 = "00000000000") THEN
                        ns5 <= ps4;
                        IF (((ps5(10 DOWNTO 1)) < (ps6(10 DOWNTO 1))) OR ps6 = "00000000000") THEN
                            ns6 <= ps5;
                            IF (((ps6(10 DOWNTO 1)) < (ps7(10 DOWNTO 1))) OR ps7 = "00000000000") THEN
                                ns7 <= ps6;
                                IF (((ps7(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000")THEN
                                    ns8 <= ps7;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        ELSIF (((class_Distance(10 DOWNTO 1)) < (ps3(10 DOWNTO 1))) OR ps3 = "00000000000") AND Distance /= "0000000000" THEN
            ns3 <= class_Distance;
            IF (((ps3(10 DOWNTO 1)) < (ps4(10 DOWNTO 1))) OR ps4 = "00000000000") THEN
                ns4 <= ps3;
                IF (((ps4(10 DOWNTO 1)) < (ps5(10 DOWNTO 1))) OR ps5 = "00000000000") THEN
                    ns5 <= ps4;
                    IF (((ps5(10 DOWNTO 1)) < (ps6(10 DOWNTO 1))) OR ps6 = "00000000000") THEN
                        ns6 <= ps5;
                        IF (((ps6(10 DOWNTO 1)) < (ps7(10 DOWNTO 1))) OR ps7 = "00000000000") THEN
                            ns7 <= ps6;
                            IF (((ps7(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000") THEN
                                ns8 <= ps7;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        ELSIF (((class_Distance(10 DOWNTO 1)) < (ps4(10 DOWNTO 1))) OR ps4 = "00000000000") AND Distance /= "0000000000" THEN
            ns4 <= class_Distance;
            IF (((ps4(10 DOWNTO 1)) < (ps5(10 DOWNTO 1))) OR ps5 = "00000000000") THEN
                ns5 <= ps4;
                IF (((ps5(10 DOWNTO 1)) < (ps6(10 DOWNTO 1))) OR ps6 = "00000000000") THEN
                    ns6 <= ps5;
                    IF (((ps6(10 DOWNTO 1)) < (ps7(10 DOWNTO 1))) OR ps7 = "00000000000") THEN
                        ns7 <= ps6;
                        IF (((ps7(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000") THEN
                            ns8 <= ps7;
                        END IF;
                    END IF;
                END IF;
            END IF;
        ELSIF (((class_Distance(10 DOWNTO 1)) < (ps5(10 DOWNTO 1))) OR ps5 = "00000000000") AND Distance /= "0000000000" THEN
            ns5 <= class_Distance;
            IF (((ps5(10 DOWNTO 1)) < (ps6(10 DOWNTO 1))) OR ps6 = "00000000000") THEN
                ns6 <= ps5;
                IF (((ps6(10 DOWNTO 1)) < (ps7(10 DOWNTO 1))) OR ps7 = "00000000000") THEN
                    ns7 <= ps6;
                    IF (((ps7(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000") THEN
                        ns8 <= ps7;
                    END IF;
                END IF;
            END IF;
        ELSIF (((class_Distance(10 DOWNTO 1)) < (ps6(10 DOWNTO 1))) OR ps6 = "00000000000") AND Distance /= "0000000000" THEN
            ns6 <= class_Distance;
            IF (((ps6(10 DOWNTO 1)) < (ps7(10 DOWNTO 1))) OR ps7 = "00000000000") THEN
                ns7 <= ps6;
                IF (((ps7(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000") THEN
                    ns8 <= ps7;
                END IF;
            END IF;
        ELSIF (((class_Distance(10 DOWNTO 1)) < (ps7(10 DOWNTO 1))) OR ps7 = "00000000000") AND Distance /= "0000000000" THEN
            ns7 <= class_Distance;
            IF (((ps7(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000") THEN
                ns8 <= ps7;
            END IF;
        ELSIF (((class_Distance(10 DOWNTO 1)) < (ps8(10 DOWNTO 1))) OR ps8 = "00000000000") AND Distance /= "0000000000" THEN
            ns8 <= class_Distance;
        END IF;

    END PROCESS SORTING;

    Neighbour1 <= '0' & ps1(0);
    Neighbour2 <= '0' & ps2(0);
    Neighbour3 <= '0' & ps3(0);
    Neighbour4 <= '0' & ps4(0);
    Neighbour5 <= '0' & ps5(0);
    Neighbour6 <= '0' & ps6(0);
    Neighbour7 <= '0' & ps7(0);
    Neighbour8 <= '0' & ps8(0);

END ARCHITECTURE BEHAV;