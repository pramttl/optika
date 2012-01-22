%% This simple code moves the bot from any 1 cell to another, in a simple straight path. 
%% The module 'final' returns a matrix with start point marked as -1 & end point marked as -2.

ser = serial('COM15','BAUDRATE',9600);
fopen(ser);

final

MAT_OPTIKA_PRELIMS = zeros(6,6); %{t}
MAT_OPTIKA_PRELIMS(6,1) = -1;	 %{t}
MAT_OPTIKA_PRELIMS(1,6) = -2;	 %{t}

% Code to find the start point & destination fr
for i = 1:6
	for j=1:6
		if MAT_OPTIKA_PRELIMS(i,j) == -1
			start_point_x = i;
			start_point_y = j;
		elseif MAT_OPTIKA_PRELIMS(i,j) == -2
			end_point_x = i;
			end_point_y = j;
		end
	end
end

MAT_OPTIKA_PRELIMS

horizontal_movement = end_point_y - start_point_y;
vertical_movement = start_point_x - end_point_x;

for i = 1 : abs(horizontal_movement)
	if horizontal_movement > 0
		disp('right')
		fwrite(ser,'r'); %{ser}
	elseif horizontal_movement < 0
		disp('left')
		fwrite(ser,'l'); %{ser}
	end
end

for i = 1 : abs(vertical_movement)
	if vertical_movement > 0
		disp('up')
		fwrite(ser,'u'); %{ser}
	elseif vertical_movement < 0
		disp('down')
		fwrite(ser,'d'); %{ser}
	end
end

disp('Yippie! I did it virtually!')
fwrite(ser,'q'); %{ser}