----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2025 12:33:01
-- Design Name: 
-- Module Name: instructions - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instructions is
    Port ( address : in UNSIGNED (4 downto 0);
           instruction : out STD_LOGIC_VECTOR (15 downto 0));
end instructions;
--Initializing instructions
architecture Behavioral of instructions is
    type memory is array (0 to 31) of std_logic_vector (15 downto 0);  
    signal rom_info : memory := ( 
    B"1010_0000_0010_0001",B"1010_0000_0000_0011",B"1010_0000_0000_0100",
    B"1010_0000_0000_0101",B"1010_0000_0000_0110",B"1010_0000_0000_0111",
    B"1010_0000_0000_1000",B"1010_0000_0000_1001",
    
    --Division by 8
    
    B"1011_0000_0000_0000",B"1011_0000_0000_0000",B"1011_0000_0000_0000",
    others => (others => '0') );
begin
--sending instructions out through the 'instruction' output bus
    instruction <= rom_info(to_integer(address));

end Behavioral;
