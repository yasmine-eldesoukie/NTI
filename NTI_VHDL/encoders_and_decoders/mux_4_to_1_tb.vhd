library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity mux_4_to_1_tb is 

end mux_4_to_1_tb;

architecture tb of mux_4_to_1_tb is 
 -- Component decleration
component mux_4_to_1 is 
    generic(WIDTH: integer := 2);
    port (
        sel:in std_logic_vector(1 downto 0);
        a,b,c,d: in std_logic_vector(WIDTH-1 downto 0);
        y: out std_logic_vector(WIDTH-1 downto 0)
    );

end component;
  constant WIDTH : integer := 2;
  signal sel_tb:  STD_LOGIC_vector(1 downto 0);

  signal a_tb,b_tb,c_tb,d_tb: std_logic_vector(WIDTH-1 downto 0);
  signal y_behav_dut, y_struct_dut, y_gate_level_dut:  STD_LOGIC_vector (WIDTH-1 downto 0);
begin 

  dut_behav: entity work.mux_4_to_1(behavioural)
   generic map (
     WIDTH => WIDTH
   )
   port map (
     sel => sel_tb,
     a  => a_tb,
     b  => b_tb,
     c  => c_tb,
     d  => d_tb,
     y => y_behav_dut
   );
   
   dut_struct: entity work.mux_4_to_1(structural)
   generic map (
     WIDTH => WIDTH
   )
   port map (
     sel => sel_tb,
     a  => a_tb,
     b  => b_tb,
     c  => c_tb,
     d  => d_tb,
     y => y_struct_dut
   );
   
   dut_gate_level: entity work.mux_4_to_1(gate_level)
   generic map (
     WIDTH => WIDTH
   )
   port map (
     sel => sel_tb,
     a  => a_tb,
     b  => b_tb,
     c  => c_tb,
     d  => d_tb,
     y => y_gate_level_dut
   );

   stimulus_process: process
   begin

       for i in 0 to 3 loop
         sel_tb <= std_logic_vector(to_unsigned(i,2)); 
         for j in 0 to 2**WIDTH-1  loop
           a_tb <= std_logic_vector(to_unsigned(j,WIDTH));
           b_tb <= std_logic_vector(to_unsigned(j+1,WIDTH)); 
           c_tb <= std_logic_vector(to_unsigned(j+2,WIDTH));
           d_tb <= std_logic_vector(to_unsigned(j+3,WIDTH));
           wait for 1 ns;
          end loop;
          wait for 1 ns;
       end loop;
       wait;    
     end process;
end tb;