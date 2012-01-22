% Function to check the adjacent cells for a value that is 1 more than the value at the current cell & return the position of that cell.
% This is useful to retrace the path from the start point to the end.

function [path_cell_position] = adjacentpntchk(start_cell,mat)	
	cell_x = start_cell(1);
	cell_y = start_cell(2);
	val_at_cell = mat(cell_x,cell_y);
	
	% path_cell_position = [0 0]; % Initialisation
	
	for p = -1:1
		for q = -1:1

			% wavepoints(i,1) = X coordinate of ith point in wavepoints.

			% Condition to check whether adjacent elemet is in the boundaries of teh 6 X 6 matrix.
				% boundary_condn : cell(1,1)+p ~= 0 && cell(1,2)+q ~= 0 && cell(1,1)+p ~= 7 && cell(1,2)+q ~= 7;
			
			% Condition to check whether the adjacent cell is safe, ie. has a 0
				% safety_condn : mat(cell(1,1)+p, cell(2,2)+q) == 0 ;
				
			% total_condn = p~=q && boundary_condn && safety_condn (This condition is used in the next if)
			
			if(	abs(p) ~= abs(q) && (cell_x + p) ~= 0 && (cell_y + q) ~= 0 && (cell_x + p) ~= 7 && (cell_y + q ~= 7) && mat(cell_x + p, cell_y + q) == (val_at_cell + 1))  
				path_cell_position = [(cell_x + p),(cell_y + q)];
			end
			
		end
	end