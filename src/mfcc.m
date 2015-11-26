function m = mfcc(s,f)
	a = 0.97;

	% 1- Pre-emphasis
	s = preemphasis(s,a);
	
	% 2- Framing
	frames = frame(s,f,0.02,0.01);
	
	% 3- Hammming windows
	f
	N = f*0.02
	fnum = columns(frames)
	h = hammingcoefs(N);

	hframes = frames.*h;
	
	% 4- FFT
	for k = 1:fnum
		fftframes(:,k) = fft(hframes(:, k));
	end
	
	% 5- Filter Bank
	for k = 1:fnum
		pframes(:,k) = (abs(fftframes(:,k)).^2);
	end
	fbanks = filterbanks(26,N,f,300);

	half = N/2 + 1;
	pr = fbanks * pframes(1:half, :);
	
	% 6- Cepstrum
	% Se obtienen los primeros 12 coeficientes cepstrum

	for k = 1:fnum
		cn(:,k) = cepstrum(pr(:,k),13);
	end
	
	% Se obtiene el 13º coeficiente
	for k = k:fnum
		cn(13,k) = loggedenergy(frames(:,k));
	end
	
	% 7- Deltas
	% Se calculan los coeficientes delta
	for k = 1:fnum
		d = deltas(cn(:,k),13);
		for j = 1:13
			cn(j+13,k) = d(j);
		end
	end
	
	m = cn;
	

	
end