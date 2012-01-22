% This function takes a set of points called wavepoints, updates a matrix.........blah ..blah....
% This is done to make the matrix go more close to the final desired LEE MATRIX.

function[updated_wavepoints, mat] = markwavepoints(wavepoints,mat)
	
	global ERROR_VAL INFINITY;
	
	%{t}wavepoints = purge_useless_points(wavepoints);	
	%{t} [t dummy] = size(wavepoints);	
	%********************************************* ^ TEST CODE > *******************************************%
		[t dummy] = size(wavepoints);	
		% t takes into counting a lot of (0,0) points, the actual no. of points are less, evaluated by the following lines of code.
		for i=1:t
			if (wavepoints(i,1) == 0 && wavepoints(i,2) == 0)
				t = i-1;
				break;
			end
		end
		% Now t has an exact count of the actual number of points passed in.	
	%*******************************************************************************************************%
	
	MAX_WAVEPOINTS = 10; %{c} Calibrate according to need.
	updated_wavepoints = zeros(MAX_WAVEPOINTS,2); % This 2-D struc array will store the updated wave points.
	AT_LEAST_ONE_NEW_WAVEPOINT = 0; % This varibale makes this code more meticulous, since it makes it useful to check if the path actually exists or is blocked.
	
	k = 1;
	for i = 1:t
		for p = -1:1
			for q = -1:1

				% wavepoints(i,1) = X coordinate of ith point in wavepoints.

				% Condition to check whether adjacent elemet is in the boundaries of teh 6 X 6 matrix.
					% boundary_condn : wavepoints(i,1)+p ~= 0 && wavepoints(i,2)+q ~= 0 && wavepoints(i,1)+p ~= 7 && wavepoints(i,2)+q ~= 7;
				
				% Condition to check whether the adjacent cell is safe, ie. has a 0
					% safety_condn : mat(wavepoints(i,1)+p, wavepoints(i,2)+q) == 0 ;
					
				% total_condn = p~=q && boundary_condn && safety_condn (This condition is used in the next if)
				
				if(	abs(p) ~= abs(q) && (wavepoints(i,1)+p) ~= 0 && (wavepoints(i,2)+q) ~= 0 && (wavepoints(i,1)+p) ~= 7 && (wavepoints(i,2)+q ~= 7) && mat(wavepoints(i,1)+p, wavepoints(i,2)+q) == 0)  
							
					 mat(wavepoints(i,1)+p, wavepoints(i,2)+q) = (mat(wavepoints(i,1), wavepoints(i,2))) + 1; % To update the Matrix.
					 
					 updated_wavepoints(k,1) = wavepoints(i,1) + p;
					 updated_wavepoints(k,2) = wavepoints(i,2) + q;
					 k = k + 1;
					 
					 AT_LEAST_ONE_NEW_WAVEPOINT = 1; % or say PATH_BLOCKED = 1
				end
			
			end
		end
	end
	
	if (AT_LEAST_ONE_NEW_WAVEPOINT == 0)  % or say PATH_BLOCKED :/
		updated_wavepoints = ERROR_VAL; % Indicating that NO wavepoint have been updated. or path is blocked.
	end
	clear('AT_LEAST_ONE_NEW_WAVEPOINT');