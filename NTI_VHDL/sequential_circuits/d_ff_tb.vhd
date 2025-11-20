library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity seg_tb is 

end seg_tb;

architecture tb of seg_tb is 

 -- Component decleration
component d_ff
  port(
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic_vector (3 downto 0);
            q: out std_logic_vector (3 downto 0)
  );
  end component;
  
  signal  clk_tb: std_logic :='0';
  signal  clr_tb: std_logic :='0';
  signal  d_tb:   STD_LOGIC_vector (3 downto 0) := "0000";
  signal  q_tb:   std_logic_vector (3 downto 0); 
  
begin 

  DUT: d_ff
   port map (
     clk=>clk_tb,
     clr=>clr_tb,
     d => d_tb,
     q => q_tb
    
   );

clk_proc: process
     begin
      clk_tb<= not clk_tb;
      wait for 5 ns;   
     end process;

clk_stop: process
     begin      
     wait for 300 ns;
       std.env.stop;
       wait;
     end process;
        

   stim_proc: process
     begin
      clr_tb<='1';
      wait for 10 ns;
      clr_tb<='0';
      wait for 10 ns;

      for i in 0 to 15 loop
       d_tb<= std_logic_vector (to_unsigned(i,4)); 
       wait for 10 ns;
       end loop;  
       --wait; 
     end process;
end tb;