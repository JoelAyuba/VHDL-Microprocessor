----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.10.2025 11:31:59
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    Port (num1: in SIGNED (31 downto 0);
          num2, num3: in SIGNED (31 downto 0);
          opcode: in UNSIGNED (3 downto 0);
          result: out SIGNED (31 downto 0));
end alu;

architecture Behavioral of alu is
-- signal opcode: UNSIGNED (15 downto 12);
begin
--definition of opcodes
   WITH opcode SELECT
   result <=
   (others =>'0') when "0000",
   num1+num2     when "1010",
   num1-num2 WHEN "1000",
   num2-num1 WHEN "0110",
   num1 WHEN "1110",
   num2 WHEN "0101",
   num1 AND num2 WHEN "0010",
   num1 OR num2 WHEN "1101",
   num1 XOR num2 WHEN "1111",
   --shift right arithmetic opcode
   shift_right(num1, 1) when "1011",
   --shift right logical opcode
   SIGNED(shift_right(UNSIGNED(num1), 1)) when "0011",
   (others =>'0') when others;
   
   
end Behavioral;
