-------------------------------------------------------------------
-- Test bench file for Nexys board
-------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
  signal CLK100MHZ: std_logic:='0';
  signal BTNL, BTNR, BTNU, BTND, BTNC: std_logic;      
  signal SWITCHES:  STD_LOGIC_VECTOR (15 downto 0);  
  signal LEDS:      STD_LOGIC_VECTOR (15 downto 0); 
  signal DIGITS:    STD_LOGIC_VECTOR (7 downto 0); 
  signal SEGMENTS:  STD_LOGIC_VECTOR (7 downto 0);
 -- signal result: SIGNED (7 downto 0);
 -- signal opcode, address1, address2,address3: UNSIGNED (3 downto 0);
  --signal data1, data2,data3: SIGNED(7 downto 0);
begin

uut: entity work.micro(Behavioral) port map ( CLK100MHZ=>CLK100MHZ,
         BTNL=>BTNL, BTNR=>BTNR, BTNU=>BTNU, BTND=>BTND, BTNC=>BTNC,
         SWITCHES=>SWITCHES, LEDS=>LEDS, DIGITS=>DIGITS, SEGMENTS=>SEGMENTS); 
         

--Generating clock         
  CLK100MHZ <= not CLK100MHZ after 5 ns; 
  
  process
  begin
--    SWITCHES <= B"1010_0000_0010_0001";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50ns;
    
--    SWITCHES <= B"1010_0000_0000_0011";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50 ns;
    
--    SWITCHES <= B"1010_0000_0000_0100";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50 ns;
    
--    SWITCHES <= B"1010_0000_0000_0101";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50ns;
    
--    SWITCHES <= B"1010_0000_0000_0110";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50ns;
    
--    SWITCHES <= B"1010_0000_0000_0111";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50ns;
    
--    SWITCHES <= B"1010_0000_0000_1000";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50ns;
    
--    SWITCHES <= B"1010_0000_0000_1001";
--   BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50ns;
    
--    SWITCHES <= B"1010_0000_0000_1010";
--    BTNL <= '1';
--    wait for 50 ns;
--    BTNL <= '0';
--    wait for 50ns;
    
--    SWITCHES <= B"1010_0000_0000_1011";
--    BTNL <= '1';
--    wait for 50ns;
--    BTNL <= '0';
    
    -- giving enough time for program to complete
    wait for 120 ns;
    wait;
  end process;

end Behavioral;
