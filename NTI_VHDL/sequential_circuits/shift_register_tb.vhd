library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_tb is 

end shift_register_tb;

architecture tb of shift_register_tb is 

 -- Component decleration
component shift_register
  generic (WIDTH : integer := 4);
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            q_out: out std_logic
    );
  end component;

  constant WIDTH : integer := 5;
  
  signal  clk_tb: std_logic :='0';
  signal  clr_tb: std_logic :='0';
  signal  d_tb:   STD_LOGIC;
  signal  q_out_tb:   std_logic; 
  
begin 

  DUT: shift_register
   generic map (WIDTH => WIDTH)
   port map (
     clk=>clk_tb,
     clr=>clr_tb,
     d => d_tb,
     q_out => q_out_tb
    
   );

clk_proc: process
     begin
      clk_tb<= not clk_tb;
      wait for 5 ns;   
     end process;

clk_stop: process
     begin      
     wait for 100000 ns;
       std.env.stop;
       wait;
     end process;
        

   stim_proc: process
    variable data_reg : std_logic_vector(WIDTH-1 downto 0);
     begin
      clr_tb<='1';
      wait for 10 ns;
      clr_tb<='0';
      wait for 10 ns;

      for i in 0 to 2**WIDTH-1 loop
        data_reg := std_logic_vector (to_unsigned(i,WIDTH));
        for j in 0 to WIDTH-1 loop
            wait for 5 ns;
            d_tb<= data_reg(j); 
            wait for 5 ns;
        end loop;
      end loop;  
       --wait; 
     end process;
end tb;