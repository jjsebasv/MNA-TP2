function E = loggedenergy(sn)
	s = 0;
	for n = 1:160
		s = s + sn(n)^2;
	end
	E = log10(s);
endfunction