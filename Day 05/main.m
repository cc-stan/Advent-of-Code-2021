%% Initialisation
clear
close all

fid=fopen('input.txt');
input=fscanf(fid,'%d,%d -> %d,%d',[4,inf])';
fclose(fid);  

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
input(:,1:2:3)=sort([input(:,1),input(:,3)],2);
input(:,2:2:4)=sort([input(:,2),input(:,4)],2);
hor=input(input(:,2)==input(:,4),:);
ver=input(input(:,1)==input(:,3),:);
grid_sz=[max(max(input(:,1:2:3)))+1,max(max(input(:,2:2:4)))+1];

map_hor=create_map(hor,grid_sz);
map_ver=create_map(ver,grid_sz);
a1=numel(find(map_hor+map_ver>1));
end

%% Part 2
function [a2]=part_2(input)
hor_i=find(input(:,2)==input(:,4));
ver_i=find(input(:,1)==input(:,3));
straight=input([hor_i;ver_i],:);

straight(:,1:2:3)=sort([straight(:,1),straight(:,3)],2);
straight(:,2:2:4)=sort([straight(:,2),straight(:,4)],2);

dia=input(setdiff(1:end,[hor_i;ver_i]),:);

grid_sz=[max(max(input(:,1:2:3)))+1,max(max(input(:,2:2:4)))+1];

map_str=create_map(straight,grid_sz);
map_dia=create_map_dia(dia,grid_sz);

a2=numel(find(map_str+map_dia>1));
end

function map=create_map(lines,grid_sz)
[i_max,~]=size(lines);
map=zeros(grid_sz);

for i=1:i_max
    map(lines(i,1)+1:lines(i,3)+1,lines(i,2)+1:lines(i,4)+1)=map(lines(i,1)+1:lines(i,3)+1,lines(i,2)+1:lines(i,4)+1)+1;
end
end

function map=create_map_dia(lines,grid_sz)
[i_max,~]=size(lines);
map=zeros(grid_sz);
lines_sorted(:,1:2:3)=sort([lines(:,1),lines(:,3)],2);
lines_sorted(:,2:2:4)=sort([lines(:,2),lines(:,4)],2);

for i=1:i_max
    if ((lines(i,1)<lines(i,3))&&(lines(i,2)<lines(i,4)))||((lines(i,1)>lines(i,3))&&(lines(i,2)>lines(i,4)))
     map(lines_sorted(i,1)+1:lines_sorted(i,3)+1,lines_sorted(i,2)+1:lines_sorted(i,4)+1)=map(lines_sorted(i,1)+1:lines_sorted(i,3)+1,lines_sorted(i,2)+1:lines_sorted(i,4)+1)+eye(lines_sorted(i,3)-lines_sorted(i,1)+1);
    else
    map(lines_sorted(i,1)+1:lines_sorted(i,3)+1,lines_sorted(i,2)+1:lines_sorted(i,4)+1)=map(lines_sorted(i,1)+1:lines_sorted(i,3)+1,lines_sorted(i,2)+1:lines_sorted(i,4)+1)+flip(eye(lines_sorted(i,3)-lines_sorted(i,1)+1));
    end
end
end