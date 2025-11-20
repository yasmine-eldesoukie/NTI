library ieee;
use ieee.std_logic_1164.all;

entity gray_to_binary is 
    port (
        binary: in std_logic_vector(3 downto 0);
        gray:out std_logic_vector (3 downto 0)
    );

end gray_to_binary;

architecture gate_level of gray_to_binary is 
    begin
    gray(3)<= binary(3);
    gray(2)<= binary(3) xor binary(2);
    gray(1)<= binary(2) xor binary(1);
    gray(0)<= binary(1) xor binary(0);
        
end architecture gate_level;