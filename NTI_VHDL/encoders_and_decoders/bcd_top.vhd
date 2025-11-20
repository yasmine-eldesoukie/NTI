library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_top is
    port(
        binary: in std_logic_vector(3 downto 0);
        y : out std_logic_vector(13 downto 0)
    );
end bcd_top;

architecture structural of bcd_top is
    signal d0,d1 : std_logic_vector(3 downto 0);

    signal d : std_logic_vector(7 downto 0);
    
            component binary_to_bcd is 
            port (
                binary: in std_logic_vector(3 downto 0);
                bcd:out std_logic_vector (7 downto 0)
            );
        end component;

            component seven_seg_decoder is 
                port (
                    a: in std_logic_vector(3 downto 0);
                    y: out std_logic_vector(6 downto 0)
                );
            end component;

    begin

        d0 <= d(3 downto 0);
        d1 <= d(7 downto 4);

        seven_SEG0 : seven_seg_decoder
        port map 
        (a=> d0,
         y=> y(6 downto 0) 
        );

        seven_SEG1 : seven_seg_decoder
        port map 
        (a=> d1,
         y=> y(13 downto 7) 
        );

        decoder : binary_to_bcd
        port map
        ( binary => binary,
          bcd => d
        );
    
end architecture structural;