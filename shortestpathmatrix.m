% Shortest path Matrix Solver on LEE's algorithm, takes start pont, end point & matrix with safe and unsafe points.
% It returns the shortest path Matrix which indicates the route from start to destination if it exists , and the corresponding pathlength.
% The path is indicated by ANY POSITUVE NUMBER SEQUENCE IN THE MATRIX, -ve numbers indicate positions of other objects, or unsafe points. 
% If there is no safe path, path_length returned will be greater than the max path length possible ie. 36. Here it is set to INFINITY as defined in the beginning of the funciton.

% mat is the matrix with 0's as the allowed/safe positions and other numbers as the restrictions defined globally.
% start : [1 X 2] array having index of starting cell.
% dest : [1 X 2] array having index of ending cell or destination.

function[mat pathlength] = shortestpathmatrix(start,dest,mat)
	
	global ERROR_VAL INFINITY; % Use infinity as set in the main program: main.m , which signifies larger than the largest value we would actually require in cases.
	
	dest_x = dest(1,1);
	dest_y = dest(1,2);
	
	dest_in_wavepoints = 0; 	            % flag value, to be set to 1, if dest point exists in the wavepoint set.
	pathlength = 0;                         % Basically Loop Counter only, The no. of times the loop executes gives the path.
	PATH_BLOCKED = 0;
	
	[wavepoints,mat] = markwavepoints(start,mat); % wavepoints is an array of those points having the same number (latest) in the wave chain.
	
	if wavepoints == ERROR_VAL
		PATH_BLOCKED = 1;
	end
	
	while(1)
		
		if PATH_BLOCKED
			break; % No need to run loop if PATH is blocked ahead.
		end
		
		pathlength = pathlength + 1;
		
		%% Code to Check whether dest (DESTINATION point) exists in wavepoints (set of points) goes here %%
		[n dummy] = size(wavepoints);
		
		% Checking whether destination exists in the wavepoints wala set.
		for i=1:n
			if (wavepoints(i,1) == dest_x && wavepoints(i,2) == dest_y)
				dest_in_wavepoints = 1;
			end
		end
		
		if dest_in_wavepoints;
			break; % If destination exists in the current wavepoints, this means the path to the destination has been found theoritically, so we can stop looking for it.
		else
			[wavepoints,mat] = markwavepoints(wavepoints,mat); %If destination doesn't exist in the current wavepoints set, we have to find the next set of wavepoints.	
		
			%% Code to find whether path is blocked or not.
			if (wavepoints == ERROR_VAL) % ie. No wavepoints were found, IMPLYING that destination is BLOCKED by unwanted stuff (-ve numbers) :/
				pathlength = INFINITY; % Some number greater than the max possible path length, meaning that the path is INFINITE or blocked.
				PATH_BLOCKED = 1; % Indicates blocked path, or no path to route.
				break;
			end
			
		end
	end
	mat(start(1,1),start(1,2))=0; % To make starting cell = 0
	
	