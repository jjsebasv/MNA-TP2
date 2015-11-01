% Data Base voices are one of each individual
% Test voices are the one to be compared
% coef -> 0.97
% frBase1 -> 0.02
% frBase2 -> 0.01
% components -> 26

function main
	% Data base voices are read and 16 vectors per voice are saved
	f = readdir(strcat(pwd,'/Voices/Data Base'));
	speaker_num = numel(f);
	for i = 3:speaker_num
		file = char(f(i));
		[signal,fm] = wavread(strcat('./Voices/Data Base/', file));
		coef = melFreqCep (fm, signal, coef=.97, frBase1=.02, frBase2=.01, components=26);
		vector_code(:,:,i-2) = vq(coef, 16);
		% This depends on how the files are saved [file name]
		names{i-2} = ;
	endfor
	
	speaker_num = speaker_num - 2;
	corrects = 0;
	
	% Tests voices are compared with the ones in the data base
	f = readdir(strcat(pwd,'/Voices/Test'));
	recordings = numel(f);
	for i = 3:recordings;
		file = char(f(i));
		[signal,fm] = wavread(strcat('./Voices/Test/', file));
		coef = melFreqCep (fm, signal, coef=.97, frBase1=.02, frBase2=.01, components=26);

		talker = substr(file, 1, -6);
		
		for j = 1:speaker_num
			mean = meandist(coef, vector_code(:,:,j));
			if(j == 1)
				min = [1, mean];
			endif
			
			if(mean < min(2))
				min = [j, mean];
			endif
		endfor
		
		printf("La grabacion es de %s y se identifico a %s\n", talker, names{min(1)})
		corrects = corrects + strcmp(names{min(1)}, talker);
	endfor
	
	recordings = recordings - 2;
	eff = (corrects / recordings) * 100
	printf("La eficiencia del sistema es del %f por ciento\n", eff);
endfunction

