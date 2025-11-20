library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_register_tb is 

end generic_register_tb;

architecture tb of generic_register_tb is 

 -- Component decleration
component generic_register
  generic (WIDTH : integer := 4);
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic_vector (WIDTH-1 downto 0);
            q: out std_logic_vector (WIDTH-1 downto 0)
    );
  end component;

  constant WIDTH_tb : integer := 2;
  
  signal  clk_tb: std_logic :='0';
  signal  clr_tb: std_logic :='0';
  signal  d_tb:   STD_LOGIC_vector (WIDTH_tb-1 downto 0);
  signal  q_tb:   std_logic_vector (WIDTH_tb-1 downto 0); 
  
begin 

  DUT: generic_register
   generic map (WIDTH => WIDTH_tb)
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
        wait for 5 ns;
        d_tb<= std_logic_vector (to_unsigned(i,WIDTH_tb)); 
       wait for 5 ns;
       end loop;  
       --wait; 
     end process;
end tb;