% Function takes the start / current point , the nearest object (represented by obj_numbr) to be looked for , object matrix &
% Returns the array of points leading to the nearest object.
% object : Indicated by a negative number, ie. -1 => Blue mine, -2 => Blue Kit, -3 => Red Mine, -4 => Red ,Green Lifeline => -5

function[path_points] = nearestobjectpath(start,obj_numbr,mat)

	global ERROR_VAL INFINITY;
	
	obj_positions = findobjectpositions(obj_numbr,mat); % Holds all the positions of the given object number.
	
	[nofpoints dummy] = size(obj_positions);
	
		%% TEST LINES : NOT SURE %%
		for i=1:nofpoints		
			mat(obj_positions(i,1),obj_positions(i,2)) = 0; % Since after the diffusion kit is taken all the corresponding bomb sites become safe.
		end
	
	%%********** Code to find the closest destination to the start point. *********************************************************************%%
	
		oldpathlength = 36; % Initialise to the Largest Possible Value or Worst Case Value of path that can exist between source and destination.
		for i=1:nofpoints		
			dest(1) = obj_positions(i,1);
			dest(2) = obj_positions(i,2);
			
			if (dest == start)
				continue;
			end
			
			[temp_mat temp_pathlength] = shortestpathmatrix(start,dest,mat); % Returns shortestpathmat or the LEE Matrix & the Length of the shortest path.
			
			% Finding nearest destination (according to feasible / shortest path)
			if (temp_pathlength < oldpathlength)
				closest_dest = dest;
				shortestpathmat = temp_mat;
				shortestpathlength = temp_pathlength;
			end
			oldpathlength = temp_pathlength;
		end

		clear('temp_pathlength','temp_mat','dest'); % To flush these variables from the memory.
		
		%{t} closest_dest
		%{t} shortestpathmat
	%%******************************************************************************************************************************************%%
	% shortestpathlength : now holds thlene length of the path to the closest destination.
	% closest_dest : holds our desired destination
	% shortestpathmat : holds the LEE matrix for this case.
	
	%%********** Code to backtrace the path from the destination. *********************************************************************%%
	if (shortestpathlength ~= INFINITY)
		path_points = rastadikhao(start,closest_dest,shortestpathlength,shortestpathmat);
	elseif (shortestpathlength == INFINITY)
		path_points = ERROR_VAL; % Indicating there are no paths at all. Agar nearest object hi INFINITY duri par hai matlab, koi path nahin hai.
	end