 library IEEE;        
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mama is
	port( clk_start: in std_logic  ;
	LED_out1: out STD_LOGIC_vector(6 downto 0);
	LED_out2: out STD_LOGIC_vector(6 downto 0);
	LED_out3: out STD_LOGIC_vector(6 downto 0);
	LED_out4: out STD_LOGIC_vector(6 downto 0));
		
	
end entity;

architecture se_poate of mama is

component  mux4g is

	port (
	a: in STD_LOGIC_VECTOR (3 downto 0);
	b: in STD_LOGIC_VECTOR (3 downto 0); 
	c: in STD_LOGIC_VECTOR (3 downto 0);
	d: in STD_LOGIC_VECTOR (3 downto 0);
	sel: in STD_LOGIC_VECTOR (1 downto 0);
	y: out STD_LOGIC_VECTOR (3 downto 0)
	);
end component;

component numarator is 
	port(
	clk : in std_logic ;																					
	q : out std_logic_vector(1 downto 0) ;
	carry_out: out std_logic
	);
end component;

component minutes is 
	port( clk : in std_logic;	 
	min1: out std_logic_vector(3 downto 0);
	min2: out std_logic_vector(3 downto 0);
	ora1 :out std_logic_vector (3 downto 0);
	ora2: out std_logic_vector(3 downto 0); 
	carry_ora: out std_logic_vector(0 downto 0) );  		
end component;

component data is
	port(
	clk : in std_logic_vector(0 downto 0);
	day1 : out std_logic_vector(3 downto 0); 
	day2 : out std_logic_vector(3 downto 0);
	month1 : out std_logic_vector(3 downto 0);
	month2 : out std_logic_vector (3 downto 0));
end component;		  

component rand_gen is	 
	port( 
	clk : in std_logic; 
	temp_out1: out std_logic_vector(3 downto 0);  
	temp_out2: out std_logic_vector(3 downto 0); 
	minus : out std_logic_vector(3 downto 0)); 
end component;	 


component bcd is
port ( LED_BCD: in STD_LOGIC_vector(3 downto 0); 
		
	 	LED_out: out STD_LOGIC_vector(6 downto 0));
end component;			  

signal 	carry_nr1 : std_logic; 
signal iesire_nr2 :std_logic_vector(1 downto 0); 
signal iesire_mux1 : std_logic_vector(3 downto 0);	   
signal iesire_mux2 : std_logic_vector(3 downto 0);
signal iesire_mux3 : std_logic_vector(3 downto 0);
signal iesire_mux4 : std_logic_vector(3 downto 0);
signal temp1 : std_logic_vector(3 downto 0); 
signal temp2 : std_logic_vector(3 downto 0);  
signal minuss : std_logic_vector(3 downto 0); 
signal minute1: std_logic_vector(3 downto 0); 
signal minute2: std_logic_vector(3 downto 0);
signal ore1: std_logic_vector(3 downto 0);
signal ore2: std_logic_vector(3 downto 0);	 
signal carry_ore : std_logic_vector(0 downto 0);  
signal ziua1: std_logic_vector(3 downto 0);
signal ziua2: std_logic_vector(3 downto 0);
signal luna1: std_logic_vector(3 downto 0);
signal luna2: std_logic_vector(3 downto 0);
--aici declar semnale 
begin

	nr1: numarator port map(clk=> clk_start,carry_out=>carry_nr1 );              
   	nr2 : numarator port map(clk=> carry_nr1, q=> iesire_nr2);
	temperatura: rand_gen port map (clk=> clk_start,temp_out1=> temp1, temp_out2 => temp2, minus=>minuss); 
	minute: minutes port map(clk=> clk_start,  min1=> minute1, min2=>minute2, ora1=>ore1, ora2=> ore2, carry_ora=> carry_ore );
	zile: data port map(clk=>carry_ore, day1=>ziua1, day2=>ziua2, month1=>luna1, month2=>luna2 );
	mux1: mux4g port map(a=> minuss, b=> minute1 , c=> ziua1, sel=> iesire_nr2, d=>"0000", y=>iesire_mux1);	   --trebuie sa pun minus la afisor
	mux2: mux4g port map(a=>temp1, b=> minute2, c=> ziua2, sel=> iesire_nr2, d=> "0000" , y=> iesire_mux2);
	mux3: mux4g port map(a=>temp2, b=> ore1, c=>luna1 , sel=> iesire_nr2, d=> "0000" , y=> iesire_mux3);
	mux4: mux4g port map(a=>"1110", b=> ore2, c=>luna2 , sel=> iesire_nr2, d=> "0000" , y=> iesire_mux4);  
	
	afisor1: bcd port map( LED_bcd => iesire_mux1, LED_out => LED_out1 );
	afisor2: bcd port map( LED_bcd => iesire_mux2, LED_out => LED_out2);
	afisor3: bcd port map( LED_bcd => iesire_mux3, LED_out => LED_out3);
	afisor4: bcd port map( LED_bcd => iesire_mux4, LED_out => LED_out4);
	
	--port mapuri
	
	
end architecture;