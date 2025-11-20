library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector_tb is 

end edge_detector_tb;

architecture tb of edge_detector_tb is 

 -- Component decleration
Component edge_detector is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            pulse_out: out std_logic
    );
end Component edge_detector;
  
  signal  clk_tb: std_logic :='0';
  signal  clr_tb: std_logic :='0';
  signal  d_tb:   std_logic :='0'; 
  signal  pulse_out_dut: std_logic;
  
begin 

  DUT: edge_detector
   generic map (WIDTH => WIDTH)
   port map (
     clk=>clk_tb,
     clr=>clr_tb,
     d => d_tb,
     pulse_out => pulse_out_dut
    
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
      wait for 30 ns;

      d_tb<='0';
      wait for 10 ns;
      d_tb<='1';
      wait for 50 ns;


      --wait; 
     end process;
end tb;