LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY GSCV IS
    PORT (
        Clock, Reset : IN STD_LOGIC;
        Best_parameter : OUT NATURAL;
        Accuracy : OUT NATURAL;
        status : OUT STD_LOGIC
    );
END ENTITY GSCV;

ARCHITECTURE RTL OF GSCV IS

    COMPONENT Main_memory
        PORT (
            Clock, Reset : IN STD_LOGIC;
            Address_test, Address_train : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
            Reading : IN STD_LOGIC;
            Tsout1, Tsout2, Tsout3, Tsout5, Tsout6, Tsout7, Tsout8, Tsout9, Tsout10, Tsout11, Tsout12, Tsout13, Tsout17, Tsout18,
            Tsout4, Tsout14, Tsout15, Tsout16, Tsout19, Tsout20, Tsout21 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            Test_class : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            Trout1, Trout2, Trout3, Trout5, Trout6, Trout7, Trout8, Trout9, Trout10, Trout11, Trout12, Trout13, Trout17, Trout18,
            Trout4, Trout14, Trout15, Trout16, Trout19, Trout20, Trout21 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            Train_class : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Subtractor
        PORT (
            Tsin1, Tsin2, Tsin3, Tsin5, Tsin6, Tsin7, Tsin8, Tsin9, Tsin10, Tsin11, Tsin12, Tsin13, Tsin17, Tsin18,
            Tsin4, Tsin14, Tsin15, Tsin16, Tsin19, Tsin20, Tsin21 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            Trin1, Trin2, Trin3, Trin5, Trin6, Trin7, Trin8, Trin9, Trin10, Trin11, Trin12, Trin13, Trin17, Trin18,
            Trin4, Trin14, Trin15, Trin16, Trin19, Trin20, Trin21 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            Train_class_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            Distance : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
            Train_class_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Distance_memory
        PORT (
            Clock, Reset, forcing_reset_DM : IN STD_LOGIC;
            Distance : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            Train_class_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            Neighbour1, Neighbour2, Neighbour3, Neighbour4, Neighbour5, Neighbour6, Neighbour7, Neighbour8 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Class_detector
        PORT (
            Clock, Reset, forcing_reset_CD : IN STD_LOGIC;
            Adding, Averaging : IN STD_LOGIC;
            Test_class_in : IN STD_LOGIC;
            Neighbour1, Neighbour2, Neighbour3, Neighbour4, Neighbour5, Neighbour6, Neighbour7, Neighbour8 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            K_hyperparameter_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            hyperparameter_result : OUT NATURAL
        );
    END COMPONENT;

    COMPONENT Accuracy_memory
        PORT (
            Clock, Reset : IN STD_LOGIC;
            finishing : IN STD_LOGIC;
            K_hyperparameter_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Best_parameter : OUT NATURAL;
            hyperparameter_result : IN NATURAL;
            Accuracy : OUT NATURAL
        );
    END COMPONENT;

    COMPONENT Controller
	port (
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
    END COMPONENT;

    SIGNAL Address_test, Address_train : STD_LOGIC_VECTOR(17 DOWNTO 0);

    SIGNAL Reading, Adding, Averaging, finishing, forcing_reset_CD, forcing_reset_DM : STD_LOGIC;

    SIGNAL Test1, Test2, Test3, Test5, Test6, Test7, Test8, Test9, Test10, Test11, Test12, Test13, Test17, Test18,
    Test4, Test14, Test15, Test16, Test19, Test20, Test21 : STD_LOGIC_VECTOR(5 DOWNTO 0);

    SIGNAL Train1, Train2, Train3, Train5, Train6, Train7, Train8 : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL Train9, Train10, Train11, Train12, Train13, Train17, Train18 : STD_LOGIC_VECTOR(5 DOWNTO 0); 
    SIGNAL Train4, Train14, Train15, Train16, Train19, Train20, Train21 : STD_LOGIC_VECTOR(5 DOWNTO 0);

    SIGNAL Test_class_from_MM, Train_class_from_MM, Train_class_from_SB : STD_LOGIC_VECTOR(5 DOWNTO 0);

    SIGNAL Test_class_from_CT : STD_LOGIC;

    SIGNAL Distance : STD_LOGIC_VECTOR(9 DOWNTO 0);

    SIGNAL Neighbour1, Neighbour2, Neighbour3, Neighbour4, Neighbour5, Neighbour6, Neighbour7, Neighbour8 : STD_LOGIC_VECTOR(1 DOWNTO 0);

    signal Kresult_from_CD: NATURAL;

    signal KHP_from_CT : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

    MM : Main_memory PORT MAP
    (
        Clock => Clock,
        Reset => Reset,
        Address_test => Address_test,
        Address_train => Address_train,
        Reading => Reading,
        Tsout1 => Test1,
        Tsout2 => Test2,
        Tsout3 => Test3,
        Tsout4 => Test4,
        Tsout5 => Test5,
        Tsout6 => Test6,
        Tsout7 => Test7,
        Tsout8 => Test8,
        Tsout9 => Test9,
        Tsout10 => Test10,
        Tsout11 => Test11,
        Tsout12 => Test12,
        Tsout13 => Test13,
        Tsout14 => Test14,
        Tsout15 => Test15,
        Tsout16 => Test16,
        Tsout17 => Test17,
        Tsout18 => Test18,
        Tsout19 => Test19,
        Tsout20 => Test20,
        Tsout21 => Test21,
        Test_class => Test_class_from_MM,
        Trout1 => Train1,
        Trout2 => Train2,
        Trout3 => Train3,
        Trout4 => Train4,
        Trout5 => Train5,
        Trout6 => Train6,
        Trout7 => Train7,
        Trout8 => Train8,
        Trout9 => Train9,
        Trout10 => Train10,
        Trout11 => Train11,
        Trout12 => Train12,
        Trout13 => Train13,
        Trout14 => Train14,
        Trout15 => Train15,
        Trout16 => Train16,
        Trout17 => Train17,
        Trout18 => Train18,
        Trout19 => Train19,
        Trout20 => Train20,
        Trout21 => Train21,
        Train_class => Train_class_from_MM
    );

    SB : Subtractor PORT MAP
    (
        Tsin1 => Test1,
        Tsin2 => Test2,
        Tsin3 => Test3,
        Tsin4 => Test4,
        Tsin5 => Test5,
        Tsin6 => Test6,
        Tsin7 => Test7,
        Tsin8 => Test8,
        Tsin9 => Test9,
        Tsin10 => Test10,
        Tsin11 => Test11,
        Tsin12 => Test12,
        Tsin13 => Test13,
        Tsin14 => Test14,
        Tsin15 => Test15,
        Tsin16 => Test16,
        Tsin17 => Test17,
        Tsin18 => Test18,
        Tsin19 => Test19,
        Tsin20 => Test20,
        Tsin21 => Test21,
        Trin1 => Train1,
        Trin2 => Train2,
        Trin3 => Train3,
        Trin4 => Train4,
        Trin5 => Train5,
        Trin6 => Train6,
        Trin7 => Train7,
        Trin8 => Train8,
        Trin9 => Train9,
        Trin10 => Train10,
        Trin11 => Train11,
        Trin12 => Train12,
        Trin13 => Train13,
        Trin14 => Train14,
        Trin15 => Train15,
        Trin16 => Train16,
        Trin17 => Train17,
        Trin18 => Train18,
        Trin19 => Train19,
        Trin20 => Train20,
        Trin21 => Train21,
        Train_class_in => Train_class_from_MM,
        Train_class_out => Train_class_from_SB,
        Distance => Distance
    );

    DM : Distance_memory PORT MAP
    (
        Clock => Clock,
        Reset => Reset,
        forcing_reset_DM => forcing_reset_DM,
        Distance => Distance,
        Train_class_in => Train_class_from_SB,
        Neighbour1 => Neighbour1,
        Neighbour2 => Neighbour2,
        Neighbour3 => Neighbour3,
        Neighbour4 => Neighbour4,
        Neighbour5 => Neighbour5,
        Neighbour6 => Neighbour6,
        Neighbour7 => Neighbour7,
        Neighbour8 => Neighbour8
    );

    CD : Class_detector PORT MAP
    (
        Clock => Clock,
        Reset => Reset,
        forcing_reset_CD => forcing_reset_CD,
        Adding => Adding,
        Averaging => Averaging,
        Test_class_in => Test_class_from_CT,
        Neighbour1 => Neighbour1,
        Neighbour2 => Neighbour2,
        Neighbour3 => Neighbour3,
        Neighbour4 => Neighbour4,
        Neighbour5 => Neighbour5,
        Neighbour6 => Neighbour6,
        Neighbour7 => Neighbour7,
        Neighbour8 => Neighbour8,
        K_hyperparameter_in => KHP_from_CT,
        hyperparameter_result => Kresult_from_CD
    );

    AM: Accuracy_memory PORT MAP
    (
        Clock => Clock,
        Reset => Reset,
        finishing => finishing,
        K_hyperparameter_in => KHP_from_CT,
        hyperparameter_result => Kresult_from_CD,
        Best_parameter => Best_parameter,
        Accuracy => Accuracy
    );

    CT: Controller PORT MAP
    (
        Clock => Clock,
        Reset => Reset,
        forcing_reset_CD => forcing_reset_CD,
        forcing_reset_DM => forcing_reset_DM,
        Test_clas_in => Test_class_from_MM,
        Test_clas_out => Test_class_from_CT,
        K_hyperparameter_out => KHP_from_CT,
        Address_test => Address_test,
        Address_train => Address_train,
        Reading => Reading,
        Adding  => Adding, 
        Averaging => Averaging,
        Finishing => Finishing
    );

status <= Finishing;

END ARCHITECTURE RTL;
