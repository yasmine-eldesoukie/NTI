library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity pulse_width_modulation is 
    port (
        clk, clr: in std_logic;
        duty:in std_logic_vector(2 downto 0);
        pwm_out: out std_logic
    );

end pulse_width_modulation;

architecture arch of pulse_width_modulation is 
    signal pwm_reg, counter_done: std_logic;
    signal counter: std_logic_vector(2 downto 0);

    begin
    pwm_proc: process (clk,clr)
    begin
       if clr/='1' then
         pwm_reg<= '0';
       elsif rising_edge (clk) then
         if (counter_done='0') then
            pwm_reg<= '1';
         else 
            pwm_reg<= '0';
         end if;
        end if;
    end process;
    pwm_out<= pwm_reg;

    counter_proc: process(clk,clr)
    begin
        if clr/='1' then
            counter<= "000";
        elsif rising_edge (clk) then
            counter<= std_logic_vector(unsigned(counter)+ 1);
            if (counter= std_logic_vector(unsigned(duty)-1)) then counter<="000";
            end if;
        end if;
    end process;

        
end architecture arch;