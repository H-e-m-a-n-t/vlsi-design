library ieee;
use ieee.std_logic_1164.all;

entity mac is 
	port(
			a,b : in std_logic_vector(15 downto 0);
			c: in std_logic_vector(31 downto 0);
			s: out std_logic_vector(31 downto 0);
			cout: out std_logic
		);
end entity mac;

architecture struct of mac is	
	component andgate is
		port (A, B: in std_logic; prod: out std_logic);
	end component andgate;
	
	component fa is
		port (a, b, cin: in std_logic; s, cout: out std_logic);
	end component fa;
	
	component ha is 
		port (a, b: in std_logic; s, c: out std_logic);
	end component ha;
	
	component adder_32b is 
		port(A, B: in std_logic_vector(31 downto 0);
		  Cin: in std_logic;
		  S: out std_logic_vector(31 downto 0);
		  Cout: out std_logic);
	end component adder_32b;


	signal gnd_signal: std_logic := '0';
	
	-- first layer
	signal l1r1: std_logic_vector(31 downto 0);
	signal l1r2: std_logic_vector(15 downto 0);
	signal l1r3: std_logic_vector(16 downto 1);
	signal l1r4: std_logic_vector(17 downto 2);
	signal l1r5: std_logic_vector(18 downto 3);
	signal l1r6: std_logic_vector(19 downto 4);
	signal l1r7: std_logic_vector(20 downto 5);
	signal l1r8: std_logic_vector(21 downto 6);
	signal l1r9: std_logic_vector(22 downto 7);
	signal l1r10: std_logic_vector(23 downto 8);
	signal l1r11: std_logic_vector(24 downto 9);
	signal l1r12: std_logic_vector(25 downto 10);
	signal l1r13: std_logic_vector(26 downto 11);
	signal l1r14: std_logic_vector(27 downto 12);
	signal l1r15: std_logic_vector(28 downto 13);
	signal l1r16: std_logic_vector(29 downto 14);
	signal l1r17: std_logic_vector(30 downto 15);
	
	signal wires: std_logic_vector(421 downto 0);
	
	signal arg1: std_logic_vector(31 downto 0);
	signal arg2: std_logic_vector(31 downto 0);
	
	begin
	
	l1r1 <= c;
	
	--set of the first 16*16 products
	a1: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(0), prod => l1r2(i));
	end generate a1;
	
	a2: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(1), prod => l1r3(i+1));
	end generate a2;
	
	a3: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(2), prod => l1r4(i+2));
	end generate a3;
	
	a4: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(3), prod => l1r5(i+3));
	end generate a4;
	
	a5: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(4), prod => l1r6(i+4));
	end generate a5;
	
	a6: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(5), prod => l1r7(i+5));
	end generate a6;
	
	a7: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(6), prod => l1r8(i+6));
	end generate a7;
	
	a8: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(7), prod => l1r9(i+7));
	end generate a8;
	
	a9: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(8), prod => l1r10(i+8));
	end generate a9;
	
	a10: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(9), prod => l1r11(i+9));
	end generate a10;
	
	a11: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(10), prod => l1r12(i+10));
	end generate a11;
	
	a12: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(11), prod => l1r13(i+11));
	end generate a12;
	
	a13: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(12), prod => l1r14(i+12));
	end generate a13;
	
	a14: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(13), prod => l1r15(i+13));
	end generate a14;
	
	a15: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(14), prod => l1r16(i+14));
	end generate a15;
	
	a16: for i in 0 to 15 generate
		and_i: andgate port map(a => b(i), b => a(15), prod => l1r17(i+15));
	end generate a16;
	
	--layer, carry from previous layer previous columns, sum from previous layer same coulmn 
	
	--c1
	arg1(0) <= l1r1(0);
	arg2(0) <= l1r2(0);
	
	--c2
	h1: ha port map(a => l1r1(1), b => l1r2(1), s => arg1(1), c => arg2(2));
	
	arg2(1) <= l1r3(1);
	
	
	--c3
	h2: ha port map(a => l1r1(2), b => l1r2(2), s => wires(0), c => wires(1));
	
	f1: fa port map(a => wires(0), b => l1r3(2), cin => l1r4(2), s => arg1(2), cout => arg2(3));
	
	--c4
	h3: ha port map(a=> l1r1(3), b => l1r2(3), s => wires(2), c => wires(3));
	
	f2: fa port map(a=> wires(2), b => l1r3(3), cin => l1r4(3), s=> wires(4), cout => wires(5));
	f3: fa port map(a=> wires(4), b => l1r5(3), cin => wires(1), s => arg1(3), cout=> arg2(4));
	
	--c5
	f4: fa port map(a => l1r1(4), b=> l1r2(4), cin => l1r3(4), s=> wires(6), cout => wires(7));
	h4: ha port map(a => l1r4(4), b => l1r5(4), s => wires(8), c => wires(9));
	
	f5: fa port map(a => wires(6), b => wires(8), cin => wires(3), s => wires(10), cout => wires(11));
	
	f6: fa port map(a => wires(10), b => l1r6(4), cin => wires(5), s => arg1(4), cout => arg2(5));
	
	--c6
	h5: ha port map(a => l1r1(5), b=> l1r2(5), s => wires(12), c => wires(13));
	
	f7: fa port map(a => wires(12), b=> l1r3(5), cin => l1r4(5), s=>wires(14), cout => wires(15));
	f8: fa port map(a => l1r5(5), b=>l1r6(5), cin => l1r7(5), s => wires(16), cout => wires(17));
	
	f9: fa port map(a => wires(14), b => wires(16), cin => wires(7), s => wires(18), cout => wires(19));
	
	f10: fa port map(a => wires(18), b => wires(9), cin => wires(11), s => arg1(5), cout => arg2(6));
	
	--c7
	f11: fa port map(a =>l1r1(6), b=>l1r2(6), cin=>l1r3(6), s=>wires(20), cout=>wires(21));
	h6: ha port map(a =>l1r4(6), b =>l1r5(6), s=>wires(22), c=>wires(23));
	
	f12: fa port map(a =>wires(20), b=>wires(22), cin=>wires(13), s=>wires(24), cout=>wires(25));
	f13: fa port map(a =>l1r6(6), b=>l1r7(6), cin=>l1r8(6), s=>wires(26), cout=>wires(27));
	
	f14: fa port map(a =>wires(24), b=>wires(26), cin=>wires(15), s=>wires(28), cout=>wires(29));
	
	f15: fa port map(a =>wires(28), b=>wires(17), cin=>wires(19), s=>arg1(6), cout=>arg2(7));
	
	--c8
	f16: fa port map(a =>l1r1(7), b=>l1r2(7), cin=>l1r3(7), s=>wires(30), cout=>wires(31));
	f17: fa port map(a =>l1r4(7), b=>l1r5(7), cin=>l1r6(7), s=>wires(32), cout=>wires(33));
	h7: ha port map(a=>l1r7(7), b=>l1r8(7), s=>wires(34), c=>wires(35));
	
	f18: fa port map(a =>wires(30), b=>wires(32), cin=>wires(34), s=>wires(36), cout=>wires(37));
	f19: fa port map(a =>wires(21), b=>l1r9(7), cin=>wires(23), s=>wires(38), cout=>wires(39));
	
	f20: fa port map(a =>wires(36), b=>wires(38), cin=>wires(25), s=>wires(40), cout=>wires(41));
	
	f21: fa port map(a =>wires(40), b=>wires(27), cin=>wires(29), s=>arg1(7), cout=>arg2(8));
	
	--c9
	h8 : ha port map(a=> l1r1(8), b=> l1r2(8), s=>wires(42), c=> wires(43));
	
	f22: fa port map(a =>wires(42), b=>l1r3(8), cin=>l1r4(8), s=>wires(44), cout=>wires(45));
	f23: fa port map(a =>l1r5(8), b=>l1r6(8), cin=>l1r7(8), s=>wires(46), cout=>wires(47));
	f24: fa port map(a =>l1r8(8), b=>l1r9(8), cin=>l1r10(8), s=>wires(48), cout=>wires(49));
	
	f25: fa port map(a =>wires(44), b=>wires(46), cin=>wires(48), s=>wires(50), cout=>wires(51));
	f26: fa port map(a =>wires(31), b=>wires(33), cin=>wires(35), s=>wires(52), cout=>wires(53));
	
	f27: fa port map(a =>wires(50), b=>wires(52), cin=>wires(37), s=>wires(54), cout=>wires(55));
	
	f28: fa port map(a =>wires(54), b=>wires(39), cin=>wires(41), s=>arg1(8), cout=>arg2(9));
	
	--c10
	f29: fa port map(a =>l1r1(9), b=>l1r2(9), cin=>l1r3(9), s=>wires(56), cout=>wires(57));
	h9 : ha port map(a =>l1r4(9), b =>l1r5(9), s=>wires(58), c=>wires(59));
	
	f30: fa port map(a =>wires(56), b=>wires(58), cin=>l1r6(9), s=>wires(60), cout=>wires(61));
	f31: fa port map(a =>l1r7(9), b=>l1r8(9), cin=>l1r9(9), s=>wires(62), cout=>wires(63));
	f32: fa port map(a =>l1r10(9), b=>l1r11(9), cin=>wires(43), s=>wires(64), cout=>wires(65));
	
	f33: fa port map(a =>wires(60), b=>wires(62), cin=>wires(64), s=>wires(66), cout=>wires(67));
	f34: fa port map(a =>wires(45), b=>wires(47), cin=>wires(49), s=>wires(68), cout=>wires(69));
	
	f35: fa port map(a =>wires(66), b=>wires(68), cin=>wires(51), s=>wires(70), cout=>wires(71));
	
	f36: fa port map(a =>wires(70), b=>wires(53), cin=>wires(55), s=>arg1(9), cout=>arg2(10));
	
	--c11
	f37: fa port map(a =>l1r1(10), b=>l1r2(10), cin=>l1r3(10), s=>wires(72), cout=>wires(73));
	f38: fa port map(a =>l1r4(10), b=>l1r5(10), cin=>l1r6(10), s=>wires(74), cout=>wires(75));
	h10: ha port map(a =>l1r7(10), b =>l1r8(10), s=>wires(76), c=>wires(77));
	
	f39: fa port map(a =>wires(72), b=>wires(74), cin=>wires(76), s=>wires(78), cout=>wires(79));
	f40: fa port map(a =>wires(57), b=>wires(59), cin=>l1r9(10), s=>wires(80), cout=>wires(81));
	f41: fa port map(a =>l1r10(10), b=>l1r11(10), cin=>l1r12(10), s=>wires(82), cout=>wires(83));
	
	f42: fa port map(a =>wires(78), b=>wires(80), cin=>wires(82), s=>wires(84), cout=>wires(85));
	f43: fa port map(a =>wires(61), b=>wires(63), cin=>wires(65), s=>wires(86), cout=>wires(87));
	
	f44: fa port map(a =>wires(84), b=>wires(86), cin=>wires(67), s=>wires(88), cout=>wires(89));
	
	f45: fa port map(a =>wires(88), b=>wires(69), cin=>wires(71), s=>arg1(10), cout=>arg2(11));
	
	--c12
	f46: fa port map(a =>l1r1(11), b=>l1r2(11), cin=>l1r3(11), s=>wires(90), cout=>wires(91));
	f47: fa port map(a =>l1r4(11), b=>l1r5(11), cin=>l1r6(11), s=>wires(92), cout=>wires(93));
	f48: fa port map(a =>l1r7(11), b=>l1r8(11), cin=>l1r9(11), s=>wires(94), cout=>wires(95));
	h11: ha port map(a =>l1r10(11), b =>l1r11(11), s=>wires(96), c=>wires(97));
	
	f49: fa port map(a =>wires(90), b=>wires(92), cin=>wires(94), s=>wires(98), cout=>wires(99));
	f50: fa port map(a =>wires(96), b=>l1r12(11), cin=>l1r13(11), s=>wires(100), cout=>wires(101));
	f51: fa port map(a =>wires(73), b=>wires(75), cin=>wires(77), s=>wires(102), cout=>wires(103));
	
	f52: fa port map(a =>wires(98), b=>wires(100), cin=>wires(102), s=>wires(104), cout=>wires(105));
	f53: fa port map(a =>wires(79), b=>wires(81), cin=>wires(83), s=>wires(106), cout=>wires(107));
	
	f54: fa port map(a =>wires(104), b=>wires(106), cin=>wires(85), s=>wires(108), cout=>wires(109));
	
	f55: fa port map(a =>wires(108), b=>wires(87), cin=>wires(89), s=>arg1(11), cout=>arg2(12));
	
	--c13
	h12: ha port map(a =>l1r1(12), b =>l1r2(12), s=>wires(110), c=>wires(111));
	
	f56: fa port map(a =>wires(110), b=>l1r3(12), cin=>l1r4(12), s=>wires(112), cout=>wires(113));
	f57: fa port map(a =>l1r5(12), b=>l1r6(12), cin=>l1r7(12), s=>wires(114), cout=>wires(115));
	f58: fa port map(a =>l1r8(12), b=>l1r9(12), cin=>l1r10(12), s=>wires(116), cout=>wires(117));
	f59: fa port map(a =>l1r11(12), b=>l1r12(12), cin=>l1r13(12), s=>wires(118), cout=>wires(119));
	
	f60: fa port map(a =>wires(112), b=>wires(114), cin=>wires(116), s=>wires(120), cout=>wires(121));
	f61: fa port map(a =>wires(118), b=>l1r14(12), cin=>wires(91), s=>wires(122), cout=>wires(123));
	f62: fa port map(a =>wires(93), b=>wires(95), cin=>wires(97), s=>wires(124), cout=>wires(125));
	
	f63: fa port map(a =>wires(120), b=>wires(122), cin=>wires(124), s=>wires(126), cout=>wires(127));
	f64: fa port map(a =>wires(99), b=>wires(101), cin=>wires(103), s=>wires(128), cout=>wires(129));
	
	f65: fa port map(a =>wires(126), b=>wires(128), cin=>wires(105), s=>wires(130), cout=>wires(131));
	
	f66: fa port map(a =>wires(130), b=>wires(107), cin=>wires(109), s=>arg1(12), cout=>arg2(13));
	
	--c14
	f67: fa port map(a =>l1r1(13), b=>l1r2(13), cin=>l1r3(13), s=>wires(132), cout=>wires(133));
	h13: ha port map(a =>l1r4(13), b =>l1r5(13), s=>wires(134), c=>wires(135));
	
	f68: fa port map(a =>wires(132), b=>wires(134), cin=>l1r6(13), s=>wires(136), cout=>wires(137));
	f69: fa port map(a =>l1r7(13), b=>l1r8(13), cin=>l1r9(13), s=>wires(138), cout=>wires(139));
	f70: fa port map(a =>l1r10(13), b=>l1r11(13), cin=>l1r12(13), s=>wires(140), cout=>wires(141));
	f71: fa port map(a =>l1r13(13), b=>l1r14(13), cin=>wires(111), s=>wires(142), cout=>wires(143));
	
	f72: fa port map(a =>wires(136), b=>wires(138), cin=>wires(140), s=>wires(144), cout=>wires(145));
	f73: fa port map(a =>wires(142), b=>wires(113), cin=>l1r15(13), s=>wires(146), cout=>wires(147));
	f74: fa port map(a =>wires(115), b=>wires(117), cin=>wires(119), s=>wires(148), cout=>wires(149));
	
	f75: fa port map(a =>wires(144), b=>wires(146), cin=>wires(148), s=>wires(150), cout=>wires(151));
	f76: fa port map(a =>wires(121), b=>wires(123), cin=>wires(125), s=>wires(152), cout=>wires(153));
	
	f77: fa port map(a =>wires(150), b=>wires(152), cin=>wires(127), s=>wires(154), cout=>wires(155));
	
	f78: fa port map(a =>wires(154), b=>wires(129), cin=>wires(131), s=>arg1(13), cout=>arg2(14));
	
	--c15
	f79: fa port map(a =>l1r1(14), b=>l1r2(14), cin=>l1r3(14), s=>wires(156), cout=>wires(157));
	f80: fa port map(a =>l1r4(14), b=>l1r5(14), cin=>l1r6(14), s=>wires(158), cout=>wires(159));
	h14: ha port map(a =>l1r7(14), b =>l1r8(14), s=>wires(160), c=>wires(161));
	
	f81: fa port map(a =>wires(156), b=>wires(158), cin=>wires(160), s=>wires(162), cout=>wires(163));
	f82: fa port map(a =>l1r9(14), b=>l1r10(14), cin=>l1r11(14), s=>wires(164), cout=>wires(165));
	f83: fa port map(a =>l1r12(14), b=>l1r13(14), cin=>l1r14(14), s=>wires(166), cout=>wires(167));
	f84: fa port map(a =>l1r15(14), b=>wires(133), cin=>wires(135), s=>wires(168), cout=>wires(169));
	
	f85: fa port map(a =>wires(162), b=>wires(164), cin=>wires(166), s=>wires(170), cout=>wires(171));
	f86: fa port map(a =>wires(168), b=>l1r16(14), cin=>wires(137), s=>wires(172), cout=>wires(173));
	f87: fa port map(a =>wires(139), b=>wires(141), cin=>wires(143), s=>wires(174), cout=>wires(175));
	
	f88: fa port map(a =>wires(170), b=>wires(172), cin=>wires(174), s=>wires(176), cout=>wires(177));
	f89: fa port map(a =>wires(145), b=>wires(147), cin=>wires(149), s=>wires(178), cout=>wires(179));
	
	f90: fa port map(a =>wires(176), b=>wires(178), cin=>wires(151), s=>wires(180), cout=>wires(181));
	
	f91: fa port map(a =>wires(180), b=>wires(153), cin=>wires(155), s=>arg1(14), cout=>arg2(15));
	
	--c16
	f92: fa port map(a =>l1r1(15), b=>l1r2(15), cin=>l1r3(15), s=>wires(182), cout=>wires(183));
	f93: fa port map(a =>l1r4(15), b=>l1r5(15), cin=>l1r6(15), s=>wires(184), cout=>wires(185));
	f94: fa port map(a =>l1r7(15), b=>l1r8(15), cin=>l1r9(15), s=>wires(186), cout=>wires(187));
	h15: ha port map(a =>l1r10(15), b =>l1r11(15), s=>wires(188), c=>wires(189));
	
	f95: fa port map(a =>wires(182), b=>wires(184), cin=>wires(186), s=>wires(190), cout=>wires(191));
	f96: fa port map(a =>wires(188), b=>l1r12(15), cin=>l1r13(15), s=>wires(192), cout=>wires(193));
	f97: fa port map(a =>l1r14(15), b=>l1r15(15), cin=>l1r16(15), s=>wires(194), cout=>wires(195));
	f98: fa port map(a =>wires(157), b=>wires(159), cin=>wires(161), s=>wires(196), cout=>wires(197));
	
	f99: fa port map(a =>wires(190), b=>wires(192), cin=>wires(194), s=>wires(198), cout=>wires(199));
	f100: fa port map(a =>wires(196), b=>l1r17(15), cin=>wires(163), s=>wires(200), cout=>wires(201));
	f101: fa port map(a =>wires(165), b=>wires(167), cin=>wires(169), s=>wires(202), cout=>wires(203));
	
	f103: fa port map(a =>wires(198), b=>wires(200), cin=>wires(202), s=>wires(204), cout=>wires(205));
	f104: fa port map(a =>wires(171), b=>wires(173), cin=>wires(175), s=>wires(206), cout=>wires(207));
	
	f105: fa port map(a =>wires(204), b=>wires(206), cin=>wires(177), s=>wires(208), cout=>wires(209));
	
	f106: fa port map(a =>wires(208), b=>wires(179), cin=>wires(181), s=>arg1(15), cout=>arg2(16));
	
	--c17
	f107: fa port map(a =>l1r1(16), b=>l1r3(16), cin=>l1r4(16), s=>wires(210), cout=>wires(211));
	f108: fa port map(a =>l1r5(16), b=>l1r6(16), cin=>l1r7(16), s=>wires(212), cout=>wires(213));
	f109: fa port map(a =>l1r8(16), b=>l1r9(16), cin=>l1r10(16), s=>wires(214), cout=>wires(215));
	h16: ha port map(a =>l1r11(16), b =>l1r12(16), s=>wires(216), c=>wires(217));
	
	f110: fa port map(a =>wires(210), b=>wires(212), cin=>wires(214), s=>wires(218), cout=>wires(219));
	f111: fa port map(a =>wires(216), b=>l1r13(16), cin=>l1r14(16), s=>wires(220), cout=>wires(221));
	f112: fa port map(a =>l1r15(16), b=>l1r16(16), cin=>wires(183), s=>wires(222), cout=>wires(223));
	f113: fa port map(a =>wires(185), b=>wires(187), cin=>wires(189), s=>wires(224), cout=>wires(225));
	
	f114: fa port map(a =>wires(218), b=>wires(220), cin=>wires(222), s=>wires(226), cout=>wires(227));
	f115: fa port map(a =>wires(224), b=>l1r17(16), cin=>wires(191), s=>wires(228), cout=>wires(229));
	f116: fa port map(a =>wires(193), b=>wires(195), cin=>wires(197), s=>wires(230), cout=>wires(231));
	
	f117: fa port map(a =>wires(226), b=>wires(228), cin=>wires(230), s=>wires(232), cout=>wires(233));
	f118: fa port map(a =>wires(199), b=>wires(201), cin=>wires(203), s=>wires(234), cout=>wires(235));
	
	f119: fa port map(a =>wires(232), b=>wires(234), cin=>wires(205), s=>wires(236), cout=>wires(237));
	
	f120: fa port map(a =>wires(236), b=>wires(207), cin=>wires(209), s=>arg1(16), cout=>arg2(17));
	
	--c18
	f121: fa port map(a =>l1r1(17), b=>l1r4(17), cin=>l1r5(17), s=>wires(238), cout=>wires(239));
	f122: fa port map(a =>l1r6(17), b=>l1r7(17), cin=>l1r8(17), s=>wires(240), cout=>wires(241));
	f123: fa port map(a =>l1r9(17), b=>l1r10(17), cin=>l1r11(17), s=>wires(242), cout=>wires(243));

	f124: fa port map(a =>wires(238), b=>wires(240), cin=>wires(242), s=>wires(244), cout=>wires(245));
	f125: fa port map(a =>l1r12(17), b=>l1r13(17), cin=>l1r14(17), s=>wires(246), cout=>wires(247));
	f126: fa port map(a =>l1r15(17), b=>l1r16(17), cin=>wires(211), s=>wires(248), cout=>wires(249));
	f127: fa port map(a =>wires(213), b=>wires(215), cin=>wires(217), s=>wires(250), cout=>wires(251));
	
	f128: fa port map(a =>wires(244), b=>wires(246), cin=>wires(248), s=>wires(252), cout=>wires(253));
	f129: fa port map(a =>wires(250), b=>l1r17(17), cin=>wires(219), s=>wires(254), cout=>wires(255));
	f130: fa port map(a =>wires(221), b=>wires(223), cin=>wires(225), s=>wires(256), cout=>wires(257));
	
	f131: fa port map(a =>wires(252), b=>wires(254), cin=>wires(256), s=>wires(258), cout=>wires(259));
	f132: fa port map(a =>wires(227), b=>wires(229), cin=>wires(231), s=>wires(260), cout=>wires(261));
	
	f133: fa port map(a =>wires(258), b=>wires(260), cin=>wires(233), s=>wires(262), cout=>wires(263));
	
	f134: fa port map(a =>wires(262), b=>wires(235), cin=>wires(237), s=>arg1(17), cout=>arg2(18));
	
	
	--c19
	f135: fa port map(a =>l1r1(18), b=>l1r5(18), cin=>l1r6(18), s=>wires(264), cout=>wires(265));
	f136: fa port map(a =>l1r7(18), b=>l1r8(18), cin=>l1r9(18), s=>wires(266), cout=>wires(267));
	
	
	f137: fa port map(a =>wires(264), b=>wires(266), cin=>l1r10(18), s=>wires(270), cout=>wires(271));
	f138: fa port map(a =>l1r11(18), b=>l1r12(18), cin=>l1r13(18), s=>wires(272), cout=>wires(273));
	f139: fa port map(a =>l1r14(18), b=>l1r15(18), cin=>l1r16(18), s=>wires(274), cout=>wires(275));
	f140: fa port map(a =>wires(239), b=>wires(241), cin=>wires(243), s=>wires(276), cout=>wires(277));
	
	f141: fa port map(a =>wires(270), b=>wires(272), cin=>wires(274), s=>wires(278), cout=>wires(279));
	f142: fa port map(a =>wires(276), b=>l1r17(18), cin=>wires(245), s=>wires(280), cout=>wires(281));
	f143: fa port map(a =>wires(247), b=>wires(249), cin=>wires(251), s=>wires(282), cout=>wires(283));
	
	f144: fa port map(a =>wires(278), b=>wires(280), cin=>wires(282), s=>wires(284), cout=>wires(285));
	f145: fa port map(a =>wires(253), b=>wires(255), cin=>wires(257), s=>wires(286), cout=>wires(287));
	
	f146: fa port map(a =>wires(284), b=>wires(286), cin=>wires(259), s=>wires(288), cout=>wires(289));
	
	f147: fa port map(a =>wires(288), b=>wires(261), cin=>wires(263), s=>arg1(18), cout=>arg2(19));
	
	--c20
	f148: fa port map(a =>l1r1(19), b=>l1r6(19), cin=>l1r7(19), s=>wires(290), cout=>wires(291));
	
	f149: fa port map(a =>wires(290), b=>l1r8(19), cin=>l1r9(19), s=>wires(292), cout=>wires(293));
	f150: fa port map(a =>l1r10(19), b=>l1r11(19), cin=>l1r12(19), s=>wires(294), cout=>wires(295));
	f151: fa port map(a =>l1r13(19), b=>l1r14(19), cin=>l1r15(19), s=>wires(296), cout=>wires(297));
	f152: fa port map(a =>l1r16(19), b=>wires(265), cin=>wires(267), s=>wires(298), cout=>wires(299));
	
	f153: fa port map(a =>wires(292), b=>wires(294), cin=>wires(296), s=>wires(300), cout=>wires(301));
	f154: fa port map(a =>wires(298), b=>l1r17(19), cin=>wires(271), s=>wires(302), cout=>wires(303));
	f155: fa port map(a =>wires(273), b=>wires(275), cin=>wires(277), s=>wires(304), cout=>wires(305));
	
	f156: fa port map(a =>wires(300), b=>wires(302), cin=>wires(304), s=>wires(306), cout=>wires(307));
	f157: fa port map(a =>wires(279), b=>wires(281), cin=>wires(283), s=>wires(308), cout=>wires(309));
	
	f158: fa port map(a =>wires(306), b=>wires(308), cin=>wires(285), s=>wires(310), cout=>wires(311));
	
	f159: fa port map(a =>wires(310), b=>wires(287), cin=>wires(289), s=>arg1(19), cout=>arg2(20));
	
	--c21
	f160: fa port map(a =>l1r1(20), b=>l1r7(20), cin=>l1r8(20), s=>wires(312), cout=>wires(313));
	f161: fa port map(a =>l1r9(20), b=>l1r10(20), cin=>l1r11(20), s=>wires(314), cout=>wires(315));
	f162: fa port map(a =>l1r12(20), b=>l1r13(20), cin=>l1r14(20), s=>wires(316), cout=>wires(317));
	f163: fa port map(a =>l1r15(20), b=>l1r16(20), cin=>wires(291), s=>wires(318), cout=>wires(319));
	
	f164: fa port map(a =>wires(312), b=>wires(314), cin=>wires(316), s=>wires(320), cout=>wires(321));
	f165: fa port map(a =>wires(318), b=>l1r17(20), cin=>wires(293), s=>wires(322), cout=>wires(323));
	f166: fa port map(a =>wires(295), b=>wires(297), cin=>wires(299), s=>wires(324), cout=>wires(325));
	
	f167: fa port map(a =>wires(320), b=>wires(322), cin=>wires(324), s=>wires(326), cout=>wires(327));
	f168: fa port map(a =>wires(301), b=>wires(303), cin=>wires(305), s=>wires(328), cout=>wires(329));
	
	f169: fa port map(a =>wires(326), b=>wires(328), cin=>wires(307), s=>wires(330), cout=>wires(331));
	
	f170: fa port map(a =>wires(330), b=>wires(309), cin=>wires(311), s=>arg1(20), cout=>arg2(21));
	
	--c22
	f171: fa port map(a =>l1r1(21), b=>l1r8(21), cin=>l1r9(21), s=>wires(332), cout=>wires(333));
	f172: fa port map(a =>l1r10(21), b=>l1r11(21), cin=>l1r12(21), s=>wires(334), cout=>wires(335));
	f173: fa port map(a =>l1r13(21), b=>l1r14(21), cin=>l1r15(21), s=>wires(336), cout=>wires(337));
	
	f174: fa port map(a =>wires(332), b=>wires(334), cin=>wires(336), s=>wires(338), cout=>wires(339));
	f175: fa port map(a =>l1r16(21), b=>l1r17(21), cin=>wires(313), s=>wires(340), cout=>wires(341));
	f176: fa port map(a =>wires(315), b=>wires(317), cin=>wires(319), s=>wires(342), cout=>wires(343));
	
	f177: fa port map(a =>wires(338), b=>wires(340), cin=>wires(342), s=>wires(344), cout=>wires(345));
	f178: fa port map(a =>wires(321), b=>wires(323), cin=>wires(325), s=>wires(346), cout=>wires(347));
	
	f179: fa port map(a =>wires(344), b=>wires(346), cin=>wires(327), s=>wires(348), cout=>wires(349));
	
	f180: fa port map(a =>wires(348), b=>wires(329), cin=>wires(331), s=>arg1(21), cout=>arg2(22));
	
	--c23
	f181: fa port map(a =>l1r1(22), b=>l1r9(22), cin=>l1r10(22), s=>wires(350), cout=>wires(351));
	f182: fa port map(a =>l1r11(22), b=>l1r12(22), cin=>l1r13(22), s=>wires(352), cout=>wires(353));
	
	f183: fa port map(a =>wires(350), b=>wires(352), cin=>l1r14(22), s=>wires(354), cout=>wires(355));
	f184: fa port map(a =>l1r15(22), b=>l1r16(22), cin=>l1r17(22), s=>wires(356), cout=>wires(357));
	f185: fa port map(a =>wires(333), b=>wires(335), cin=>wires(337), s=>wires(358), cout=>wires(359));
	
	f186: fa port map(a =>wires(354), b=>wires(356), cin=>wires(358), s=>wires(360), cout=>wires(361));
	f187: fa port map(a =>wires(339), b=>wires(341), cin=>wires(343), s=>wires(362), cout=>wires(363));
	
	f188: fa port map(a =>wires(360), b=>wires(362), cin=>wires(345), s=>wires(364), cout=>wires(365));
	
	f189: fa port map(a =>wires(364), b=>wires(347), cin=>wires(349), s=>arg1(22), cout=>arg2(23));
	
	--c24
	f190: fa port map(a =>l1r1(23), b=>l1r10(23), cin=>l1r11(23), s=>wires(366), cout=>wires(367));
	
	f191: fa port map(a =>wires(366), b=>l1r12(23), cin=>l1r13(23), s=>wires(368), cout=>wires(369));
	f192: fa port map(a =>l1r14(23), b=>l1r15(23), cin=>l1r16(23), s=>wires(370), cout=>wires(371));
	f193: fa port map(a =>l1r17(23), b=>wires(351), cin=>wires(353), s=>wires(372), cout=>wires(373));
	
	f194: fa port map(a =>wires(368), b=>wires(370), cin=>wires(372), s=>wires(374), cout=>wires(375));
	f195: fa port map(a =>wires(355), b=>wires(357), cin=>wires(359), s=>wires(376), cout=>wires(377));
	
	f196: fa port map(a =>wires(374), b=>wires(376), cin=>wires(361), s=>wires(378), cout=>wires(379));
	
	f197: fa port map(a =>wires(378), b=>wires(363), cin=>wires(365), s=>arg1(23), cout=>arg2(24));
	
	--c25
	f198: fa port map(a =>l1r1(24), b=>l1r11(24), cin=>l1r12(24), s=>wires(380), cout=>wires(381));
	f199: fa port map(a =>l1r13(24), b=>l1r14(24), cin=>l1r15(24), s=>wires(382), cout=>wires(383));
	f200: fa port map(a =>l1r16(24), b=>l1r17(24), cin=>wires(367), s=>wires(384), cout=>wires(385));
	
	f201: fa port map(a =>wires(380), b=>wires(382), cin=>wires(384), s=>wires(386), cout=>wires(387));
	f202: fa port map(a =>wires(369), b=>wires(371), cin=>wires(373), s=>wires(388), cout=>wires(389));
	
	f203: fa port map(a =>wires(386), b=>wires(388), cin=>wires(375), s=>wires(390), cout=>wires(391));
	
	f204: fa port map(a =>wires(390), b=>wires(377), cin=>wires(379), s=>arg1(24), cout=>arg2(25));
	
	--c26
	f205: fa port map(a =>l1r1(25), b=>l1r12(25), cin=>l1r13(25), s=>wires(392), cout=>wires(393));
	f206: fa port map(a =>l1r14(25), b=>l1r15(25), cin=>l1r16(25), s=>wires(394), cout=>wires(395));
	
	f207: fa port map(a =>wires(392), b=>wires(394), cin=>l1r17(25), s=>wires(396), cout=>wires(397));
	f208: fa port map(a =>wires(381), b=>wires(383), cin=>wires(385), s=>wires(398), cout=>wires(399));
	
	f209: fa port map(a =>wires(396), b=>wires(398), cin=>wires(387), s=>wires(400), cout=>wires(401));
	
	f210: fa port map(a =>wires(400), b=>wires(389), cin=>wires(391), s=>arg1(25), cout=>arg2(26));
	
	--c27
	f211: fa port map(a =>l1r1(26), b=>l1r13(26), cin=>l1r14(26), s=>wires(402), cout=>wires(403));

	f212: fa port map(a =>wires(402), b=>l1r15(26), cin=>l1r16(26), s=>wires(404), cout=>wires(405));
	f213: fa port map(a =>l1r17(26), b=>wires(393), cin=>wires(395), s=>wires(406), cout=>wires(407));
	
	f214: fa port map(a =>wires(404), b=>wires(406), cin=>wires(397), s=>wires(408), cout=>wires(409));
	
	f215: fa port map(a =>wires(408), b=>wires(399), cin=>wires(401), s=>arg1(26), cout=>arg2(27));
	
	--c28
	f216: fa port map(a =>l1r1(27), b=>l1r14(27), cin=>l1r15(27), s=>wires(410), cout=>wires(411));
	f217: fa port map(a =>l1r16(27), b=>l1r17(27), cin=>wires(403), s=>wires(412), cout=>wires(413));
	
	f218: fa port map(a =>wires(410), b=>wires(412), cin=>wires(405), s=>wires(414), cout=>wires(415));
	
	f219: fa port map(a =>wires(414), b=>wires(407), cin=>wires(409), s=>arg1(27), cout=>arg2(28));
	
	--c29
	f220: fa port map(a =>l1r1(28), b=>l1r15(28), cin=>l1r16(28), s=>wires(416), cout=>wires(417));
	
	f221: fa port map(a =>wires(416), b=>l1r17(28), cin=>wires(411), s=>wires(418), cout=>wires(419));
	
	f222: fa port map(a =>wires(418), b=>wires(413), cin=>wires(415), s=>arg1(28), cout=>arg2(29));
	
	--c30
	f223: fa port map(a =>l1r1(29), b=>l1r16(29), cin=>l1r17(29), s=>wires(420), cout=>wires(421));
	
	f224: fa port map(a =>wires(420), b=>wires(417), cin=>wires(419), s=>arg1(29), cout=>arg2(30));
	
	--c31
	f225: fa port map(a =>l1r1(30), b=>l1r17(30), cin=>wires(421), s=>arg1(30), cout=>arg2(31));
	
	arg1(31) <= l1r1(31);
	
	bkadder: adder_32b port map(a => arg1, b =>arg2, cin=>gnd_signal, s=>s, cout=>cout);
	
end struct;