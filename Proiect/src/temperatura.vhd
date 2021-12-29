library ieee;	 
use IEEE.std_logic_1164.all;
use ieee.math_real.all;
use ieee.std_logic_arith.all; --pentru a genera vectorul  
use IEEE.STD_LOGIC_UNSIGNED.ALL; 


entity rand_gen is	 
	port( 
	clk : in std_logic; 
	temp_out1: out std_logic_vector(3 downto 0);  
	temp_out2: out std_logic_vector(3 downto 0); 
	minus : out std_logic_vector(3 downto 0)); 
end rand_gen;

architecture aloo of rand_gen is

signal rand_num	: integer := 0;	

signal  temp_in1 : integer range -9 to 9:= 1 ;	
signal  temp_in2 : integer range -9 to 9 :=6 ;	
signal cnt: std_logic_vector(1 downto 0) := "00" ;	
signal  cnt_temp : integer := 16; 
signal minuss : integer :=15; --valoarea 10 pentru minuss reprezinta un numar negativ iar valoarea 15 un numar pozitiv, aceste valori sunt tratate in cadrul afisorului 	
signal random : real ;

begin
	
	process
		variable seed1, seed2 : positive;
		
		variable rand_negative : real; --variabila random care determina daca numarul e negativ sau pozitiv
		
	begin		 	
		uniform(seed1, seed2, rand_negative); -- functia care genereaza un numar aleator intre 0 si 1	  
		random<= rand_negative;
		if clk'event    then
			if cnt< "10" then 
				cnt<=cnt+1;
			else
				cnt<="00";
			end if;				--numaram 3 secunde
			if(cnt_temp <0) then 
				minuss<= 10;
			else				   --minuss este folosit pentru a stii daca avem o valoare pozitiva sau una negativa 
				minuss<=15;
			end if;
			if (rand_negative > 0.5) then  -- daca valoarea aleataore este mai mare de 0,5 atunci temperatura creste cu un grad
				if(minuss = 15) then 	   --verificam daca suntem pe un numar pozitiv
					if(temp_in2=9) then
						temp_in1<= temp_in1+1;
						temp_in2<= 0;	
						cnt_temp<=cnt_temp+1;
					else
						temp_in2<=temp_in2+1; 
						cnt_temp<=cnt_temp+1;
					end if;
					if(temp_in1 = 5) then 
						temp_in1 <= 4; 		 --temperatura maxima este de 50 de grade
						cnt_temp <= 41;
					end if;
				else			   --cazul in care un numar negativ trebuie incrementat cu o unitate
					if(temp_in2= 0 and temp_in1 >0 ) then	
						temp_in2<=9;
						temp_in1<= temp_in1 -1;
						cnt_temp<=cnt_temp+1;
					else
						if(temp_in2 =1  and temp_in1 =0) then
							minuss<= 15; 
							temp_in2<= temp_in2 -1;
							cnt_temp<= cnt_temp +1;
						else
							temp_in2<= temp_in2-1; 
							cnt_temp<=cnt_temp+1; 
						end if;
					end if;
				end if;
			else		   --daca valoarea aleatoare este mai mica decat 0,5 atunci temperatura scade cu un grad
				if(minuss =15) then	 --verificam daca trebuie sa decrementam un numar pozitiv
					if(temp_in2= 0 and temp_in1= 0) then
						temp_in2<=temp_in2 +1;
						cnt_temp<= cnt_temp-1;
						minuss<=10;
					else
						if(temp_in2 = 0 and temp_in1 > 0) then
							temp_in2<= 9;
							temp_in1<= temp_in1-1;
							cnt_temp<= cnt_temp-1;
						else
							temp_in2<= temp_in2-1;
							cnt_temp<=cnt_temp-1;
							
						end if;
					end if;	  
				else   --cazul in care numarul care trebuie decrementat este negativ
					if(	temp_in2 = 9) then
						temp_in2<= 0;
						temp_in1<=temp_in1 +1;
						cnt_temp<=cnt_temp-1;
					else
						temp_in2<=temp_in2 +1;
						cnt_temp<= cnt_temp -1;
					end if;
					if(temp_in1 = 3) then	 --temperatura minima este -30 de grade
						temp_in1<=2;
						cnt_temp<=-29; 
						temp_in2<=9;
					end if;
				end if;
			end if;
		else
			cnt_temp<=cnt_temp;
			temp_in1<=temp_in1;
			temp_in2<=temp_in2;
			minuss<=minuss;
		end if;	
						
			wait for 30 ns;
	end process;
		
	temp_out1 <= conv_std_logic_vector(temp_in1, 4);--conversia din intreg in std_logic_vector 		
	temp_out2 <= conv_std_logic_vector(temp_in2, 4);  
	minus<= conv_std_logic_vector(minuss,4);
end architecture;
























