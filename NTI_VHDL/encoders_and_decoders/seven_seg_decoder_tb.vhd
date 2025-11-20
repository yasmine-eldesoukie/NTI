library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity seven_seg_decoder_tb is 

end seven_seg_decoder_tb;

architecture tb of seven_seg_decoder_tb is 
 -- Component decleration
component seven_seg_decoder is 
    port (
        a: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(6 downto 0)
    );

end component;

  signal a_tb: std_logic_vector(3 downto 0);
  signal y_dut:  STD_LOGIC_vector (6 downto 0);
begin 

  dut: seven_seg_decoder
   port map (
     a  => a_tb,
     y => y_dut
   );
   
   stimulus_process: process
   begin
         for j in 0 to 15 loop
           a_tb <= std_logic_vector(to_unsigned(j,4));
           wait for 1 ns;
         end loop;
       wait;    
   end process;
end tb;