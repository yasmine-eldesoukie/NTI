library ieee;
use ieee.std_logic_1164.all;

entity debouncer is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            out_bouncer: out std_logic
    );
end entity debouncer;

architecture ar1 of debouncer is
    signal delay_1, delay_2, delay_3: std_logic;
    begin
    process (clk,clr)
        begin
        if clr='1' then
            delay_1<='0';
            delay_2<='0';
            delay_3<='0';
        elsif rising_edge (clk) then
            delay_1<=d;
            delay_2<=delay_1;
            delay_3<=delay_2;
        end if;
    end process;

   out_bouncer<= (delay_1 and delay_2 and delay_3);

    end architecture ar1;