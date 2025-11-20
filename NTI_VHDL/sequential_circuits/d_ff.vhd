library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
    port (
            clk:in std_logic;
            clr:in std_logic;
            d: in std_logic;
            q: out std_logic
    );
end entity d_ff;


architecture ar1 of d_ff is
begin

process (clk,clr)
begin
if clr='1' then
    q<='0';
elsif rising_edge (clk) then
    q<=d;
end if;
end process;

end architecture ar1;


