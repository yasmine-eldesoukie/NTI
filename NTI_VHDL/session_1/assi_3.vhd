library ieee;
use ieee.std_logic_1164.all;

entity assi_3 is 
    port (
        a,b,c,d: in std_logic;
        z:out std_logic
    );

end assi_3;

architecture arch_3 of assi_3 is 
    begin
        z <= (a and b and c) or (a and b and d) or (d and b and c) or (a and d and c);
        
end architecture arch_3;
