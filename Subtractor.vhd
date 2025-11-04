LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Subtractor IS
    PORT (
        Tsin1, Tsin2, Tsin3, Tsin5, Tsin6, Tsin7, Tsin8, Tsin9, Tsin10, Tsin11, Tsin12, Tsin13, Tsin17, Tsin18,
        Tsin4, Tsin14, Tsin15, Tsin16, Tsin19, Tsin20, Tsin21 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);

        Trin1, Trin2, Trin3, Trin5, Trin6, Trin7, Trin8, Trin9, Trin10, Trin11, Trin12, Trin13, Trin17, Trin18,
        Trin4, Trin14, Trin15, Trin16, Trin19, Trin20, Trin21 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        Train_class_in  : IN STD_LOGIC_VECTOR(5 DOWNTO 0);

        Distance : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	    Train_class_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
    );
END ENTITY Subtractor;

ARCHITECTURE BEHAV OF Subtractor IS

    signal T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16,
           T17, T18, T19, T20, T21 : natural;
    signal TMP : natural;

BEGIN

T1  <= abs(to_integer(unsigned(Tsin1)) - to_integer(unsigned(Trin1))); 
T2  <= abs(to_integer(unsigned(Tsin2)) - to_integer(unsigned(Trin2))); 
T3  <= abs(to_integer(unsigned(Tsin3)) - to_integer(unsigned(Trin3)));
T4  <= abs(to_integer(unsigned(Tsin4)) - to_integer(unsigned(Trin4))); 
T5  <= abs(to_integer(unsigned(Tsin5)) - to_integer(unsigned(Trin5))); 
T6  <= abs(to_integer(unsigned(Tsin6)) - to_integer(unsigned(Trin6))); 
T7  <= abs(to_integer(unsigned(Tsin7)) - to_integer(unsigned(Trin7))); 
T8  <= abs(to_integer(unsigned(Tsin8)) - to_integer(unsigned(Trin8)));
T9  <= abs(to_integer(unsigned(Tsin9)) - to_integer(unsigned(Trin9))); 
T10 <= abs(to_integer(unsigned(Tsin10)) - to_integer(unsigned(Trin10))); 
T11 <= abs(to_integer(unsigned(Tsin11)) - to_integer(unsigned(Trin11))); 
T12 <= abs(to_integer(unsigned(Tsin12)) - to_integer(unsigned(Trin12))); 
T13 <= abs(to_integer(unsigned(Tsin13)) - to_integer(unsigned(Trin13))); 
T14 <= abs(to_integer(unsigned(Tsin14)) - to_integer(unsigned(Trin14))); 
T15 <= abs(to_integer(unsigned(Tsin15)) - to_integer(unsigned(Trin15))); 
T16 <= abs(to_integer(unsigned(Tsin16)) - to_integer(unsigned(Trin16)));
T17 <= abs(to_integer(unsigned(Tsin17)) - to_integer(unsigned(Trin17))); 
T18 <= abs(to_integer(unsigned(Tsin18)) - to_integer(unsigned(Trin18))); 
T19 <= abs(to_integer(unsigned(Tsin19)) - to_integer(unsigned(Trin19))); 
T20 <= abs(to_integer(unsigned(Tsin20)) - to_integer(unsigned(Trin20))); 
T21 <= abs(to_integer(unsigned(Tsin21)) - to_integer(unsigned(Trin21)));

TMP <= T1+T2+T3+T4+T5+T6+T7+T8+T9+T10+T11+T12+T13+T14+T15+T16+T17+T18+T19+T20+T21;

Distance <= std_logic_vector(to_unsigned(TMP, Distance'length));
Train_class_out <= Train_class_in;
END ARCHITECTURE BEHAV;