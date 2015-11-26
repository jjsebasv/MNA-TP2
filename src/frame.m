function r = frame(s, fs, fd, fi)
	N = fd * fs;									% cantidad de muestras
	fstep = fi * fs;								% step entre cada una
	M = floor((length(s) - N) / fstep + 1);
	
	indf = fstep*[ 0:(M-1) ];						% indices por frames      
    inds = [ 1:N ].';								% indices por muestra
    ind = indf(ones(N,1),:) + inds(:,ones(1,M));
	r = s(ind);
end