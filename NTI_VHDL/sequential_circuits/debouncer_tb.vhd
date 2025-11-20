library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer_tb is 

end debouncer_tb;

architecture tb of debouncer_tb is 

 -- Component decleration
Component debouncer is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            out_bouncer: out std_logic
    );
end Component debouncer;

  constant WIDTH : integer := 5;
  
  signal  clk_tb: std_logic :='0';
  signal  clr_tb: std_logic :='0';
  signal  d_tb:   std_logic :='0'; 
  signal  out_bouncer_dut: std_logic;
  
begin 

  DUT: debouncer
   generic map (WIDTH => WIDTH)
   port map (
     clk=>clk_tb,
     clr=>clr_tb,
     d => d_tb,
     out_bouncer => out_bouncer_dut
    
   );

clk_proc: process
     begin
      clk_tb<= not clk_tb;
      wait for 5 ns;   
     end process;

clk_stop: process
     begin      
     wait for 1000 ns;
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
      wait for 30 ns;

      d_tb<='0';
      wait for 10 ns;
      d_tb<='1';
      wait for 20 ns;
      d_tb<='0';
      wait for 10 ns;

      d_tb<='1';
      wait for 20 ns;
      d_tb<='0';
      wait for 20 ns;

      --wait; 
     end process;
end tb;