function [number] = greenRegion(im)
	[m n t] = size(im);
	bw = zeros(m,n);
	for i = 1:m
		for j = 1:n
			if(im(i,j,1)<0.05 && im(i,j,2)> 0.9 && im(i,j,3)<0.05)
				bw(i,j) = 1;
			end
		end
	end
	
	bw = bwareaopen(bw,200);
	bw = imfill(bw,'holes');

	[L NUM] = bwlabel(bw);
	if NUM == 0
		number = 0;
		return;
	else
		number = 5;
		return;
	end
	
	