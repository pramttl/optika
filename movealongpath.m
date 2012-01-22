% This function takes a <something> X 2 set of points, and makes the bot move along that path, it assumes the set of pints includes START & DESTINATIOn.

function[updated_position] = movealongpath(path_points)
	
	[nofpoints dummy] = size(path_points);
	
	global ser;
	global movement_counter; % Use the movement counter defined globally in main.m
	global last_move; % Variable used to record the direction in which the bot is currently my making a note of its last made move (not very useful as of now.)
	global lifeline_position_x lifeline_position_y LIFELINE_TAKEN;
	movement_counter = movement_counter + (nofpoints-1); % To tell how many cells has moved at any stage in the main program : main.m
	
	for i=1:(nofpoints-1)
		c_x = path_points(i+1 ,1) - path_points(i,1);
		c_y = path_points(i+1 ,2) - path_points(i,2);
		
		%If you chance upon the position where the lifeline is and it has not been taken yet, then take it , ie. glow the led & give a pause.
		if (LIFELINE_TAKEN == 0 && path_points(i,1) == lifeline_position_x && path_points(i,2) == lifeline_position_y)
			disp('Just chanced upon the lifeline, so taking it :p')
			LIFELINE_TAKEN = 1;
			%{ser} fwrite(ser,'g');
		end
		
			if c_x == 0 && c_y == 1
				disp('Right')
				last_move = 2;
				fwrite(ser,'r')
			elseif c_x == 0 && c_y == -1
				disp('Left')
				last_move = 4;
				fwrite(ser,'l')
			elseif c_x == -1 && c_y == 0
				disp('Up')
				last_move = 1;
				fwrite(ser,'u')
			elseif c_x == 1 && c_y == 0
				disp('Down')
				last_move = 3;
				fwrite(ser,'d')
			end
		end
	
	updated_position = zeros(1,2);
	updated_position(1) = path_points(i+1 ,1);
	updated_position(2) = path_points(i+1 ,2);
			