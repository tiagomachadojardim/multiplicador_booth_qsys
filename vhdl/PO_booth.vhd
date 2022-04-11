library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PO_booth is
	
	
	port(
		PO_clk				: in std_logic;
		PO_enable1 			: in std_logic;
		PO_enable2 			: in std_logic;
		PO_enable3 			: in std_logic;
		PO_enable4 			: in std_logic;
		PO_enable5 			: in std_logic;
		PO_cont				: in std_logic_vector(1 downto 0);
		PO_multiplicando	: in std_logic_vector(5 downto 0);
		PO_final				: out std_logic_vector(11 downto 0)
	);
end entity;

architecture arch of PO_booth is
signal R0 : unsigned (5 downto 0):= unsigned(PO_multiplicando);
signal R1 : unsigned (11 downto 0):= (others => '0');
signal R2 : unsigned (11 downto 0):= (others => '0');
signal R3 : unsigned (11 downto 0):= (others => '0');
signal R4 : unsigned (11 downto 0):= (others => '0');
signal R5 : unsigned (11 downto 0):= (others => '0');
signal result : unsigned (11 downto 0):= (others => '0');


begin
 
	process(PO_clk,PO_cont,PO_enable1,PO_enable2,PO_enable3,PO_enable4,PO_enable5)
		variable S1 	: unsigned (5 downto 0);
		variable S2 	: unsigned (5 downto 0);
		variable S3 	: unsigned (5 downto 0);
		variable S4 	: unsigned (5 downto 0);
		variable S5 	: unsigned (5 downto 0);
		
	begin
		
		
			if(rising_edge(PO_clk)) then
			
				if(PO_enable1 = '1')then    -- 100
					S1 :=  NOT(R0) + 1;
					if(S1(5) = '1') then
						if(PO_cont = "00")then
						R1 <= "11111"& S1 & '0';
						elsif(PO_cont = "01")then
						R1 <= "111"& S1 & "000";
						elsif(PO_cont = "10")then
						R1 <= '1'& S1 & "00000";
						end if;
					
					else
					if(PO_cont = "00")then
						R1 <= "00000"& S1 & '0';
						elsif(PO_cont = "01")then
						R1 <= "000"& S1 & "000";
						elsif(PO_cont = "11")then
						R1 <= '0'& S1 & "00000";
						end if;
					
					end if;
				
					result <= result + R1;
					
					
				elsif(PO_enable2 = '1') then -- 000 ou 111
					-- valor com zero nao faz nada
						R2 <= (others => '0');
						result <= result + R2;
				
						
				elsif(PO_enable3 = '1') then -- 011
					S3 :=  R0;
					
					if(S3(5) = '1') then
						if(PO_cont = "00")then
						R3 <= "11111"& S3 & '0';
						elsif(PO_cont = "01")then
						R3 <= "111"& S3 & "000";
						elsif(PO_cont = "10")then
						R3 <= '1'& S3 & "00000";
						end if;
					
					else
					if(PO_cont = "00")then
						R3 <= "00000"& S3 & '0';
						elsif(PO_cont = "01")then
						R3 <= "000"& S3 & "000";
						elsif(PO_cont = "10")then
						R3 <= '0'& S3 & "00000";
						end if;
					
					end if;
					result <= result + R3;
			
							
					
				elsif(PO_enable4 = '1') then -- 001 ou 010
					S4:= R0;
					
					if(S4(5) = '1') then
						if(PO_cont = "00")then
						R4 <= "11111"& S4 & '0';
						elsif(PO_cont = "01")then
						R4 <= "111"& S4 & "000";
						elsif(PO_cont = "11")then
						R4 <= '1'& S4 & "00000";
						end if;
					
					else
					if(PO_cont = "00")then
						R4 <= "00000"& S4 & '0';
						elsif(PO_cont = "01")then
						R4 <= "0000" & S4 & "00";
						elsif(PO_cont = "10")then
						R4 <= '0'& S4 & "00000";
						end if;
					
					end if;
					
					result <= result + R4;
					
			
					
					
				elsif(PO_enable5 = '1') then -- 101 ou 110
				
					S5 := NOT(R0) + 1;
					
					if(S5(5) = '1') then
						if(PO_cont = "00")then
						R5 <= "11111"& S5 & '0';
						elsif(PO_cont = "01")then
						R5 <= "111"& S5 & "000";
						elsif(PO_cont = "10")then
						R5 <= '1'& S5 & "00000";
						end if;
					
					else
					if(PO_cont = "00")then
						R5 <= "00000"& S5 & '0';
						elsif(PO_cont = "01")then
						R5 <= "000"& S5 & "000";
						elsif(PO_cont = "10")then
						R5 <= '0'& S5 & "00000";
						end if;
					
					end if;
					
					result <= result + R5;
			
					
					
				end if;
		PO_final <= std_logic_vector(result);
			end if;
			
   
	end process;
		
end arch;				
				
