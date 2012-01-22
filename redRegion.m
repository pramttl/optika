function a = redRegion(im)
	[m n t] = size(im);
	bw = zeros(m,n);
	for i = 1:m
		for j = 1:n
			if(im(i,j,1)>0.9 && im(i,j,2)<0.05 && im(i,j,3)<0.05)
				bw(i,j) = 1;
			end
		end
	end
	bw = bwareaopen(bw,200);
	bw = imfill(bw,'holes');

	[L NUM] = bwlabel(bw);
	if NUM == 0
		a = 0;
		return;
	end

	stats = regionprops(L,'Area','BoundingBox');
	bb = stats.BoundingBox;
	area_bb = ((bb(1,3))*(bb(1,4)));
	area = stats.Area;
	if area_bb < (4/pi)*area
		a = 4;
	end
	if area_bb > (4/pi)*area
		a = 3;
	end
