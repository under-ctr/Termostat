library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd	 is
port ( LED_BCD: in STD_LOGIC_vector(3 downto 0); 
	   LED_out: out STD_LOGIC_vector(6 downto 0));
end entity;

architecture arch_afisaj of bcd is

begin
process(LED_BCD)
begin 
	
    case LED_BCD is
    when "0000" => LED_out <= "0000001"; -- "0"     
    when "0001" => LED_out <= "1001111"; -- "1" 
    when "0010" => LED_out <= "0010010"; -- "2" 
    when "0011" => LED_out <= "0000110"; -- "3" 
    when "0100" => LED_out <= "1001100"; -- "4" 
    when "0101" => LED_out <= "0100100"; -- "5" 
    when "0110" => LED_out <= "0100000"; -- "6" 
    when "0111" => LED_out <= "0001111"; -- "7" 
    when "1000" => LED_out <= "0000000"; -- "8"     
    when "1001" => LED_out <= "0000100"; -- "9" 
	when "1010" => LED_out <= "1111110";  --afiseaza minus
	when "1110" => LED_out <= "0110001";	--afiseaza C
    when others => LED_out <= "1111111"; -- nu afiseaza nimic
  
	
    end case;
end process;

end architecture;