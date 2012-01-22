%% Takes a <something> X 2 array of 2-D points as input and STRIPS OUT UNNECESSARY (0,0)s  & returns the cropped Array

function[cropped_array] = purge_useless_points(array)
	
	[nofpoints dummy] = size(array);
	
	t = nofpoints;
	for i=1:nofpoints
		if (array(i,1) == 0 && array(i,2) == 0)
			t = i-1;
			break;
		end
	end
	% Now t has an exact count of the useful points.
	
	% t will NOT be equal to nofpoints IF there are any trailing (0,0)'s or say useless points.
	
	if (t ~= nofpoints)
		for i=1:t
			cropped_array(i,1) = array(i,1);
			cropped_array(i,2) = array(i,2);
		end
	else
		cropped_array = array;
	end
	% This code could have been more simple & reduced, in size but has been written like this to reduce time complexity. :)