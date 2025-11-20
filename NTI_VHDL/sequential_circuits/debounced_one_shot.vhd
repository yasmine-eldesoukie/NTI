library ieee;
use ieee.std_logic_1164.all;

entity debounced_one_shot is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            out_bouncer: out std_logic
    );
end entity debounced_one_shot;


architecture ar1 of debounced_one_shot is
    signal edge_detect_in: std_logic;
    component edge_detector is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            pulse_out: out std_logic
    );
    end component edge_detector;

    component debouncer is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            out_bouncer: out std_logic
    );
    end component debouncer;

    begin 

    debouncer_top: debouncer
    port map (
        clk=> clk,
        clr=> clr,
        d=> d,
        out_bouncer=> edge_detect_in
    );

    edge_detector_top: edge_detector
    port map (
        clk=> clk,
        clr=> clr,
        d=> edge_detect_in,
        pulse_out=> out_bouncer
    );
    end architecture ar1;