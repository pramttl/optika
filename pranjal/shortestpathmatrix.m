% Shortest path Matrix Solver on LEE's algorithm, takes start pont, end point & matrix with safe and unsafe points.

% mat is the matrix with + as the allowed positions and - as the restrictions defined globally.
% start : [1 X 2] array having index of starting cell.
% dest : [1 X 2] array having index of ending cell or destination.

function[mat pathlength] = shortestpathmatrix(start,dest,mat)
	dest_x = dest(1,1);
	dest_y = dest(1,2);
	
	dest_in_wavepoints = 0; 	            % flag value, to be set to 1, if dest point exists in the wavepoint set.
	%{t} loopctr = 0;
	pathlength = 0;
	
	[wavepoints,mat] = markwavepoints(start,mat); % wavepoints is an array of those points having the same number (latest) in the wave chain.
		
	while(1)
		pathlength = pathlength + 1;
		
		%% Code to Check whether dest (DESTINATION point) exists in wavepoints (set of points) goes here %%
		[n dummy] = size(wavepoints);
		for i=1:n
			if (wavepoints(i,1) == dest_x && wavepoints(i,2) == dest_y)
				dest_in_wavepoints = 1;
			end
		end
		if dest_in_wavepoints;
			break;
		else
			[wavepoints,mat] = markwavepoints(wavepoints,mat);		
		end
	end
	mat(start(1,1),start(1,2))=0; % To make starting cell = 0
	
	