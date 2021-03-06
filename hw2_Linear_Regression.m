function LR(N, times)
	%-----------------------------
	%Linear Regression for hw2 p5-7
	%-----------------------------
	%Usage:	linearRegression(N, times)
	%
	%Arguments:
	%	N:
	%		number of samples
	%	times:
	%		excute times
	N     = 10;
	times = 1000;

	sum = 0;
	for i = 1:times
		ret = proc(N);
		sum = sum + ret;
	end
	sum/times
end

function ret = proc(N)

	A = randomPoints(1);
	B = randomPoints(1);
	P = randomPoints(N);
	Y = calcSign(A, B, P);
	X = [ones(N,1),P];
	X_dagger = inv((X')*X) * (X');
	W = X_dagger * Y;
	%ret = Ein(X, Y, W);

	%axis([-1, 1, -1, 1])
	%hold on;
	%plotLine(A, B);
	%plotPoint(P, Y);
	%[x, y] = deal([]);
	%syms x y;
	%f(x, y) = W(1) + x*W(2) + y*W(3);
	%h = ezplot(f);
	%set(h, 'Color', 'red');

	ret = PLA();

	%f(x, y) = W(1) + x*W(2) + y*W(3);
	%h = ezplot(f);
	%set(h, 'Color', 'green');

	function cnt = PLA()
		cnt = 0;
		while true
			idx = randi(N);
			if idx == N
				i = 1;
			else
				i = idx + 1;
			end

			while true
				val = X(i,:) * W;
				sgn = (val > 0) * 2 - 1;
				if sgn ~= Y(i)
					break;
				elseif i == idx
					i = 0;
					break;
				elseif i == N
					i = 1;
				else
					i = i + 1;
				end
			end
			if i == 0
				break;
			else
				W = W + X(i,:)' * Y(i);
				cnt = cnt + 1;
			end
		end
	end
end

function err = Eout(W, A, B, N) %n=1000
	P = randomPoints(N);
	Y = calcSign(A, B, P);
	X = [ones(N,1),P];
	XX  = X * W;
	h_X = (XX > 0) .* 2 - 1;
	err = sum(h_X ~= Y) / size(X, 1);
end

function err = Ein(X, Y, W)
	XX  = X * W;
	h_X = (XX > 0) .* 2 - 1;
	err = sum(h_X ~= Y) / size(X, 1);
end

function Y = calcSign(A, B, X)
	n = size(X, 1);
	Y = zeros(n, 1);
	for i = 1:n
		T = cross([A-X(i,:), 0], [B-X(i,:), 0]);
		if T(3) < 0
			Y(i) = 1;
		else
			Y(i) = -1;
		end
	end
end

function P = randomPoints(n)
	low = -1;
	up  = 1;
	P = unifrnd(low, up, n, 2);
end

function plotLine(A, B)
	syms x y;
	f(x, y) = (x-A(1))*(y-B(2)) - (x-B(1))*(y-A(2));
	h = ezplot(f);
	set(h, 'Color', 'blue');
	plot(A(1), A(2), 'b+');
	plot(B(1), B(2), 'b+');
end

function plotPoint3(X, Y)
	n = size(X, 1);
	for i = 1:n
		if Y(i) < 0
			style = 'rx';
		elseif Y(i) > 0
			style = 'go';
		else
			style = 'b*';
		end
		plot3(X(i,1), X(i,2), Y(i), style);
	end
end

function plotPoint(X, Y)
	n = size(X, 1);
	for i = 1:n
		if Y(i) < 0
			style = 'rx';
		elseif Y(i) > 0
			style = 'go';
		else
			style = 'b*';
		end
		plot(X(i,1), X(i,2), style);
	end
end
