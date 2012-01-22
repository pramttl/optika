%% Takes in a value & returns the position of that value in the Matrix.
%% NOTE : Will be useful only if that value exists in only 1 cell in the matrix, like for locating postion of diffusal kits & lifelines in MAT_OPTIKA.

function[cell] = locate_value_in_mat(value,mat)
	cell = zeros(1,2);
	for i = 1:6
		for j=1:6
			if (mat(i,j) == value)
				cell(1) = i;
				cell(2) = j;
				break;
			end
		end
	end