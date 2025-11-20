library ieee;
use ieee.std_logic_1164.all;

entity assi_1 is 
    port (
        a,b: in std_logic;
        z:out std_logic_vector (5 downto 0) 
    );

end assi_1;

architecture arch_1 of assi_1 is 
    begin
        z(5) <= a and b;
        z(4) <= a nand b;
        z(3) <= a or b;
        z(2) <= a nor b;
        z(1) <= a xor b;
        z(0) <= a xnor b;

end architecture arch_1;
