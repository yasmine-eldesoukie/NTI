library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity seven_seg_decoder is 
    port (
        a: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(6 downto 0)
    );

end seven_seg_decoder;