% Mel-Frequency Cepstrum Coeficients 
% coef -> 0.97
% frBase1 -> 0.02
% frBase2 -> 0.01
% components -> 26

function coefs = melFreqCep (fm, signal, coef, frBase1, frBase2, components)
	% 1 - Get the pre emphasis - What is it and why is important [d1]
	signal = pre_emph(signal, coef);

	% 2 - Signal Fragmenting
	sig_frames = fragmenting(signal, fm, frBase2, frBase1);

	% 3 - Hamming Window
	samples = size(sig_frames)(1);		% window length
	frames_cant = size(sig_frames)(2);
	hw = hamming_window(samples);
	hf = signal_frames.*hw;	

	% 4 - Fast Forward Fourier Transform
	for i = 1:frames_cant
		fourier_frames(:,i) = my_fft(hf(:,1));
	endfor

	% 5 - Filterbanks multiplication
	for i = 1:frames_cant
		filterbank_frames(:,i) = (abs(my_fft(hf(:,1))).^2);
	endfor

	filterbanks = get_filterbanks(samples, fm, components, 300);
	%todo
		%get_filterbanks(samples, fm, componets, n)

	pr = filterbank_frames(1:(samples/2 + 1),:) * filterbank;

	% 6 - Get the coefs 
	for i = 1:frames_cant						% first 12
		coef_n(:,i) = mel_cepstrum(pr(:,1));
	endfor 

	for i = 1:frames_cant						% 13th
		coef_n(13,i) = log_energy(sig_frames(:,i));
	endfor

	%todo
		% mel_cepstrum(signal)
		% log_energy(sisnal)

	% 7 - Get delta coefs
	for i = 1:frames_cant
		d = deltas(coef_n(:,1));
		for j = 1:13
			coef_n(j + 13,i) = d(j);
		endfor
	endfor

	%todo
		%deltas(coef)

	coefs = coef_n;
endfunction 
