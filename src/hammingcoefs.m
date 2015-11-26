function hcoef = hammingcoefs(N)
	hcoef = zeros(N,1);
	for n=1:N
		hcoef(n)=.54-.46*cos(2*pi*(n-1)/(N-1));
	end
end
