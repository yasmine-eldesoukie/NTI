library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity mux_4_to_1 is 
    generic(WIDTH: integer := 2);
    port (
        sel:in std_logic_vector(1 downto 0);
        a,b,c,d: in std_logic_vector(WIDTH-1 downto 0);
        y: out std_logic_vector(WIDTH-1 downto 0)
    );

end mux_4_to_1;

architecture behavioural of mux_4_to_1 is 
    begin
    process (sel, a,b,c,d)
        begin
            case sel is 
                when "00" =>
                    y<= a;
                 when "01" =>
                    y<= b;
                 when "10" =>
                    y<= c;
                 when "11" =>
                    y<= d;
                 when others => 
                    y<= a;
                 end case;
    end process;

    end architecture behavioural;

architecture gate_level of mux_4_to_1 is
    signal term_1, term_2, term_3, term_4: std_logic_vector(WIDTH-1 downto 0);
    begin
        term_1<= (not(WIDTH-1 downto 0 => sel(0)) and not(WIDTH-1 downto 0 => sel(1)) and a); 
        term_2<= (   (WIDTH-1 downto 0 => sel(0)) and not(WIDTH-1 downto 0 => sel(1)) and b);
        term_3<= (not(WIDTH-1 downto 0 => sel(0)) and    (WIDTH-1 downto 0 => sel(1)) and c);
        term_4<= (   (WIDTH-1 downto 0 => sel(0)) and    (WIDTH-1 downto 0 => sel(1)) and d);
        y<=      (term_1 or term_2 or term_3 or term_4);

    end architecture gate_level;

architecture structural of mux_4_to_1 is 
    component mux_2_to_1 is 
    generic(WIDTH: integer := 2);
    port (
        sel:in std_logic;
        a,b: in std_logic_vector(WIDTH-1 downto 0);
        y: out std_logic_vector(WIDTH-1 downto 0)
    );

end component;  

    signal mux_1_out, mux_2_out: std_logic_vector(WIDTH-1 downto 0);
    begin
       mux_1: mux_2_to_1 
         port map (
            sel=> sel(0),
            a=> a,
            b=> b,
            y=> mux_1_out
         );

       mux_2: mux_2_to_1 
         port map (
            sel=> sel(0),
            a=> c,
            b=> d,
            y=> mux_2_out
         );

       mux_3: mux_2_to_1 
         port map (
            sel=> sel(1),
            a=> mux_1_out,
            b=> mux_2_out,
            y=> y
         );
    end architecture structural;

