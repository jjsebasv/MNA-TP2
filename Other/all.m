

%Fourier Transform of Sound File -- Used [1]

%Load File
file = 'C:\MATLAB7\work\tuning_fork_A4';
[y,fm,bits] = wavread(file);   % Must be wav file - No compresion 

N = length(y);			  % Where N is # of samps
t = (1/fm)*(1:N)          % Prepare time data for plot

%Do Fourier Transform
y_fft = abs(my_fft(y));         %Retain Magnitude
y_fft = y_fft(1:N/2);      %Discard Half of Points
f = fm*(0:N/2-1)/N;   %Prepare freq data for plot

% My Fourier transform where y is a signal -- Used [2]
function A = my_fft (y)
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
return

% M is window length -- Used [3]
function w = triag_overlap_window (M)
	R = (M-1)/2;     % hop size
	N = 3*M;         % overlap-add span
	w = hammingWindow(M);  % window
	z = zeros(N,1);  plot(z,'-k');  hold on;  s = z;
	for so=0:R:N-M
	  actual_point = so+1:so+M;        			% current window location
	  s(actual_point) = s(actual_point) + w;    % window overlap-add
	  % for plot
	  wzp = z; wzp(actual_point) = w; 
	  plot(wzp,'--ok');       % plot actual window
	end
	plot(s,'ok');  hold off;  % plot the overlapped
end

% M is window length
function w = hammingWindow (M)
	w = .54 - .46*cos(2*pi*(0:M-1)'/(M-1));
end

% ToDo



% How to - Plots

% --Time Domain
figure
plot(t, y)
xlabel('Time (s)')
ylabel('Amplitude')
title('Tuning Fork A4 in Time Domain')

% --Frequency Domain
figure
plot(f, y_fft)
xlim([0 1000])
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('Frequency Response of Tuning Fork A4')
