library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity debounced_one_shot_tb is 

end debounced_one_shot_tb;

architecture tb of debounced_one_shot_tb is 
 -- Component decleration
Component debounced_one_shot is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            out_bouncer: out std_logic
    );
end Component debounced_one_shot;

  signal clk_tb, clr_tb, d_tb: std_logic:= '0'; 
  signal out_bouncer_dut:  STD_LOGIC;

begin 

  dut: debounced_one_shot
   port map (
        clk=> clk_tb,
        clr=> clr_tb,
        d=> d_tb,
        out_bouncer=> out_bouncer_dut
    );

   clk_proc: process
     begin
      clk_tb<= not clk_tb;
      wait for 5 ns;   
     end process;

   clk_stop: process
     begin      
     wait for 200 ns;
       std.env.stop;
       wait;
     end process;
        

   stim_proc: process
     begin
      clr_tb<='1';
      wait for 10 ns;
      clr_tb<='0';
      wait for 10 ns; 
      
      d_tb<='0';
      wait for 10 ns;
      d_tb<='1';
      wait for 70 ns;

      d_tb<='0';
      wait for 10 ns;
      d_tb<='1';
      wait for 20 ns;
      d_tb<='0';
      wait for 10 ns;


      --wait; 
     end process;
end tb;