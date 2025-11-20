library ieee;
use ieee.std_logic_1164.all;

entity gray_to_binary is 
    port (
        gray: in std_logic_vector(3 downto 0);
        binary:out std_logic_vector (3 downto 0)
    );

end gray_to_binary;

architecture gate_level of gray_to_binary is 
    begin
    binary(3)<= gray(3);
    binary(2)<= gray(3) xor gray(2);
    binary(1)<= gray(3) xor gray(2) xor gray(1);
    binary(0)<= gray(3) xor gray(2) xor gray(1) xor gray(0);
        
end architecture gate_level;

architecture dependancy of gray_to_binary is
    begin 
        process (gray)
            variable binary_dep : std_logic_vector(3 downto 0):= "0000";
            begin
            binary_dep(3):= gray(3);
            binary_dep(2):= gray(3) xor gray(2);
            binary_dep(1):= binary_dep(2) xor gray(1);
            binary_dep(0):= binary_dep(1) xor gray(0);

            binary<= binary_dep; 
        end process;
        
end architecture dependancy;