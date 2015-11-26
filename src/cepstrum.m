function cn = cepstrum(s,tamount)
	K = rows(s);
	for n = 1:tamount
		aux = 0;
		for k = 1:K
			aux = aux + log(s(k,1)) * cos(n*(k-0.5)*pi/K);
		end
		cn(n) = aux;
	end
	cn = cn';
end