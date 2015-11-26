function fourier_frame = my_fft (y)
	N = length(y);
	T = 2^ceil(log2(N));
	z = zeros(1,T);
	for k = 1 : T
		sum = 0; % All over again
	    for ii = 1 : N
	        sum = sum + y(ii)*exp(-2*pi*j*(ii-1)*(k-1)/T);
		end
		z(k) = sum;
	end
	fourier_frame = z;
endfunction