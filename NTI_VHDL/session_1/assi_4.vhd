library ieee;
use ieee.std_logic_1164.all;

entity assi_4 is 
    port (
        a,b,c,d: in std_logic;
        z:out std_logic
    );

end assi_4;

-- architecture arch_4 of assi_4 is 
--     begin
--         z <= (a and b and c) or (a and b and d) or (d and b and c) or (a and d and c);
        
-- end architecture arch_4;

architecture structural of assi_4 is 
    component nand_3 is 
        port (
            w,x,y: in std_logic;
            z_3_nand:out std_logic
        );

    end component;

    -- four-input nand with 2-input nands
    component nand_4 is 
        port (
            m,n,o,p: in std_logic;
            z_4_nand:out std_logic
        );

    end component;

    signal term_1, term_2, term_3, term_4: std_logic;

    begin
        nand_3_1: nand_3
        port map(
            w=> a,
            x=> b,
            y=> c,
            z_3_nand=> term_1
        );
        
        nand_3_2: nand_3
        port map(
            w=> a,
            x=> b,
            y=> d,
            z_3_nand=> term_2
        );

        nand_3_3: nand_3
        port map(
            w=> a,
            x=> d,
            y=> c,
            z_3_nand=> term_3
        );

        nand_3_4: nand_3
        port map(
            w=> d,
            x=> b,
            y=> c,
            z_3_nand=> term_4
        );

        nand_4_1: nand_4
        port map(
            m=> term_1,
            n=> term_2,
            o=> term_3,
            p=> term_4,
            z_4_nand=> z
        );
        
end architecture structural;
