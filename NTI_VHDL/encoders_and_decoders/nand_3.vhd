library ieee;
use ieee.std_logic_1164.all;

-- three-input nand with 2-input nands
entity nand_3 is 
    port (
        w,x,y: in std_logic;
        z_3_nand:out std_logic
    );

end nand_3;

architecture behavioural of nand_3 is 
    signal a,b: std_logic;
    begin
        a<= not( w and x);
        b<= not (a and a); 
        z_3_nand <= not(b and y);
        
end architecture behavioural;
