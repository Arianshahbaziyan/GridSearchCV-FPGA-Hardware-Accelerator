LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.TEXTIO.ALL;

ENTITY Main_memory IS
    PORT (
        Clock, Reset : IN STD_LOGIC;
        Address_test, Address_train : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        Reading : IN STD_LOGIC;
        Tsout1, Tsout2, Tsout3, Tsout5, Tsout6, Tsout7,
        Tsout8, Tsout9, Tsout10, Tsout11, Tsout12, Tsout13, Tsout17, Tsout18,
        Tsout4, Tsout14, Tsout15, Tsout16, Tsout19, Tsout20, Tsout21 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        Test_class : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        Trout1, Trout2, Trout3, Trout5, Trout6, Trout7,
        Trout8, Trout9, Trout10, Trout11, Trout12, Trout13, Trout17, Trout18,
        Trout4, Trout14, Trout15, Trout16, Trout19, Trout20, Trout21 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        Train_class : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
    );
END ENTITY Main_memory;

ARCHITECTURE BEHAV OF Main_memory IS

    TYPE MatrixType IS ARRAY (1 TO 253680, 1 TO 22) OF INTEGER;
    SIGNAL matrix : MatrixType;

BEGIN
    PROCESS (Clock, Reset)
        FILE file_pointer : text;
        VARIABLE lineBuffer : line;
        VARIABLE dataElement : INTEGER;
        VARIABLE row : INTEGER := 1;
        VARIABLE col : INTEGER := 1;
    BEGIN
        IF (Reset = '1') THEN
            file_open(file_pointer, "A:\uni\Thesis\Implementation\Comparison\HW\253680\Diabetes_V1.txt", READ_MODE);
            Tsout1 <= (OTHERS => '0');
            Tsout2 <= (OTHERS => '0');
            Tsout3 <= (OTHERS => '0');
            Tsout4 <= (OTHERS => '0');
            Tsout5 <= (OTHERS => '0');
            Tsout6 <= (OTHERS => '0');
            Tsout7 <= (OTHERS => '0');
            Tsout8 <= (OTHERS => '0');
            Tsout9 <= (OTHERS => '0');
            Tsout10 <= (OTHERS => '0');
            Tsout11 <= (OTHERS => '0');
            Tsout12 <= (OTHERS => '0');
            Tsout13 <= (OTHERS => '0');
            Tsout14 <= (OTHERS => '0');
            Tsout15 <= (OTHERS => '0');
            Tsout16 <= (OTHERS => '0');
            Tsout17 <= (OTHERS => '0');
            Tsout18 <= (OTHERS => '0');
            Tsout19 <= (OTHERS => '0');
            Tsout20 <= (OTHERS => '0');
            Tsout21 <= (OTHERS => '0');
            Test_class <= (OTHERS => '0');
            ------------------------
            Trout1 <= (OTHERS => '0');
            Trout2 <= (OTHERS => '0');
            Trout3 <= (OTHERS => '0');
            Trout4 <= (OTHERS => '0');
            Trout5 <= (OTHERS => '0');
            Trout6 <= (OTHERS => '0');
            Trout7 <= (OTHERS => '0');
            Trout8 <= (OTHERS => '0');
            Trout9 <= (OTHERS => '0');
            Trout10 <= (OTHERS => '0');
            Trout11 <= (OTHERS => '0');
            Trout12 <= (OTHERS => '0');
            Trout13 <= (OTHERS => '0');
            Trout14 <= (OTHERS => '0');
            Trout15 <= (OTHERS => '0');
            Trout16 <= (OTHERS => '0');
            Trout17 <= (OTHERS => '0');
            Trout18 <= (OTHERS => '0');
            Trout19 <= (OTHERS => '0');
            Trout20 <= (OTHERS => '0');
            Trout21 <= (OTHERS => '0');
            Train_class <= (OTHERS => '0');

            WHILE row < 253681 LOOP
                readline(file_pointer, lineBuffer);
                col := 1;
                WHILE col < 23 LOOP
                    read(lineBuffer, dataElement);
                    matrix(row, col) <= dataElement;
                    col := col + 1;
                END LOOP;
                row := row + 1;
            END LOOP;
            file_close(file_pointer);
            
        ELSIF (Clock'event AND Clock = '1') THEN
            IF Reading = '1' THEN
                Tsout1 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 1), 6));
                Tsout2 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 2), 6));
                Tsout3 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 3), 6));
                Tsout4 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 4), 6));
                Tsout5 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 5), 6));
                Tsout6 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 6), 6));
                Tsout7 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 7), 6));
                Tsout8 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 8), 6));
                Tsout9 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 9), 6));
                Tsout10 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 10), 6));
                Tsout11 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 11), 6));
                Tsout12 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 12), 6));
                Tsout13 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 13), 6));
                Tsout14 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 14), 6));
                Tsout15 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 15), 6));
                Tsout16 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 16), 6));
                Tsout17 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 17), 6));
                Tsout18 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 18), 6));
                Tsout19 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 19), 6));
                Tsout20 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 20), 6));
                Tsout21 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 21), 6));
                Test_class <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_test)), 22), 6));
                ------------------------
                Trout1 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 1), 6));
                Trout2 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 2), 6));
                Trout3 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 3), 6));
                Trout4 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 4), 6));
                Trout5 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 5), 6));
                Trout6 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 6), 6));
                Trout7 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 7), 6));
                Trout8 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 8), 6));
                Trout9 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 9), 6));
                Trout10 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 10), 6));
                Trout11 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 11), 6));
                Trout12 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 12), 6));
                Trout13 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 13), 6));
                Trout14 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 14), 6));
                Trout15 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 15), 6));
                Trout16 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 16), 6));
                Trout17 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 17), 6));
                Trout18 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 18), 6));
                Trout19 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 19), 6));
                Trout20 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 20), 6));
                Trout21 <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 21), 6));
                Train_class <= STD_LOGIC_VECTOR(to_unsigned(matrix(to_integer(unsigned(Address_train)), 22), 6));
            ELSE
                Tsout1 <=(others => '0');
                Tsout2 <=(others => '0');
                Tsout3 <=(others => '0');
                Tsout4 <=(others => '0');
                Tsout5 <=(others => '0');
                Tsout6 <=(others => '0');
                Tsout7 <=(others => '0');
                Tsout8 <=(others => '0');
                Tsout9 <=(others => '0');
                Tsout10 <= (others => '0');
                Tsout11 <= (others => '0');
                Tsout12 <= (others => '0');
                Tsout13 <= (others => '0');
                Tsout14 <= (others => '0');
                Tsout15 <= (others => '0');
                Tsout16 <= (others => '0');
                Tsout17 <= (others => '0');
                Tsout18 <= (others => '0');
                Tsout19 <= (others => '0');
                Tsout20 <= (others => '0');
                Tsout21 <= (others => '0');
                Test_class <= (others => '0');
                ------------------------
                Trout1 <= (others => '0');
                Trout2 <= (others => '0');
                Trout3 <= (others => '0');
                Trout4 <= (others => '0');
                Trout5 <= (others => '0');
                Trout6 <= (others => '0');
                Trout7 <= (others => '0');
                Trout8 <= (others => '0');
                Trout9 <= (others => '0');
                Trout10 <= (others => '0');
                Trout11 <= (others => '0');
                Trout12 <= (others => '0');
                Trout13 <= (others => '0');
                Trout14 <= (others => '0');
                Trout15 <= (others => '0');
                Trout16 <= (others => '0');
                Trout17 <= (others => '0');
                Trout18 <= (others => '0');
                Trout19 <= (others => '0');
                Trout20 <= (others => '0');
                Trout21 <= (others => '0');
                Train_class <= (others => '0');
            END IF;
        END IF;
    END PROCESS;

END BEHAV;