library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    generic (WIDTH : integer := 4);
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            q_out: out std_logic
    );
end entity shift_register;


architecture ar1 of shift_register is
    signal q: std_logic_vector(WIDTH-1 downto 0);
    begin
    process (clk,clr)
        begin
        if clr='1' then
            q<=(others => '0');
        elsif rising_edge (clk) then
            q<=(d & q(WIDTH-1 downto 1));
        end if;
    end process;

    q_out<= q(0);

    end architecture ar1;


