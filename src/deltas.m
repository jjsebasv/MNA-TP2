function delt = deltas(c,tamount)
	delt = c;
	delt(1) = (2*(c(3)-c(1)) + (c(2)-c(1))) / 10;
	delt(2) = (2*(c(4)-c(1)) + (c(3)-c(1))) / 10;
	for t = 3:tamount-2
		delt(t) = (2*(c(t+2)-c(t-2)) + (c(t+1)-c(t-1))) / 10;
	end
	delt(tamount-1) = (2*(c(tamount)-c(tamount-3)) + (c(tamount)-c(tamount-2))) / 10;
	delt(tamount) = (2*(c(tamount)-c(tamount-2)) + (c(tamount)-c(tamount-1))) / 10;
end