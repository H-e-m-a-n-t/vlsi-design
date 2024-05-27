library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

--entity to cc out p, g calculations for different orders
entity pg is
	port(pu, pl, gu, gl: in std_logic;
		  pr, gr: out std_logic);
end entity pg;
architecture struct of pg is
	begin
		andgate_1: andgate
			port map(A => pu, B => pl, prod => pr);
		abcgate_1: abcgate
			port map(A => gu, B => pu, C => gl, abc => gr);
	end architecture struct;

library ieee;
use ieee.std_logic_1164.all;
use work.Gates.all;	
entity cc is
	port(ci, gi, pi: in std_logic;
		  co: out std_logic);
end entity cc;
architecture struct of cc is
	begin
		abcgate_2: abcgate
			port map(A => gi, B => pi, C => ci, abc => co);
	end architecture struct;

library ieee;
use ieee.std_logic_1164.all;
use work.Gates.all;	
entity sum is
	port(pi, ci: in std_logic;
	     s: out std_logic);
end entity sum;
architecture struct of sum is
	begin
		xorgate_1: xorgate
			port map(A => pi, B => ci, uneq => s);
	end architecture struct;


library ieee;
use ieee.std_logic_1164.all;
use work.Gates.all;
entity adder_32b is
	port(A, B: in std_logic_vector(31 downto 0);
		  Cin: in std_logic;
		  S: out std_logic_vector(31 downto 0);
		  Cout: out std_logic);
end entity adder_32b;

architecture struct of adder_32b is

	signal g0, p0, c: std_logic_vector(31 downto 0);
	signal g1, p1: std_logic_vector(15 downto 0);
	signal g2, p2: std_logic_vector(7 downto 0);
	signal g3, p3: std_logic_vector(3 downto 0);
	signal g4, p4: std_logic_vector(1 downto 0);
	signal g5, p5: std_logic;
	
	
	component pg is
		port(pu, pl, gu, gl: in std_logic;
			  pr, gr: out std_logic);
	end component pg;


	component cc is 
		port(ci, gi, pi: in std_logic;
			  co: out std_logic);
	end component cc;


	component sum is
		port(pi, ci: in std_logic;
			  s: out std_logic);
	end component sum;
	
	begin
		c(0) <= Cin;
		
		--g0, p0 calculations
		g0 <= a and b after 337 ps;
		p0 <= a xor b after 674 ps;
		
		--g1, p1 calculations
		PG1_0: pg port map(pu => p0(1), pl => p0(0), gu => g0(1), gl => g0(0), pr => p1(0), gr => g1(0));
		PG1_1: pg port map(pu => p0(3), pl => p0(2), gu => g0(3), gl => g0(2), pr => p1(1), gr => g1(1));
		PG1_2: pg port map(pu => p0(5), pl => p0(4), gu => g0(5), gl => g0(4), pr => p1(2), gr => g1(2));
		PG1_3: pg port map(pu => p0(7), pl => p0(6), gu => g0(7), gl => g0(6), pr => p1(3), gr => g1(3));
		PG1_4: pg port map(pu => p0(9), pl => p0(8), gu => g0(9), gl => g0(8), pr => p1(4), gr => g1(4));
		PG1_5: pg port map(pu => p0(11), pl => p0(10), gu => g0(11), gl => g0(10), pr => p1(5), gr => g1(5));
		PG1_6: pg port map(pu => p0(13), pl => p0(12), gu => g0(13), gl => g0(12), pr => p1(6), gr => g1(6));
		PG1_7: pg port map(pu => p0(15), pl => p0(14), gu => g0(15), gl => g0(14), pr => p1(7), gr => g1(7));
		PG1_8: pg port map(pu => p0(17), pl => p0(16), gu => g0(17), gl => g0(16), pr => p1(8), gr => g1(8));
		PG1_9: pg port map(pu => p0(19), pl => p0(18), gu => g0(19), gl => g0(18), pr => p1(9), gr => g1(9));
		PG1_10: pg port map(pu => p0(21), pl => p0(20), gu => g0(21), gl => g0(20), pr => p1(10), gr => g1(10));
		PG1_11: pg port map(pu => p0(23), pl => p0(22), gu => g0(23), gl => g0(22), pr => p1(11), gr => g1(11));
		PG1_12: pg port map(pu => p0(25), pl => p0(24), gu => g0(25), gl => g0(24), pr => p1(12), gr => g1(12));
		PG1_13: pg port map(pu => p0(27), pl => p0(26), gu => g0(27), gl => g0(26), pr => p1(13), gr => g1(13));
		PG1_14: pg port map(pu => p0(29), pl => p0(28), gu => g0(29), gl => g0(28), pr => p1(14), gr => g1(14));
		PG1_15: pg port map(pu => p0(31), pl => p0(30), gu => g0(31), gl => g0(30), pr => p1(15), gr => g1(15));
		
		--g2, p2 calculations
		PG2_0: pg port map(pu => p1(1), pl => p1(0), gu => g1(1), gl => g1(0), pr => p2(0), gr => g2(0));
		PG2_1: pg port map(pu => p1(3), pl => p1(2), gu => g1(3), gl => g1(2), pr => p2(1), gr => g2(1));
		PG2_2: pg port map(pu => p1(5), pl => p1(4), gu => g1(5), gl => g1(4), pr => p2(2), gr => g2(2));
		PG2_3: pg port map(pu => p1(7), pl => p1(6), gu => g1(7), gl => g1(6), pr => p2(3), gr => g2(3));
		PG2_4: pg port map(pu => p1(9), pl => p1(8), gu => g1(9), gl => g1(8), pr => p2(4), gr => g2(4));
		PG2_5: pg port map(pu => p1(11), pl => p1(10), gu => g1(11), gl => g1(10), pr => p2(5), gr => g2(5));
		PG2_6: pg port map(pu => p1(13), pl => p1(12), gu => g1(13), gl => g1(12), pr => p2(6), gr => g2(6));
		PG2_7: pg port map(pu => p1(15), pl => p1(14), gu => g1(15), gl => g1(14), pr => p2(7), gr => g2(7));
		
		--g3, p3, calculations
		PG3_0: pg port map(pu => p2(1), pl => p2(0), gu => g2(1), gl => g2(0), pr => p3(0), gr => g3(0));
		PG3_1: pg port map(pu => p2(3), pl => p2(2), gu => g2(3), gl => g2(2), pr => p3(1), gr => g3(1));
		PG3_2: pg port map(pu => p2(5), pl => p2(4), gu => g2(5), gl => g2(4), pr => p3(2), gr => g3(2));
		PG3_3: pg port map(pu => p2(7), pl => p2(6), gu => g2(7), gl => g2(6), pr => p3(3), gr => g3(3));

		--g4, p4 calculations
		PG4_0: pg port map(pu => p3(1), pl => p3(0), gu => g3(1), gl => g3(0), pr => p4(0), gr => g4(0));
		PG4_1: pg port map(pu => p3(3), pl => p3(2), gu => g3(3), gl => g3(2), pr => p4(1), gr => g4(1));
		
		--g5, p5
		PG5_0: pg port map(pu => p4(1), pl => p4(0), gu => g4(1), gl => g4(0), pr => p5, gr => g5);
		
		
		--cc calculation
		C_32: cc port map(ci => c(0), gi => g5, pi => p5, co => Cout);--right most block of 5 level
		
		C_16: cc port map(ci => c(0), gi => g4(0), pi => p4(0), co => c(16));--right most block of 4 levl
		
		C_8: cc port map(ci => c(0), gi => g3(0), pi => p3(0), co => c(8));--right most block of 3 level
		C_24: cc port map(ci => c(16), gi => g3(2), pi => p3(2), co => c(24));
		
		C_4: cc port map(ci => c(0), gi => g2(0), pi => p2(0), co => c(4));--right most block of 2 level
		C_12: cc port map(ci => c(8), gi => g2(2), pi => p2(2), co => c(12));
		C_20: cc port map(ci => c(16), gi => g2(4), pi => p2(4), co => c(20));
		C_28: cc port map(ci => c(24), gi => g2(6), pi => p2(6), co => c(28));
		
		
		C_2: cc port map(ci => c(0), gi => g1(0), pi => p1(0), co => c(2));--right most block of 1 level
		C_6: cc port map(ci => c(4), gi => g1(2), pi => p1(2), co => c(6));
		C_10: cc port map(ci => c(8), gi => g1(4), pi => p1(4), co => c(10));
		C_14: cc port map(ci => c(12), gi => g1(6), pi => p1(6), co => c(14));
		C_18: cc port map(ci => c(16), gi => g1(8), pi => p1(8), co => c(18));
		C_22: cc port map(ci => c(20), gi => g1(10), pi => p1(10), co => c(22));
		C_26: cc port map(ci => c(24), gi => g1(12), pi => p1(12), co => c(26));
		C_30: cc port map(ci => c(28), gi => g1(14), pi => p1(14), co => c(30));
		
		
		--C_1: Cin_map_G port map(A => a(0), B => b(0), Cin => c(0), Bit0_G => c(1));--right most block of 0 level
		C_1: cc port map(ci => c(0), gi => g0(0), pi => p0(0), co => c(1));
		C_3: cc port map(ci => c(2), gi => g0(2), pi => p0(2), co => c(3));
		C_5: cc port map(ci => c(4), gi => g0(4), pi => p0(4), co => c(5));
		C_7: cc port map(ci => c(6), gi => g0(6), pi => p0(6), co => c(7));
		C_9: cc port map(ci => c(8), gi => g0(8), pi => p0(8), co => c(9));
		C_11: cc port map(ci => c(10), gi => g0(10), pi => p0(10), co => c(11));
		C_13: cc port map(ci => c(12), gi => g0(12), pi => p0(12), co => c(13));
		C_15: cc port map(ci => c(14), gi => g0(14), pi => p0(14), co => c(15));
		C_17: cc port map(ci => c(16), gi => g0(16), pi => p0(16), co => c(17));
		C_19: cc port map(ci => c(18), gi => g0(18), pi => p0(18), co => c(19));
		C_21: cc port map(ci => c(20), gi => g0(20), pi => p0(20), co => c(21));
		C_23: cc port map(ci => c(22), gi => g0(22), pi => p0(22), co => c(23));
		C_25: cc port map(ci => c(24), gi => g0(24), pi => p0(24), co => c(25));
		C_27: cc port map(ci => c(26), gi => g0(26), pi => p0(26), co => c(27));
		C_29: cc port map(ci => c(28), gi => g0(28), pi => p0(28), co => c(29));
		C_31: cc port map(ci => c(30), gi => g0(30), pi => p0(30), co => c(31));
		
		--sum calculation
		S_0: sum port map(pi => p0(0), ci => c(0), s => S(0));
		S_1: sum port map(pi => p0(1), ci => c(1), s => S(1));
		S_2: sum port map(pi => p0(2), ci => c(2), s => S(2));
		S_3: sum port map(pi => p0(3), ci => c(3), s => S(3));
		S_4: sum port map(pi => p0(4), ci => c(4), s => S(4));
		S_5: sum port map(pi => p0(5), ci => c(5), s => S(5));
		S_6: sum port map(pi => p0(6), ci => c(6), s => S(6));
		S_7: sum port map(pi => p0(7), ci => c(7), s => S(7));
		S_8: sum port map(pi => p0(8), ci => c(8), s => S(8));
		S_9: sum port map(pi => p0(9), ci => c(9), s => S(9));
		S_10: sum port map(pi => p0(10), ci => c(10), s => S(10));
		S_11: sum port map(pi => p0(11), ci => c(11), s => S(11));
		S_12: sum port map(pi => p0(12), ci => c(12), s => S(12));
		S_13: sum port map(pi => p0(13), ci => c(13), s => S(13));
		S_14: sum port map(pi => p0(14), ci => c(14), s => S(14));
		S_15: sum port map(pi => p0(15), ci => c(15), s => S(15));
		S_16: sum port map(pi => p0(16), ci => c(16), s => S(16));
		S_17: sum port map(pi => p0(17), ci => c(17), s => S(17));
		S_18: sum port map(pi => p0(18), ci => c(18), s => S(18));
		S_19: sum port map(pi => p0(19), ci => c(19), s => S(19));
		S_20: sum port map(pi => p0(20), ci => c(20), s => S(20));
		S_21: sum port map(pi => p0(21), ci => c(21), s => S(21));
		S_22: sum port map(pi => p0(22), ci => c(22), s => S(22));
		S_23: sum port map(pi => p0(23), ci => c(23), s => S(23));
		S_24: sum port map(pi => p0(24), ci => c(24), s => S(24));
		S_25: sum port map(pi => p0(25), ci => c(25), s => S(25));
		S_26: sum port map(pi => p0(26), ci => c(26), s => S(26));
		S_27: sum port map(pi => p0(27), ci => c(27), s => S(27));
		S_28: sum port map(pi => p0(28), ci => c(28), s => S(28));
		S_29: sum port map(pi => p0(29), ci => c(29), s => S(29));
		S_30: sum port map(pi => p0(30), ci => c(30), s => S(30));
		S_31: sum port map(pi => p0(31), ci => c(31), s => S(31));
		
	end architecture struct;
		
		