% This funciton takes start,destination, shortestpathlength, shortestpathmat (ie. like the matrix returned by the shortestpathmatrix() function, Returns the set of points in the shortest path, in order.
% path_points : This holds the set of all the points of the shortest path ,in order till the destination (including destination) & starting point is included iff (INCLUDE_START_POINT is set = 1)

function[path_points] = rastadikhao(start,dest,shortestpathlength,shortestpathmat)
	
	%{c} Set this to 0 if you don't want start point in the path_points being returned, else set to 1. But take care, other functions where this is used might already
	% --be assuming that start point is returned.
	INCLUDE_START_POINT = 1; 

	path_points = zeros(shortestpathlength + INCLUDE_START_POINT,2);
	path_cell = [dest(1) dest(2)];
	
	%To backtrace the shortest path from the detsination according to the idea of the algorithm in use.
	for i=1:shortestpathlength
		path_points(shortestpathlength + INCLUDE_START_POINT  - i + 1 , 1) = path_cell(1);
		path_points(shortestpathlength + INCLUDE_START_POINT  - i + 1 , 2) = path_cell(2);
		
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