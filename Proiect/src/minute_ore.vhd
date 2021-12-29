library ieee;	 
use IEEE.std_logic_1164.all;
use ieee.math_real.all;
use ieee.std_logic_arith.all; --pentru a genera vectorul  
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity minutes is 
	port( clk : in std_logic;	 
	min1: out std_logic_vector(3 downto 0) ;
	min2: out std_logic_vector(3 downto 0) ;
	ora1 :out std_logic_vector (3 downto 0 );
	ora2: out std_logic_vector(3 downto 0); 
	carry_ora: out std_logic_vector(0 downto 0) );  		
end entity;

architecture flux of minutes is

signal minute1 : integer range 0 to 5 := 0;	  --aici pastram valoarea zecilor pentru minute 
signal minute2 : integer range 0 to 	9 :=0; --aici pastram valoarea unitatilor pentru minute 
signal sec: integer range 0 to 59 := 0;  	  --acest semnal este folosit pentru numararea secundelor  
signal ore1 : integer range 0 to 2:= 0;		--aici pastram valoarea zecilor pentru ore 
signal ore2 :integer range 0 to 9 :=0;	  --aici pastram valoarea unitatilor pentru ore
signal carry_ore : integer :=0; --acest carry este generat pentru schimbarea zilelor 
begin 
	process(clk)   
	begin
	if(clk'event and clk = '1' ) then
		if( sec = 59) then 
			sec<= 0;
			if (minute1 = 5 and minute2 = 9) then 
				minute1<= 0; 
				minute2<= 0; 
					if(ore1= 2 and ore2 = 3) then 
						ore1 <= 0 ;
						ore2 <= 0 ;
						carry_ore <=1;
					else  
						if(ore2 = 9 and ore1 < 2)  then
							ore2<=0;
							ore1<=ore1+1; 
							carry_ore<=0;
						else
							ore2<=ore2+1; 
							carry_ore<=0;
						end if;
					end if;	
			else
				if(minute2 = 9 and minute1 < 5) then
					minute2<= 0;
					minute1<= minute1+1;
				else 
					minute2<=minute2+1;
				end if;
			end if;	
	    else
			sec <= sec+1; 
		end if;    
		
	   else
		minute1 <= minute1;
		minute2<= minute2;
		sec<= sec;
		ore1 <=ore1;
		ore2 <=ore2;
	end if;	
		  
	end process;
	min1 <= conv_std_logic_vector(minute1, 4);--conversia din intreg in std_logic_vector(3 downto 0);	
	min2 <= conv_std_logic_vector(minute2, 4);
	ora2 <= conv_std_logic_vector(ore2, 4);
	ora1 <= conv_std_logic_vector(ore1, 4);
	carry_ora <= conv_std_logic_vector(carry_ore, 1);--conversia din intreg in std_logic_vector(0 downto 0);
end architecture;		
	