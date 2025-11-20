library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

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
       for i in 0 to 15 loop
         (a_tb, b_tb, c_tb, d_tb) <= std_logic_vector(to_unsigned(i,4));
         wait for 1 ns;	
       end loop;
       wait;    
     end process;
end tb;