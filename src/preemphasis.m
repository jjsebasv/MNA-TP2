function s_output =  preemphasis (s_input,a)
	s_output(1)=s_input(1);
	for k=2:length(s_input)
		s_output(k)=s_input(k)-a*s_input(k-1);
	end
end