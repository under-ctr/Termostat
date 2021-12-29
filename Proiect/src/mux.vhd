 library IEEE;
use IEEE.std_logic_1164.all;

entity mux4g is							  --multiplexoru 4 la 1 avand calea de intrare pe 4 biti 
	
	port (
	a: in STD_LOGIC_VECTOR (3 downto 0);  
	b: in STD_LOGIC_VECTOR (3 downto 0); 
	c: in STD_LOGIC_VECTOR (3 downto 0);
	d: in STD_LOGIC_VECTOR (3 downto 0);
	sel: in STD_LOGIC_VECTOR (1 downto 0);
	y: out STD_LOGIC_VECTOR (3 downto 0)
	);
end mux4g;

architecture mux4g_arch of mux4g is
begin
	process (sel, a, b, c, d)
	begin 
		case sel is
			when "00"   => y <= a;
			when "01"   => y <= b;
			when "10"   => y <= c;
			when others => y <= d;	--valoarea d nu o folosim in algoritm sel avand valori doar intre 0 si 2
		end case;
	end process;
end mux4g_arch;