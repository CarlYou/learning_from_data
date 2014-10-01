function hw2p1()
	s_min = 0;
	times = 100000;
	for i = 1:times
		N = 1000;
		T = 10;

		X = randi(2, N, T);
		X = X - 1;
		S = sum(X, 2);

		n_1    = 1;
		c_1    = S(n_1);
		v_1    = c_1 / 10;
		n_rand = randi(N);
		c_rand = S(n_rand);
		v_rand = c_rand / 10;
		[c_min, n_min] = min(S);
		v_min = c_min / 10;
		s_min = s_min + v_min;
	end
	disp(s_min/times);
end
