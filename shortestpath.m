% path_points : This holds the set of all the points of the shortest path ,in order till the destination (starting point excluded, destination included)

function[path_points pathlength] = shortestpathpoints(start,dest,mat)
	
	[shortestpathmat pathlength]= shortestpathmatrix(start,dest,mat) % shortestpathmat or the LEE Matrix.
	path_points = zeros(pathlength,2);
	path_cell = [dest(1) dest(2)];
	
	% To backtrace the shortest path from the detsination according to the idea of the algorithm in use.
	for i=1:pathlength		
		path_points(pathlength - i + 1 , 1) = path_cell(1);
		path_points(pathlength - i + 1 , 2) = path_cell(2);
		
		if (i == 1)
			path_cell = adjacentpntchk(dest,shortestpathmat);
		else
			path_cell = adjacentpntchk(path_cell,shortestpathmat);
		end
	end