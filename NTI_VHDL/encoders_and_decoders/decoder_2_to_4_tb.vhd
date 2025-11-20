library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity decoder_2_to_4_tb is 

end decoder_2_to_4_tb;

architecture tb of decoder_2_to_4_tb is 
 -- Component decleration
Component decoder_2_to_4 is 
    port (
        en:in std_logic;
        a: in std_logic_vector(1 downto 0);
        y: out std_logic_vector(3 downto 0)
    );
end Component;
  
  signal en_tb:  STD_LOGIC := '0';

  signal a_tb: std_logic_vector(1 downto 0);
  signal y_dut:  STD_LOGIC_vector (3 downto 0);
begin 

  dut: decoder_2_to_4
   port map (
     en => en_tb,
     a  => a_tb,
     y => y_dut
   );
   
   stimulus_process: process
   -- when en_2_tb is decalred as a variable its value updates in the same run, however when declared as a signal, its value updtaes in the next run, any dependant signal takes its prevbious value
    variable en_2_tb : std_logic_vector(1 downto 0) := "00"; 
   begin

       for i in 0 to 1 loop
        -- create a 2-bit variable to save i value, 2 bits instaed of 1 because for some reason it doesn't accept the 1
         en_2_tb := std_logic_vector(to_unsigned(i,2)); 
        -- assign the first bit of that signal to the en_tb 
         en_tb<= en_2_tb(0);
         for j in 0 to 3 loop
           a_tb <= std_logic_vector(to_unsigned(j,2));
           wait for 1 ns;
          end loop;
          wait for 1 ns;
       end loop;
       wait;    
     end process;
end tb;