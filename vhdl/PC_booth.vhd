library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_booth is

	port 
	(
		PC_clk		: in std_logic;
		PC_Go			: in std_logic;
		PC_multiplicador	: in unsigned(5 downto 0);	
		PC_enable_1	: out std_logic;
		PC_enable_2	: out std_logic;
		PC_enable_3	: out std_logic;
		PC_enable_4	: out std_logic;
		PC_enable_5	: out std_logic;
		PC_cont 		: out std_logic_vector(1 downto 0);
		PC_DadoPRT  : out std_logic
		
		
	);
end entity;

architecture rtl of PC_booth is
	
type estados_nome is (inicio, estado1, estado2, estado3, estadofinal);	
	
signal estado_atual, prox_estado : estados_nome;
signal dummybit : std_logic;
begin
	

	process(PC_clk, PC_Go,prox_estado,estado_atual,PC_multiplicador,dummybit)
	
	begin
			if(PC_Go = '0') then
			estado_atual <= inicio;
			
			elsif( rising_edge(PC_clk)) then							
			estado_atual <= prox_estado;
			
			case estado_atual is
		
			when inicio =>
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "00";
				dummybit <= '0';
				prox_estado <= estado1;
			-----------------------------------------------------------------
			when estado1 =>
				if(PC_multiplicador(1 downto 0) = "10" and dummybit  = '0') then  -- 100
				PC_enable_1 <= '1';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "00";
				prox_estado <= estado2;
				elsif(PC_multiplicador(1 downto 0) = "00" and dummybit  = '0') then  -- 000
				PC_enable_1 <= '0';
				PC_enable_2 <= '1';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "00";
				prox_estado <= estado2;
				
				elsif(PC_multiplicador(1 downto 0) = "11" and dummybit  = '0') then   -- 110
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '1';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "00";
				prox_estado <= estado2;
				
				elsif(PC_multiplicador(1 downto 0) = "01" and dummybit  = '0') then  -- 010
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '1';
				PC_enable_5 <= '0';
				PC_cont <= "00";
				prox_estado <= estado2;
				
				end if;
			----------------------------------------------------------------------------------------
			when estado2 =>
				if((PC_multiplicador(3 downto 1) = "000") or (PC_multiplicador(3 downto 1) = "111")) then  -- 000 ou 111
				PC_enable_1 <= '0';
				PC_enable_2 <= '1';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "01";
				prox_estado <= estado3;
				elsif(PC_multiplicador(3 downto 1) = "100") then	-- 100
				PC_enable_1 <= '1';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "01";
				prox_estado <= estado3;
				
				elsif(PC_multiplicador(3 downto 1) = "011" ) then	-- 011
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '1';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "01";
				prox_estado <= estado3;
				
				elsif(PC_multiplicador(3 downto 1) = "001" or PC_multiplicador(3 downto 1) = "010") then 	-- 001 ou 010
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '1';
				PC_enable_5 <= '0';
				PC_cont <= "01";
				prox_estado <= estado3;
				
				
				elsif(PC_multiplicador(3 downto 1) = "101" or PC_multiplicador(3 downto 1) = "110") then 	-- 101 ou 110
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '1';
				PC_cont <= "01";
				prox_estado <= estado3;
				end if;
			
			-----------------------------------------------------------------------------------------
			when estado3 =>
				if((PC_multiplicador(5 downto 3) = "000") or (PC_multiplicador(5 downto 3) = "111")) then -- 000 ou 111
				PC_enable_1 <= '0';
				PC_enable_2 <= '1';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "10";
			   prox_estado <= estadofinal;
				elsif(PC_multiplicador(5 downto 3) = "000") then -- 100
				PC_enable_1 <= '1';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "10";
				prox_estado <= estadofinal;
				
				elsif(PC_multiplicador(5 downto 3) = "000") then -- 011
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '1';
				PC_enable_4 <= '0';
				PC_enable_5 <= '0';
				PC_cont <= "10";
			   prox_estado <= estadofinal;
				
				elsif(PC_multiplicador(5 downto 3) = "000") then -- 001 ou 010
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '1';
				PC_enable_5 <= '0';
				PC_cont <= "10";
				prox_estado <= estadofinal;
				
				elsif(PC_multiplicador(5 downto 3) = "000") then -- 101 ou 110
				PC_enable_1 <= '0';
				PC_enable_2 <= '0';
				PC_enable_3 <= '0';
				PC_enable_4 <= '0';
				PC_enable_5 <= '1';
				PC_cont <= "10";
		
				prox_estado <= estadofinal;
				end if;
	
	
			------------------------------------------------------------------------------------
			when estadofinal =>
		   PC_dadoPRT <= '1';
		   
	
		end case;
			
			
			end if;
	
	end process;

	
		
	
	
	



end rtl;
