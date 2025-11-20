library ieee;
use ieee.std_logic_1164.all;

entity generic_register is
    generic (WIDTH : integer := 4);
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic_vector (WIDTH-1 downto 0);
            q: out std_logic_vector (WIDTH-1 downto 0)
    );
end entity generic_register;


architecture ar1 of generic_register is
    begin

    process (clk,clr)
        begin
        if clr='1' then
            q<=(others => '0');
        elsif rising_edge (clk) then
            q<=d;
        end if;
    end process;

    end architecture ar1;


