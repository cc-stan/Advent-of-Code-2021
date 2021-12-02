%% Initialisation
clear
close all

input=fileread('input.txt');
input=splitlines(input);
input=regexp(input,'\s','split');

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
coord=[0,0];
for i=1:numel(input)
    switch input{i}{1}(1)
        case 'f'
            coord(1)=coord(1)+str2double(input{i}{2});
        case 'd'
            coord(2)=coord(2)+str2double(input{i}{2});
        case 'u'
            coord(2)=coord(2)-str2double(input{i}{2});
    end
end
a1=prod(coord);
end

%% Part 2
function a2=part_2(input)
coord=[0,0];
aim=0;
for i=1:numel(input)
    switch input{i}{1}(1)
        case 'f'
            coord(1)=coord(1)+str2double(input{i}{2});
            coord(2)=coord(2)+aim*str2double(input{i}{2});
        case 'd'
            aim=aim+str2double(input{i}{2});
        case 'u'
            aim=aim-str2double(input{i}{2});
    end
end
a2=prod(coord);
end