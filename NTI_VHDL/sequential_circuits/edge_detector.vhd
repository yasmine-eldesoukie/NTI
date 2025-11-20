library ieee;
use ieee.std_logic_1164.all;

entity edge_detector is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            pulse_out: out std_logic
    );
end entity edge_detector;

architecture ar1 of edge_detector is
    signal pulse, d_reg: std_logic;
    begin
    process (clk,clr)
        begin
        if clr='1' then
            pulse<= '0';
        elsif rising_edge (clk) then
            d_reg<=d;
            if (pulse='1') then
                pulse<= '0';
            elsif ((d_reg='0' and d='1')) then
                pulse<= '1'; 
            end if;
        end if;
    end process;

   pulse_out<= pulse;

    end architecture ar1;