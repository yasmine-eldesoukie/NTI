library ieee;
use ieee.std_logic_1164.all;

entity binary_to_bcd is 
    port (
        binary: in std_logic_vector(3 downto 0);
        bcd:out std_logic_vector (7 downto 0)
    );

end binary_to_bcd;



architecture rtl of binary_to_bcd is
    begin 
    process (binary)
        begin
            case binary is 
                when  x"0"  =>bcd<= "00000000";
                when  x"1"  =>bcd<= "00000001";
                when  x"2"   =>bcd<="00000010";
                when  x"3"  =>bcd<= "00000011";

                when  x"4"   =>bcd<= "00000100";
                when  x"5"   =>bcd<= "00000101";
                when  x"6"   =>bcd<= "00000110";
                when  x"7"   =>bcd<= "00000111";

                when  x"8"   =>bcd<= "00001000";
                when  x"9"   =>bcd<= "00001001";
                when  x"a"   =>bcd<= "00010000";
                when  x"b"   =>bcd<= "00010001";

                when  x"c"   =>bcd<= "00010010";
                when  x"d"   =>bcd<= "00010011";
                when  x"e"   =>bcd<= "00010100";
                when  x"f"   =>bcd<= "00010101";

                when  others =>bcd<= "00000000";

            end case;
    end process;
        
end architecture rtl;