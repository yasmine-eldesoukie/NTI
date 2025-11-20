library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity decoder_2_to_4 is 
    port (
        en:in std_logic;
        a: in std_logic_vector(1 downto 0);
        y: out std_logic_vector(3 downto 0)
    );

end decoder_2_to_4;

architecture behavioural of decoder_2_to_4 is 
    begin
    process (en, a)
        begin
            if (en='1') then 
                if (a="00") then 
                    y <= "0001";
                elsif (a="01") then 
                    y <= "0010";
                elsif (a="10") then 
                    y <= "0100";
                else
                    y <= "1000";
                end if;
            else
                y <= "0000";
            end if;
    end process;

end architecture behavioural;