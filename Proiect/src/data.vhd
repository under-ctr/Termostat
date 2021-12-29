  library ieee;	 
use IEEE.std_logic_1164.all;
use ieee.math_real.all;
use ieee.std_logic_arith.all; --pentru a genera vectorul  
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity data is
	port(
	--clk: in std_logic ;
	clk : in std_logic_vector(0 downto 0);
	day1 : out std_logic_vector(3 downto 0); 
	day2 : out std_logic_vector(3 downto 0);
	month1 : out std_logic_vector(3 downto 0);
	month2 : out std_logic_vector (3 downto 0));
end entity;

architecture ziua of data is 


	signal  ziua1 : integer range 0 to 3 := 0;	 --aici stocam valoarea zecilor pentru zile
	signal ziua2: integer range 0  to 9 :=1;	  --aici stocam valoarea unitatilor pentru zile
	signal luna1 : integer range 0 to 1 :=0;		 --aici stocam valoarea zecilor pentru luna
	signal luna2: integer range 0 to 9 := 1;		 --aici stocam valoarea unitatilor pentru luna
	signal an : integer :=2020; --aici se contorizeaza anul curent 
	signal cnt_luna : integer range 1 to 12 := 1; --  
begin
	process(clk, cnt_luna) 	
	begin 
		if(clk'event and clk= "1") then   
			if(cnt_luna = 1 or cnt_luna = 3 or cnt_luna = 5 or cnt_luna = 7 or cnt_luna = 8 or cnt_luna = 10 or  cnt_luna = 12) then   --pentru lunile cu 31 de zile
				if( ziua2 = 1 and ziua1 =3 )then   --se reseteaza ziua 
					ziua1<= 0;
					ziua2<= 1; 	
					if( cnt_luna=12) then  --aici verificam daca suntem in luna 12 pentru a incrementa anul
						cnt_luna<=1; 
						an<= an+1;	  -- anul creste cu o valoare
					else
						cnt_luna<=cnt_luna+1;  --
					end if;
					if(luna2=2 and luna1=1)then		--se reseteaza valoare pentru luna
						luna1 <=0;
						luna2<=1;
					else
						if( luna2=9) then 
							luna1 <= luna1+1;  --verificam daca luna1 trebuie incrementata si luna2 resetata 
							luna2 <= 0;
						else
							luna2 <=luna2+1;  --altfel luna2 creste cu o unitate 
						end if;
					end if ;
				else
					if(ziua2 = 9 and ziua1 <3 )then
						ziua2<=0;				   --verificam daca ziua1 trebuie incrementata si ziua2 resetata
						ziua1 <=ziua1+1;
					else
						ziua2<=ziua2+1;	 --in caz contrar ziua2 creste cu o unitate
					end if;
				end if;
			else 
				if(cnt_luna = 4 or cnt_luna = 6	or cnt_luna = 9 or cnt_luna = 11) then	--pentru lunile cu 30 de zile
					if(ziua2 =0 and ziua1=3) then
						ziua1<= 0;
						ziua2<= 1;
						if( cnt_luna=12) then
							cnt_luna<=1;		 --verificam daca anul trebuie incrementat 
							an<=an+1;
						else
							cnt_luna<=cnt_luna+1;
						end if;
						if(luna2=2 and luna1=1)then
							luna1 <=0;
							luna2<=1;  --verificam daca luna trebuie resetata 
						else
							if( luna2=9) then 
								luna1 <= luna1+1; -- verificam daca luna1 trebuie incrementata si luna2 resetata 
								luna2 <= 0;
							else
								luna2 <=luna2+1;		-- altfel luna2 creste cu o unitate 
							end if;
						end if	;
					else
						if(ziua2 = 9 and ziua1 <3) then	  --verificam daca luna2 trebuie resetata insa nu si luna1 care trebuie doar incrementata cu o valoare
							ziua2<=0;
							ziua1<=ziua1+1;
						else
							ziua2<=ziua2+1;
						end if;		
					end if;
				else 
					if(cnt_luna = 2) then 
						if( ((an mod 4 = 0)  and ( an mod 100 /= 0)) or( an mod 400 = 0) ) then	--verificam cazul in care avem an bisect 
							if(ziua2 =9  and ziua1 = 2)	then
								ziua1<= 0;
								ziua2<= 1;
								if( cnt_luna=12) then
									cnt_luna<=1;
									an<= an+1;
								else
									cnt_luna<=cnt_luna+1;
								end if;
								if(luna2=2 and luna1=1)then
									luna1 <=0;
									luna2<=1;
								else
									if( luna2=9) then 
										luna1 <= luna1+1;
										luna2 <= 0;
									else
										luna2 <=luna2+1;
									end if;
								end if ;
							else
								if(ziua2= 9 and ziua1 <2) then
									ziua2<=0;
									ziua1<=ziua1+1;
								else
									ziua2<=ziua2+1;
								end if;
							end if;
						else
							if(ziua2 =8  and ziua1= 2) then	   --daca nu avem an bisect ajungem doar la 28 de zile in februarie
								ziua1<= 0;
								ziua2<= 1;
								if( cnt_luna=12) then
									cnt_luna<=1;
									an<=an+1;
								else
									cnt_luna<=cnt_luna+1;
					end if;
								if(luna2=2 and luna1=1)then
									luna1 <=0;
									luna2<=1;
								else
									if( luna2=9) then 
										luna1 <= luna1+1;
										luna2 <= 0;
									else
										luna2 <=luna2+1;
									end if;
								end if;
							else
								if(ziua2= 9 and ziua1 <2) then
									ziua2 <=0;
									ziua1 <=ziua1+1;
								else
									ziua2<=ziua2+1;
								end if;  
							end if;	
						end if; 
					
						
		 	    	end if;
			    end if;
			end if;
		else 
			ziua1<= ziua1;
			ziua2<=ziua2;
	    	luna1<=luna1;
			luna2<=luna2;
 	    	an<=an;	
			
		end if;	
     end process ;
 	 month1 <= conv_std_logic_vector(luna1, 4);	 --convertim valorile din intreg in std_logic_vector(3 downto 0);
	 month2 <= conv_std_logic_vector(luna2, 4);
	 day1 <= conv_std_logic_vector(ziua1, 4);
	 day2 <= conv_std_logic_vector(ziua2, 4);

end architecture;