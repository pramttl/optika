%%%%%%%%%%%%%%%%%%%%%%%%% OPTIKA - TECHNEX IT -BHU 2012 , Jan 14th to 17th %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Team : Akash, Gaurav, Lakshay, Pranjal
% Vesion : 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

BLUE_MINE_MARK = -1;
BLUE_KIT_MARK = -2;
RED_MINE_MARK = -3;
RED_KIT_MARK = -4;
LIFELINE_MARK = -5;
TEMP_NUMBER = -9; % Temporary Useful Number for intermidiate calculations.

%%? Code that returns the MAT_OPTIKA or the bhagwan matrix with all the positions marked.
%????????????????????????????????????????????????????????????????????????????????????????%

MAT_OPTIKA_COPY = MAT_OPTIKA; % Test Copy of bhagwan matrix MAT_OPTIKA

%% Intermidiate Initialisation Code %%
DIFFUSION_KIT_BLUE =0; % Indicates whether blue kit is with the bot.
DIFFUSION_KIT_RED = 0; % Indicates whether red kit is with the bot.

end_position = [1 6]; % This is the FINAL EXIT POSITION.
current_position = [6 1]; % To initialise the current_position to Start Point.
current_position_x = 6;

blue_kit_position = locate_value_in_mat(BLUE_KIT_MARK, MAT_OPTIKA);
blue_kit_position_x = blue_kit_position(1);
blue_kit_position_y = blue_kit_position(2);

red_kit_position = locate_value_in_mat(RED_KIT_MARK, MAT_OPTIKA);
red_kit_position_x = red_kit_position(1);
red_kit_position_y = red_kit_position(2);

lifeline_position = locate_value_in_mat(LIFELINE_MARK, MAT_OPTIKA);
lifeline_position_x = lifeline_position(1);
lifeline_position_y = lifeline_position(2);

%%? Code to find nearest diffusion kit & move to it. %%
%???????????????????????????????????????????????????????????????????????%
	% DIFFUSION_KIT_RED = 1; %{t} Temporary lines to be changed.
	
	MAT_TEMP = MAT_OPTIKA;
	MAT_TEMP(6,1) = TEMP_NUMBER;
	MAT_TEMP(blue_kit_position_x,blue_kit_position_y) = TEMP_NUMBER;
	MAT_TEMP(red_kit_position_x,red_kit_position_y) = TEMP_NUMBER;
	path = nearestobjectpath([6 1], TEMP_NUMBER,MAT_TEMP);
	clear('MAT_TEMP'); % MAT_TEMP was a temporaray Matrix just for this Make Do code.
	
	current_position = movealongpath(path);
	current_position_x = current_position(1);
	current_position_y = current_position(2);
	
	% To check which color Diffusion Kit is at the current position, at which the bot is now, (this was the closest ki to the start point)
	if current_position_x == red_kit_position_x && current_position_y == red_kit_position_y
		DIFFUSION_KIT_RED = 1;
	elseif current_position_x == blue_kit_position_x && current_position_y == blue_kit_position_y
		DIFFUSION_KIT_BLUE = 1;
	end
	
	disp('obtaining kit')
	%{c} glow_green_led();
	%{c} pause(5);
	
	MAT_OPTIKA(current_position_x,current_position_y) = 0; %{t} After You take the diffusion kit there is nothing there, so it is 0.
%------------------------------------------------------------------------%	

	%% Diffusion Kit & Life Line positions are actually safe, so it is OK to set them 0, we have already recorded their positions in separate variables.%%
		MAT_OPTIKA(blue_kit_position_x,blue_kit_position_y) = 0;
		MAT_OPTIKA(red_kit_position_x,red_kit_position_y) = 0;
		MAT_OPTIKA(lifeline_position_x,lifeline_position_y) = 0;
		
	
%% Code to diffuse the bombs corresponding to the diffusion kit taken. %%
%*********************************************************************************************%

if (DIFFUSION_KIT_BLUE)
	obj_numbr = BLUE_MINE_MARK;
	current_position = blue_kit_position;
elseif (DIFFUSION_KIT_RED)
	obj_numbr = RED_MINE_MARK;
	current_position = red_kit_position;
end

obj_positions = findobjectpositions(obj_numbr, MAT_OPTIKA); % To find all the positions of the Blue/Red Mines (DEPENDS, which one)
[nofmines dummy] = size(obj_positions);

for i=1:nofmines
	path = nearestobjectpath(current_position, obj_numbr,MAT_OPTIKA); % It is important to ensure current_position is getting the correct value here.
	
	current_position = movealongpath(path); % movealongpath also returns updated position apart from performing the action of moving.
	disp('diffusing bomb') %{c} delay(5);
	% glow_red_led(); % To indicate BOMB DIFFUSAL.
	% pause(2);
	
	%% Code to make Current Position value = 0;
		current_position_x = current_position(1);
		current_position_y = current_position(2);
		MAT_OPTIKA(current_position_x,current_position_y) = 0; % After diffusing bomb cell's they become safe ie. = 0 (Infact, Any cell that is visited once becomes safe.)
end
%%---------------------One Type Of Mines Diffused------------------------------------------%%


%% Moving from the last mine position of previous type to the the remaining diffusion kit. %%
%*******************************************************************************************%
if (DIFFUSION_KIT_BLUE) % If this holds, that means, that we have to take the Red Diffusion Kit, since we just diffused the blue mines.
	path = bestrastadikhao(current_position,red_kit_position,MAT_OPTIKA);	
elseif (DIFFUSION_KIT_RED) % If this holds, that means, that we have to take the Blue Diffusion Kit, since we just diffused the Red mines.
	path = bestrastadikhao(current_position,blue_kit_position,MAT_OPTIKA);
end
current_position = movealongpath(path); % movealongpath returns updated position after reaching the new point having the other diffusion kit.
	disp('obtaining kit')
	%{c} pause(5);
	%{c} glow_green_led();
%-------------------------------------------------------------------------------------------%


%% Diffusing the next set of mines. %%
%*******************************************************************************************%

%obj_numbr = BLUE_MINE_MARK; %{t}

if (obj_numbr == RED_MINE_MARK) % If this holds, that means, that we had diffused blue mines previously, and now we have to diffuse red.
	obj_numbr = BLUE_MINE_MARK;
elseif (obj_numbr == BLUE_MINE_MARK) % If this holds, that means, that we had diffused red mines previously, and now we have to diffuse blue.
	obj_numbr = RED_MINE_MARK;
end

obj_positions = findobjectpositions(obj_numbr, MAT_OPTIKA); % To find all the positions of the Blue/Red Mines whichever are left.
[nofmines dummy] = size(obj_positions);

for i=1:nofmines
	path = nearestobjectpath(current_position, obj_numbr,MAT_OPTIKA); % It is important to ensure current_position is getting the correct value here.
	
	current_position = movealongpath(path); % movealongpath also returns updated position apart from performing the action of moving.
	disp('diffusing bomb');
	%{c} pause(5);
	%{c} glow_green_led(); % To indicate BOMB DIFFUSAL.
	
	%% Code to make Current Position value = 0;
		current_position_x = current_position(1);
		current_position_y = current_position(2);
		MAT_OPTIKA(current_position_x,current_position_y) = 0; % After diffusing bomb cell's they become safe ie. = 0 (Infact, Any cell that is visited once becomes safe.)
end
%-------------------------------------------------------------------------------------------%


%% Take the lifeline %%
%*******************************************************************************************%


%% Mission Not Yet Acomppolished, reach home SEPOY! (Reach the end point) %%
%**************************************************************************%

% To be changed: Since, now everything is all clear, so we need not fear. Kaise bhi jaldi ghar pahunchna hai! :)
	path = bestrastadikhao(current_position,end_position,MAT_OPTIKA);
	current_position = movealongpath(path);
	
	disp('Yippie! I did it! MISSION IS POSSIBLE!')
	
%*******************************MISSION OPTIKA ACOMPOLISHED *************************************************************************************************%	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
