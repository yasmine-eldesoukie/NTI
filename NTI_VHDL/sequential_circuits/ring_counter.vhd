library ieee;
use ieee.std_logic_1164.all;

entity ring_counter is
    generic (WIDTH : integer := 4
    );
    port (
            clk:in std_logic;
            clr:in std_logic;
            q: out std_logic_vector(WIDTH-1 downto 0)
    );
end entity ring_counter;


architecture ar1 of ring_counter is
    signal q_proc: std_logic_vector(WIDTH-1 downto 0);
    begin
    process (clk,clr)
        begin
        if clr='1' then
            q_proc<=('1' & (WIDTH-2 downto 0 => '0'));
        elsif rising_edge (clk) then
            q_proc<=(q_proc(0) & q(WIDTH-1 downto 1));
        end if;
    end process;

    q<= q_proc;

    end architecture ar1;


