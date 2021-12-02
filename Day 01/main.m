%% Initialisation
clear
close all

fid=fopen('input.txt');
input=fscanf(fid,'%d');
fclose(fid);  

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
input_diff=input(2:end)-input(1:end-1);
a1=sum(input_diff>0);
end

%% Part 2
function a2=part_2(input)
input_2=conv(input,[1,1,1],'valid');
input_2_diff=input_2(2:end)-input_2(1:end-1);
a2=sum(input_2_diff>0);
end