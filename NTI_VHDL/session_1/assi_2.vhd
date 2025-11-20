library ieee;
use ieee.std_logic_1164.all;

entity assi_2 is 
    port (
        a: in std_logic_vector(3 downto 0);
        z:out std_logic_vector (5 downto 0) 
    );

end assi_2;

architecture arch_2 of assi_2 is 
    begin
        z(5) <= a(3) and  a(2) and  a(1) and  a(0);
        z(4) <= not (a(3) and  a(2) and  a(1) and  a(0));
        z(3) <= a(3) or   a(2) or   a(1) or   a(0);
        z(2) <= not (a(3) or   a(2) or   a(1) or   a(0));
        z(1) <= a(3) xor  a(2) xor  a(1) xor  a(0);
        z(0) <= not (a(3) xor  a(2) xor  a(1) xor  a(0));

end architecture arch_2;
