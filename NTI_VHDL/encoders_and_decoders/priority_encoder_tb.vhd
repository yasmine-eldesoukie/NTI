library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity priority_encoder_tb is 

end priority_encoder_tb;

architecture tb of priority_encoder_tb is 
 -- Component decleration
component priority_encoder is 
    port (
        x: in std_logic_vector(3 downto 0);
        p_code:out std_logic_vector (2 downto 0)
    );

end component;
  
  signal x_tb:  STD_LOGIC_vector(3 downto 0) := "0000";
  signal p_code_dut:  STD_LOGIC_vector (2 downto 0);
begin 

  dut: priority_encoder
   port map (
     x => x_tb,
     p_code => p_code_dut
   );
   
   stimulus_process: process
     begin
       for i in 0 to 15 loop
         x_tb <= std_logic_vector(to_unsigned(i,4));
         wait for 1 ns;
       end loop;
       wait;    
     end process;
end tb;