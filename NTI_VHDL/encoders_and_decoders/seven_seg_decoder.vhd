library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity seven_seg_decoder is 
    port (
        a: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(6 downto 0)
    );

end seven_seg_decoder;

architecture behavioural of seven_seg_decoder is 
    begin
    process (a)
        begin
            case a is 
                when  x"0"  =>y<= "0000001";
                when  x"1"  =>y<= "1001111";
                when  x"2"   =>y<= "0010010";
                when  x"3"  =>y<= "0000110";

                when  x"4"   =>y<= "1001100";
                when  x"5"   =>y<= "0100100";
                when  x"6"   =>y<= "0100000";
                when  x"7"  =>y<= "0001111";

                when  x"8"   =>y<= "0000000";
                when  x"9"   =>y<= "0000100";
                when  x"a"  =>y<= "0001000";
                when  x"b"  =>y<= "1100000";

                when  x"c"  =>y<= "0110001";
                when  x"d"  =>y<= "1000010";
                when  x"e"  =>y<= "0110000";
                when  x"f"  =>y<= "0111000";

                when  others =>y<= "0000000";

            end case;
    end process;

end architecture behavioural;