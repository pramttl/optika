% Takes an object number (obj_nmbr, ie. -1 => Blue mine, -2 => Blue Kit, -3 => Red Mine, -4 => Red ,Green Lifeline => -5 , & a matrix, & 
% Returns a <something> X 2 array of all the positions of the points of that object type in the matrix.

function[obj_positions] = findobjectpositions(obj_numbr,mat)
	
	MAX_OBJECTS_OF_ANY_TYPE = 15; %{c} To be set according, to the requirements.
	
	obj_positions = zeros(MAX_OBJECTS_OF_ANY_TYPE,2);
	
	k = 1;
	for i=1:6
		for j=1:6
			if mat(i,j) == obj_numbr
				obj_positions(k,1) = i;
				obj_positions(k,2) = j;
				k = k + 1;
			end
		end
	end
	obj_positions = purge_useless_points(obj_positions); % Will strip out all those (0,0)s which are unnecessary.
				