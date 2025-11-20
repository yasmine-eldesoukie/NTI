library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity assi_1_tb is 

end assi_1_tb;

architecture tb of assi_1_tb is 
 -- Component decleration
component assi_1 
  port(
    a: in STD_LOGIC;
    b: in STD_LOGIC;
    Z: out STD_LOGIC_VECTOR(5 downto 0)
  );
  end component;
  
  signal a_tb:  STD_LOGIC := '0';
  signal b_tb:  STD_LOGIC := '0';
  signal Z_dut:  STD_LOGIC_VECTOR(5 downto 0);
begin 

  dut: assi_1 
   port map (
     a => a_tb,
     b => b_tb,
     z => z_dut
   );
   
   stimulus_process: process
     begin
       a_tb <= '0';  b_tb <= '1';
       wait for 10 ns;	   
       
       a_tb <= '1';  b_tb <= '1';
       wait for 10 ns;	 

       a_tb <= '0';  b_tb <= '0';
       wait for 10 ns;	    
     end process;
end tb;