library ieee;
use ieee.std_logic_1164.all;
entity DUT is
		 --each of a and b are 32 bit long and cin is 1 bit long, so total 65 bits: abcin
   port(input_vector: in std_logic_vector(63 downto 0);
		 --out consists of a 32 bit long sum & 1 bit carry so 33 bits
        output_vector: out std_logic_vector(32 downto 0));
end entity;

architecture DutWrap of DUT is
   component mac is
     port(A, B: in std_logic_vector(15 downto 0); C: in std_logic_vector(31 downto 0); S: out std_logic_vector(31 downto 0); Cout: out std_logic);
   end component;
begin
   -- and must match the ordering in the trace file!
   add_instance: mac
			port map (
					-- order of inputs 
					A => input_vector(63 downto 48),
					B => input_vector(47 downto 32),
					C => input_vector(31 downto 0),
					S => output_vector(32 downto 1),
					Cout => output_vector(0));
end DutWrap;

