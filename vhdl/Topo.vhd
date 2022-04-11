LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Topo IS
PORT (
OSC_CLK : IN STD_LOGIC; 
RESET_N : IN STD_LOGIC  

);
END Topo;

ARCHITECTURE lights_rtl OF Topo IS


component MySoC is
	port (
		clk_clk        : in  std_logic;             
		reset_reset_n  : in  std_logic;            
		go_export		: out std_logic;               							 
		dadoprt_export : in  std_logic;
		resp_export    : in  std_logic_vector(11 downto 0); --    resp.export
		m_export       : out std_logic_vector(5 downto 0);                     --       m.export
		n_export       : out std_logic_vector(5 downto 0)                      --       n.export	
	);
end component MySoC;

component PO_booth is
	port (
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
end component PO_booth;

component PC_booth is
	port (
		PC_clk		: in std_logic;
		PC_multiplicador	: in std_logic_vector(5 downto 0);	
		PC_enable_1	: out std_logic;
		PC_enable_2	: out std_logic;
		PC_enable_3	: out std_logic;
		PC_enable_4	: out std_logic;
		PC_enable_5	: out std_logic;
		PC_cont 		: out std_logic_vector(1 downto 0);
		PC_Go			: in std_logic;
		PC_DadoPRT  : out std_logic
		
		
	);
end component PC_booth;



signal GoConnect : std_logic;
signal DadoPrtConnect : std_logic;
signal RespConnect : std_logic_vector(11 downto 0);
signal MConnect : std_logic_vector(5 downto 0);
signal nConnect : std_logic_vector(5 downto 0);
signal top_enable1,top_enable2,top_enable3,top_enable4,top_enable5 : std_logic;
signal top_cont : std_logic_vector( 1 downto 0);
 
begin

MyFirstSoC: MySoC port map(
	clk_clk			 => OSC_CLK,
	reset_reset_n   => RESET_N,
	dadoprt_export  => DadoPrtConnect,
	go_export       => GoConnect,
	m_export			 => MConnect,
	n_export			 => nConnect,
	resp_export     => RespConnect
	);


My_PO: PO_booth port map(
	PO_clk 						 => OSC_CLK,
	PO_multiplicando			 => MConnect,
	PO_final    				 => RespConnect,
	PO_enable1					 => top_enable1,
	PO_enable2					 => top_enable2,
	PO_enable3					 => top_enable3,
	PO_enable4					 => top_enable4,
	PO_enable5					 => top_enable5,
	PO_cont						 => top_cont
	);	
	
My_PC: PC_booth port map(
	PC_clk 				 => OSC_CLK,
	PC_multiplicador	 => nConnect,
	PC_DadoPRT			 => DadoPrtConnect,
	PC_Go 				 => GoConnect,
	PC_enable_1			 => top_enable1,
	PC_enable_2			 => top_enable2,
	PC_enable_3			 => top_enable3,
	PC_enable_4			 => top_enable4,
	PC_enable_5		    => top_enable5,
	PC_cont				 => top_cont
	);	
	

END lights_rtl;

