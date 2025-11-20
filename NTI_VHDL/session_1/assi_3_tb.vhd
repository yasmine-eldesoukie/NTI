library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity assi_3_tb is 

end assi_3_tb;

architecture tb of assi_3_tb is 
 -- Component decleration
component assi_3 
  port(
    a,b,c,d: in std_logic;
    z:out std_logic
  );
  end component;
  
  signal a_tb, b_tb, d_tb, c_tb:  STD_LOGIC := '0';
  signal Z_dut:  STD_LOGIC;
begin 

  dut: assi_3 
   port map (
     a => a_tb,
     b => b_tb,
     c => c_tb,
     d => d_tb,
     z => z_dut
   );
   
   stimulus_process: process
     begin
       a_tb <= '0';
       b_tb <= '0';
       c_tb <= '0';
       d_tb <= '0';
       wait for 1 ns;	   
       
       a_tb <= '0';
       b_tb <= '0';
       c_tb <= '0';
       d_tb <= '1';
       wait for 1 ns;	 

       a_tb <= '0';
       b_tb <= '1';
       c_tb <= '0';
       d_tb <= '0';
       wait for 1 ns;	

       a_tb <= '0';
       b_tb <= '0';
       c_tb <= '1';
       d_tb <= '1';
       wait for 1 ns;	
       ---------------

       a_tb <= '0';
       b_tb <= '1';
       c_tb <= '0';
       d_tb <= '0';
       wait for 1 ns;	   
       
       a_tb <= '0';
       b_tb <= '1';
       c_tb <= '0';
       d_tb <= '1';
       wait for 1 ns;	 

       a_tb <= '0';
       b_tb <= '1';
       c_tb <= '1';
       d_tb <= '0';
       wait for 1 ns;	

       a_tb <= '0';
       b_tb <= '1';
       c_tb <= '1';
       d_tb <= '1';
       wait for 1 ns;	

       a_tb <= '0';
       b_tb <= '0';
       c_tb <= '0';
       d_tb <= '1';
       wait for 1 ns;	   
       
       a_tb <= '1';
       b_tb <= '0';
       c_tb <= '0';
       d_tb <= '1';
       wait for 1 ns;	 

       a_tb <= '1';
       b_tb <= '0';
       c_tb <= '1';
       d_tb <= '0';
       wait for 1 ns;	

       a_tb <= '1';
       b_tb <= '0';
       c_tb <= '1';
       d_tb <= '1';
       wait for 1 ns;	

       a_tb <= '1';
       b_tb <= '1';
       c_tb <= '0';
       d_tb <= '0';
       wait for 1 ns;	   
       
       a_tb <= '1';
       b_tb <= '1';
       c_tb <= '0';
       d_tb <= '1';
       wait for 1 ns;	 

       a_tb <= '1';
       b_tb <= '1';
       c_tb <= '1';
       d_tb <= '0';
       wait for 1 ns;	

       a_tb <= '1';
       b_tb <= '1';
       c_tb <= '1';
       d_tb <= '1';
       wait for 1 ns;	
       wait;    
     end process;
end tb;