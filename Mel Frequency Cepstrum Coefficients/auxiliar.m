
% 1 - Pre Emphasis
function pe_signal = pre_emph(signal, coef)
	pe_signal(1) = signal;
	for i = 2:length(signal)
		pe_signal(i) = signal(i) - coef * signal(i-1);
	endfor
endfunction

% 2 - Fragmenting 
function f_signal = fragmenting(signal, fm, frBase2, frBase1)
	N = frBase2 * fm;						% Ammount of samples
	M = floor((length(signal) - N) / frag_step + 1 );

	frag_step = frBase1 * fm;				% Step between samples
	index_frames = frag_step * [0:(M-1)];	% Index per frames
	index_samples = [1:N].';				% Index per samples
	
	index = index_frames(ones(N,1),:) + index_samples(:,ones(1,M));

	f_signal = signal(index);
endfunction

% 3 - Hamming Window
function w = hamming_window(samples)
	w = .54 - .46*cos(2*pi*(0:M-1)'/(M-1));
endfunction

% 4 - Fast Forward Fourier Transform
function fourier_frame = my_fft (y)
	N = length(y);
	T = 2^ceil(log2(N));
	z = zeros(1,T);
	Sum = 0;
	for k = 1 : T
	    for ii = 1 : N
	        Sum = Sum + y(ii)*exp(-2*pi*j*(ii-1)*(k-1)/T);
		end
	z(k) = Sum;
	Sum = 0; % All over again
	end
	fourier_frame = z;
endfunction

% 5 - Filterbanks multiplication
function pr = get_filterbanks(samples, fm, componets, n)
	
