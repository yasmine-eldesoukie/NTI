library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity ring_counter_tb is 

end ring_counter_tb;

architecture tb of ring_counter_tb is 

 -- Component decleration
component ring_counter
  generic (WIDTH : integer := 4);
    port (
            clk:in std_logic;
            clr:in std_logic;
            q: out std_logic_vector(WIDTH-1 downto 0)
    );
  end component;

  constant WIDTH : integer := 5;
  
  signal  clk_tb: std_logic :='0';
  signal  clr_tb: std_logic :='0';
  signal  q_dut:   std_logic_veCTOR(WIDTH-1 downto 0); 
  
begin 

  DUT: ring_counter
   generic map (WIDTH => WIDTH)
   port map (
     clk=>clk_tb,
     clr=>clr_tb,
     q => q_dut
    
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

      for i in 0 to WIDTH-1 loop
        wait for 10 ns;
      end loop;  
      --wait; 
     end process;
end tb;