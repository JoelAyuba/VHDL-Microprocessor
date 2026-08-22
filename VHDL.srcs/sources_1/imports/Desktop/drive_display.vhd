----------------------------------------------------------------------------------
-- Driver for 7 segment display
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity drive_display is
    Port ( CLK100MHZ: in std_logic;
            display : in STD_LOGIC_VECTOR (31 downto 0);
           DIGITS   : out STD_LOGIC_VECTOR (7 downto 0);
           SEGMENTS : out STD_LOGIC_VECTOR (7 downto 0));
end drive_display;

architecture Behavioral of drive_display is
  TYPE my_states IS (s0, s1, s2, s3,s4, s5, s6, s7 );
  SIGNAL state: my_states:=s0;
  signal slice: std_logic_vector(3 downto 0);
  SIGNAL count: unsigned(19 downto 0):=(OTHERS=>'0') ;
  signal switch_digit: std_logic;
  signal digit_period: unsigned(19 downto 0):=X"186A0";  -- How many clock cycles before we switch digit? 100,000 = 1ms
begin 

  -- Display one hex digit for 1 ms, then move to next digit
  process(CLK100MHZ)
  begin
    if rising_edge(CLK100MHZ) then
      count <= count + 1 ;          -- Increment the timer
      IF count >= digit_period THEN  -- Time to switch to a different digit
        count <= (others => '0') ;  -- Reset the timer
        switch_digit <= '1';
      ELSE
         switch_digit <='0';
      end if;
    end if;
  end process;
  
  PROCESS (CLK100MHZ)
  BEGIN
    IF (rising_edge(CLK100MHZ) ) THEN       
      CASE state IS
        WHEN s0 => IF switch_digit='1' THEN state <= s1; 
                                       ELSE state <= s0; END IF;
        WHEN s1 => IF switch_digit='1' THEN state <= s2; 
                                       ELSE state <= s1; END IF; 
        WHEN s2 => IF switch_digit='1' THEN state <= s3; 
                                       ELSE state <= s2; END IF; 
        WHEN s3 => IF switch_digit='1' THEN state <= s4; 
                                       ELSE state <= s3; END IF; 
        WHEN s4 => IF switch_digit='1' THEN state <= s5; 
                                       ELSE state <= s4; END IF;
        WHEN s5 => IF switch_digit='1' THEN state <= s6; 
                                       ELSE state <= s5; END IF; 
        WHEN s6 => IF switch_digit='1' THEN state <= s7; 
                                       ELSE state <= s6; END IF; 
        WHEN s7 => IF switch_digit='1' THEN state <= s0; 
                                       ELSE state <= s7; END IF; 
      END CASE;
    END IF;
  END PROCESS;

  process(state)
  begin
    case state is 
          when s0 => DIGITS<="11111110"; slice<=display(3 downto 0);  
          when s1 => DIGITS<="11111101"; slice<=display(7 downto 4);
          when s2 => DIGITS<="11111011"; slice<=display(11 downto 8);
          when s3 => DIGITS<="11110111"; slice<=display(15 downto 12);
          when s4 => DIGITS<="11101111"; slice<=display(19 downto 16);
          when s5 => DIGITS<="11011111"; slice<=display(23 downto 20);
          when s6 => DIGITS<="10111111"; slice<=display(27 downto 24);
          when others => DIGITS<="01111111"; slice<=display(31 downto 28);
        end case;
  end process;

-- Convert hex digit to 7 segments
  WITH slice SELECT  
  segments <= "11000000" WHEN "0000",        --0
              "11111001" WHEN "0001",        --1
              "10100100" WHEN "0010",        --2
              "10110000" WHEN "0011",        --3
              "10011001" WHEN "0100",        --4
              "10010010" when "0101",        --5
              "10000010" WHEN "0110",        --6
              "11111000" WHEN "0111",        --7
              "10000000" WHEN "1000",        --8
              "10010000" WHEN "1001",        --9
              "10001000" WHEN "1010",        --A
              "10000011" WHEN "1011",        --b
              "11000110" WHEN "1100",        --C
              "10100001" WHEN "1101",        --d
              "10000110" WHEN "1110",        --E
              "10001110" WHEN "1111",        --F
              "11111111" WHEN OTHERS;        --Default

end Behavioral;