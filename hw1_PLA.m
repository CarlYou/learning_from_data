function PLA(N, times)
	%-----------------------------
	%Perceptron Learning Algorithm
	%-----------------------------
	%Usage:	PLA(N, times)
	%
	%Arguments:
	%	N:
	%		number of samples
	%	times:
	%		excute times

	N     = 100;
	times = 1000;

	sum = [0, 0];
	for i = 1:times
		[cnt, err] = proc(N);
		sum = sum + [cnt, err];
	end
	sum/times
end

function [cnt, err] = proc(N)

	A = randomPoints(1);
	B = randomPoints(1);
	X = randomPoints(N);
	Y = calcSign(A, B, X);

%	axis([-1, 1, -1, 1])
%	hold on;
%	plotLine(A, B);
%	plotPoint(X, Y);


	W = zeros(1, 3);
	cnt = 0;
	while true
		idx = randi(N);
		if idx == N
			i = 1;
		else
			i = idx + 1;
		end

		while true
			val = W(1) + X(i,1)*W(2) + X(i,2)*W(3);
			if val < 0
				sgn = -1;
			else
				sgn = 1;
			end
			
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
			W = W + [1, X(i,:)] * Y(i);
			cnt = cnt + 1;
			[cnt, i, X(i,:), W, 0, sgn, Y(i)];
		%	syms x y;
		%	f(x, y) = W(1) + x*W(2) + y*W(3);
		%	hold on;
		%	ezplot(f);
		end
		%if cnt > 100
		%	disp 'error'
		%	break;
		%end
	end
	err = Eout(W, A, B, 1000);
%	syms x y;
%	f(x, y) = W(1) + x*W(2) + y*W(3);
%	hold on;
%	h = ezplot(f);
%	set(h, 'Color', 'red');
end

function err = Eout(W, A, B, n)
	%Approximate the probability for P(h(x) != f(x))
	%	n: size of test set
	X = randomPoints(n);
	Y = calcSign(A, B, X);
	num = 0;
	for i = 1:n
		val = W(1) + X(i,1)*W(2) + X(i,2)*W(3);
		if val < 0
			sgn = -1;
		else
			sgn = 1;
		end

		if sgn ~= Y(i)
			num = num + 1;
		end
	end
	err = num / n;
end

function plotLine(A, B)
	syms x y;
	f(x, y) = (x-A(1))*(y-B(2)) - (x-B(1))*(y-A(2));
	h = ezplot(f);
	set(h, 'Color', 'blue');
	plot(A(1), A(2), 'b+');
	plot(B(1), B(2), 'b+');
end

function plotPoint(X, Y)
	n = size(X, 1)
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
