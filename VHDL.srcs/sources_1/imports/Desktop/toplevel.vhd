-------------------------------------------------------------------
-- Joel Ayuba
-- Design file for first lab
-------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity micro is
  Port ( CLK100MHZ: in std_logic;
         BTNL, BTNR, BTNU, BTND, BTNC: in std_logic;     --Push buttons
          SWITCHES:  in STD_LOGIC_VECTOR (15 downto 0);  --Slider switches
              LEDS:  out STD_LOGIC_VECTOR (15 downto 0); --LEDs
            DIGITS:  out STD_LOGIC_VECTOR (7 downto 0);  --7seg display
          SEGMENTS:  out STD_LOGIC_VECTOR (7 downto 0)); --7seg display 
end micro;


architecture Behavioral of micro is
  --signal num1, num2, result: SIGNED (3 downto 0);
  signal result: SIGNED (31 downto 0);
  signal opcode, address1, address2,address3: UNSIGNED (3 downto 0);
  signal display: std_logic_vector(31 downto 0):=X"01234567";
  signal data1, data2,data3: SIGNED(31 downto 0);
  --instruction handling
  signal present_instruction : std_logic_vector (15 downto 0);
  signal program : UNSIGNED (4 downto 0) := (others => '0');
begin
--setting up program counter
   process(CLK100MHZ)
   begin
      if rising_edge (CLK100MHZ) then
       
             program <= program + 1;        
          
      end if;
   end process;
  --Instantiation of new instruction entity 
   my_instrictions: entity work.instructions(Behavioral) port map(address => program, instruction => present_instruction);

   
   --assigning instructions to variables
   opcode <= UNSIGNED(present_instruction(15 downto 12));
   
   address1 <= UNSIGNED(present_instruction(7 downto 4));
   address2 <= UNSIGNED(present_instruction(3 downto 0));
   address3 <= UNSIGNED(present_instruction(11 downto 8));
 --instatiation of the alu
   my_alu: entity work.alu(Behavioral) port map(num1=>data1,num2=>data2,num3=>data3,opcode=>opcode,result=>result);
   
   --display settings
  --display(31 downto 28) <= "0000";
   display(31 downto 0) <= std_logic_vector(result(31 downto 0));
   --display(23 downto 20) <= std_logic_vector(result(3 downto 0));
   --display(19 downto 16) <= std_logic_vector(result(3 downto 0));
   --display(15 downto 12) <= std_logic_vector(data2(7 downto 4));
   --display(11 downto 8) <= std_logic_vector(data2(3 downto 0));
   --display(7 downto 4) <= std_logic_vector(data1(7 downto 4));
   --display(3 downto 0) <= std_logic_vector(data1(3 downto 0));
   --instantiation of the drive display
   my_drive_display: entity work.drive_display(Behavioral) port map(CLK100MHZ=>CLK100MHZ, segments=>segments, digits=>digits,display=>display);
   --instantiation of the rom entity
   my_rom: entity work.rom(dataflow) port map(clk=>CLK100MHZ, address1=>address1, data1=>data1, address2=>address2, data2=>data2, address3=>address3, data3=>result);

-- Send the result onto the LEDs so that we can see them
  LEDS(3 downto 0) <= std_logic_vector(address2);
  LEDS(7 downto 4) <= std_logic_vector(address1);

 
end Behavioral;
