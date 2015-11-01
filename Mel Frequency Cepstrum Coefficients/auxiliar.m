
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
    lowmel = hztoml(n);
    highmel = hztoml(fm/2);

    npoints = nfilt + 2;
    step = (highmel-lowmel)/(npoints-1);
    melpoints = lowmel:step:highmel;
    
    bin = floor((samples+1)*arrayfun(@mltohz,melpoints)/fm);

    fbank = zeros(nfilt,samples/2+1);

    for j = 1 : nfilt
        fstart = bin(j);
        fend = bin(j+1);
        for k = fstart:fend
            fbank(j,k) = (k - bin(j))/(bin(j+1)-bin(j));
        end
        fstart = bin(j+1);
        fend = bin(j+2);
        for k = fstart:fend
            fbank(j,k) = (bin(j+2)-k)/(bin(j+2)-bin(j+1));
        end
    end
endfunction

function m = hztoml(a)
	m = 1127 * log(1+a/700.0);
endfunction

function h = mltohz(a)
	h = 700*(10^(a/2595.0)-1);
endfunction

% 6 - Get the coefs 
function mel_signal = mel_cepstrum(signal)
	K = rows(signal);
	for n = 1:12
		aux = 0;
		for k = 1:K
			aux = aux + log(signal(k,1)) * cos(n * (k - 0.5) * pi / K);
		endfor
		cn(n) = aux;
	endfor
	mel_signal = cn';
endfunction

function log_signal = log_energy(signal)
	s = 0;
	for n = 1:160
		s = s + signal(n) ** 2;
	endfor
	log_signal = log10(s);
endfunction

% 7 - Get delta coefs
% from [general]
function deltas = delta_coefs(coef)
	delta = coef;
	delta(1) = (coef(2) - coef(1) + 2 (coef(3) - coef(1))) / 10
	delta(2) = (coef(3) - coef(2) + 2 (coef(4) - coef(2))) / 10
	for n 3:11
		delta(n) = (coef(n+1) - coef(n-1) +2 (coef(n+2) - coef(n-2))) / 10
	endeltafor
	delta(12) = (coef(13) - coef(11) + 2 (coef(13) - coef(10))) / 10
	delta(13) = (coef(13) - coef(12) + 2 (coef(13) - coef(11))) / 10
endfunction

% from [d2]
function deltas = delta_coefs_2(coef)
	delta = coef;
	for i 1:13
		sum = 0;
		for n 1:13
			sum = sum + (coef(n+i) - coef(n-i)) / (2*n);
		endfor
		delta(i) = sum;
	endfor
	deltas = delta;
endfucntion 