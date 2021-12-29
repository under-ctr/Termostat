library IEEE;        
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;   
use ieee.math_real.all;
use ieee.std_logic_arith.all;
	
entity numarator is 
	port(
	clk : in std_logic ;																					
	q : out std_logic_vector(1 downto 0) ;
	carry_out: out std_logic
	);
end numarator; 

architecture a of numarator is
signal qn : integer range 0 to 255;
begin  
	
	process	(clk)
	variable cnt : integer range 0 to 255;
	variable carry : std_logic;
	constant modulus : integer :=3;    --numarator modulo 3
	

	begin
		if(clk'EVENT AND clk= '1') then
			if cnt = modulus-1 then 
				cnt := 0;	   
				carry := '1';
			else
				cnt:= cnt +1 ;
				carry := '0';
			end if;
		end if;
		qn <= cnt;
		carry_out <= carry;	  
		
	end process;
	q<= conv_std_logic_vector(qn, 2); --coversia din integer in std_logic_vector(1 downto 0);
end a;