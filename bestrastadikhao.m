% This function UNLIKE the rastadikhao function shows the best possible rasta, taking any matrix as input.

% path_points : This holds the set of all the points of the shortest path ,in order till the destination (starting point excluded, destination included)

function[path_points pathlength] = bestrastadikhao(start,dest,mat)
	
	global ERROR_VAL INFINITY;	
	
	%{c} Set this to 0 if you don't want start point in the path_points being returned, else set to 1. But take care, other functions where this is used might already
	% --be assuming that start point is returned.
	INCLUDE_START_POINT = 1; 
	
	[shortestpathmat pathlength]= shortestpathmatrix(start,dest,mat); % shortestpathmat or the LEE Matrix.
	
	path_points = zeros(pathlength + INCLUDE_START_POINT,2);
	path_cell = [dest(1) dest(2)];
	
	% If pathlength is infinity =>s PATH is blocked.
	if (pathlength == INFINITY)
		return;
	end
	
	% To backtrace the shortest path from the detsination according to the idea of the algorithm in use.
	for i=1:pathlength		
		path_points(pathlength + INCLUDE_START_POINT - i + 1 , 1) = path_cell(1);
		path_points(pathlength + INCLUDE_START_POINT - i + 1 , 2) = path_cell(2);
		
		if (i == 1)
			path_cell = adjacentpntchk(dest,shortestpathmat);
		else
			path_cell = adjacentpntchk(path_cell,shortestpathmat);
		end
	end
	
	% To set the first (x,y) point in the array being returned to the start position.
	if (INCLUDE_START_POINT)
		path_points(1,1) =  start(1);
		path_points(1,2) =  start(2);
	end