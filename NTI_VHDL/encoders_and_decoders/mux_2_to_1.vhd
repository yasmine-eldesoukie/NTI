library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity mux_2_to_1 is 
    generic(WIDTH: integer := 2);
    port (
        sel:in std_logic;
        a,b: in std_logic_vector(WIDTH-1 downto 0);
        y: out std_logic_vector(WIDTH-1 downto 0)
    );

end mux_2_to_1;

architecture behavioural of mux_2_to_1 is 
    begin
    process (sel,a,b)
        begin
            case sel is 
                when '0' =>
                    y<= a;
                when '1' =>
                    y<= b;
                when others => 
                    y<= a;
                 end case;
    end process;

    end architecture behavioural;
