%% Initialisation
clear
close all

input=fileread('input.txt');
input=regexp(input,'\s\s\s','split');

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is see plot\n')
part_2(input)

%% Part 1
function a1=part_1(input)
dots=str2num(input{1});
folds_coord=regexp(splitlines(input{2}),'[0-9]*','match');
folds_coord=arrayfun(@str2num,string([folds_coord{:}]));
x_or_y=contains(splitlines(input{2}),'y');
folds_coord(2,:)=x_or_y(2:end);

paper=zeros(flip(max(dots))+1);
for i=1:numel(dots(:,1))
    paper(dots(i,2)+1,dots(i,1)+1)=1;
end

for i=1
    if folds_coord(2,i)==1
        paper=paper+flip(paper,1);
        paper=paper(1:folds_coord(1,i),:);
    else
        paper=paper+flip(paper,2);
        paper=paper(:,1:folds_coord(1,i));
    end
end
paper=paper>0;
a1=sum(paper,'all');
end

%% Part 2
function a2=part_2(input)
dots=str2num(input{1});
folds_coord=regexp(splitlines(input{2}),'[0-9]*','match');
folds_coord=arrayfun(@str2num,string([folds_coord{:}]));
x_or_y=contains(splitlines(input{2}),'y');
folds_coord(2,:)=x_or_y(2:end);

paper=zeros(flip(max(dots))+1);
for i=1:numel(dots(:,1))
    paper(dots(i,2)+1,dots(i,1)+1)=1;
end

for i=1:numel(folds_coord(1,:))
    if folds_coord(2,i)==1
        paper=paper+flip(paper,1);
        paper=paper(1:folds_coord(1,i),:);
    else
        paper=paper+flip(paper,2);
        paper=paper(:,1:folds_coord(1,i));
    end
end
paper=paper>0;
imshow(~paper)
end