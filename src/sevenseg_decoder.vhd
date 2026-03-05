----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2026 09:43:47 AM
-- Design Name: 
-- Module Name: sevenseg_decoder - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevenseg_decoder is
    Port ( i_Hex : in STD_LOGIC_VECTOR (3 downto 0);
           o_seg_n : out STD_LOGIC_VECTOR (6 downto 0));
end sevenseg_decoder;

architecture Behavioral of sevenseg_decoder is
  signal seg_ah_abcdefg : std_logic_vector(6 downto 0); -- bit6=a ... bit0=g
  signal seg_ah_AG      : std_logic_vector(6 downto 0); -- bit0=a ... bit6=g
begin

  -- Active-HIGH truth table written as "abcdefg"
  with i_Hex select
  seg_ah_abcdefg <=
    "1111110" when "0000",
    "0110000" when "0001",
    "1101101" when "0010",
    "1111001" when "0011",
    "0110011" when "0100",
    "1011011" when "0101",
    "1011111" when "0110",
    "1110000" when "0111",
    "1111111" when "1000",
    "1110011" when "1001",
    "1110111" when "1010",
    "0011111" when "1011",
    "0001101" when "1100",
    "0111101" when "1101",
    "1001111" when "1110",
    "1000111" when "1111",
    "0000000" when others;

  -- Map abcdefg -> seg(0)=A ... seg(6)=G
  seg_ah_AG(0) <= seg_ah_abcdefg(6); -- A
  seg_ah_AG(1) <= seg_ah_abcdefg(5); -- B
  seg_ah_AG(2) <= seg_ah_abcdefg(4); -- C
  seg_ah_AG(3) <= seg_ah_abcdefg(3); -- D
  seg_ah_AG(4) <= seg_ah_abcdefg(2); -- E
  seg_ah_AG(5) <= seg_ah_abcdefg(1); -- F
  seg_ah_AG(6) <= seg_ah_abcdefg(0); -- G

  -- Convert to ACTIVE-LOW for Basys3 cathodes
  o_seg_n <= not seg_ah_AG;

end Behavioral;