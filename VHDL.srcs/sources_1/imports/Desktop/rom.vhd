LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY rom IS
  PORT ( address1, address2, address3: IN   UNSIGNED (3 DOWNTO 0);
         data1, data2   : OUT  SIGNED (31 DOWNTO 0);
         data3 : IN SIGNED (31 DOWNTO 0);
         clk: in std_logic);
END ENTITY rom;
--Initializing data memory
ARCHITECTURE dataflow OF rom IS
  TYPE rom_array IS ARRAY ( 0 TO 15 ) OF SIGNED ( 31 DOWNTO 0 );
  SIGNAL rom_data: rom_array := ( X"00000000",  X"00000258",  X"FFFFFA24",  X"00000708",
                                  X"00000898",  X"00000960",  X"FFFFF5D8",  X"00000A8C",
                                  X"0000076C",  X"00000000",  X"00000000",  X"00000000",
                                  X"00000000",  X"00000000",  X"00000000",  X"00000000" );
BEGIN --Creating return loop for result
PROCESS(clk)
BEGIN
IF rising_edge(clk) then
rom_data( TO_INTEGER (address3))<= data3;
END IF;
END PROCESS;
--address and data ports
  data1 <= rom_data ( TO_INTEGER (address1) );
  data2 <= rom_data ( TO_INTEGER (address2) );
END ARCHITECTURE dataflow;

