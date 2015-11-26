%% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%Par ́ametros de entrada:
%* data = dataset
%* code = code vectors de un individuo
%
%Par ́ametros de salida:
%on media* dist = distorsi ́
function dist = meandist(data,code)
	[dim,n] = size(data);
	[dim,nvector] = size(code);
	dist = 0;
	for l = 1:n
		%busco la m ́ınima distancia/distorsi ́on de cada columna
		distances = norm(repmat(data(:,l),1,nvector)-code,2,'columns');
		[m,i] = min(distances);
		dist = dist+m;
	end
	dist = dist/n;
endfunction