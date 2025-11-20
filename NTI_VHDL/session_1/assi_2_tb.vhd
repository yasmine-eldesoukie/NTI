library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity assi_2_tb is 

end assi_2_tb;

architecture tb of assi_2_tb is 
 -- Component decleration
component assi_2 
  port(
    a: in STD_LOGIC_VECTOR(3 downto 0);
    Z: out STD_LOGIC_VECTOR(5 downto 0)
  );
  end component;
  
  signal a_tb:  STD_LOGIC_VECTOR(3 downto 0) := "0000";
  signal Z_dut:  STD_LOGIC_VECTOR(5 downto 0);
begin 

  dut: assi_2 
   port map (
     a => a_tb,
     z => z_dut
   );
   
   stimulus_process: process
     begin
       a_tb <= "0000";
       wait for 10 ns;	   
       
       a_tb <= "1110";
       wait for 10 ns;	 

       a_tb <= "0110";
       wait for 10 ns;	

       a_tb <= "0010";
       wait for 10 ns;	

       a_tb <= "1111";
       wait for 10 ns;	
       wait;    
     end process;
end tb;