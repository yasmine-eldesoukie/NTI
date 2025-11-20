library ieee;
use ieee.std_logic_1164.all;

-- four-input nand with 2-input nands
entity nand_4 is 
    port (
        m,n,o,p: in std_logic;
        z_4_nand:out std_logic
    );

end nand_4;

architecture behavioural of nand_4 is 
    signal a,b,c,d: std_logic:= '0';
    begin
        a<= not( m and n);
        b<= not (a and a); 

        c<= not( o and p);
        d<= not (c and c); 
        z_4_nand <= not(b and d);
        
end architecture behavioural;
