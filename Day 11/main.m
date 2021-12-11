%% Initialisation
clear
close all

input=fileread('input.txt');
input=strtrim(regexprep(input, '.{1}', '$0 '));
input=str2num(input);

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
input=padarray(input,[1 1],NaN);
sz=size(input);

n=[1,1,1;1,0,1;1,1,1];
a1=0;

for i=1:100
    flashed=false(sz);
    input=input+1;
    while 1
        flashed_now=input>9;
        flashed_i=find(flashed_now==1);
        if isempty(flashed_i)
            break
        end

        for j=1:numel(flashed_i)
            if flashed(flashed_i(j))==0
                [r,c]=ind2sub(sz,flashed_i(j));
                input(r-1:r+1,c-1:c+1)=input(r-1:r+1,c-1:c+1)+n;
                flashed(flashed_i(j))=1;
                input(r,c)=NaN;
                a1=a1+1;
            end
        end
    end
    input(flashed)=0;
end
end

%% Part 2
function a2=part_2(input)
input=padarray(input,[1 1],NaN);
sz=size(input);

n=[1,1,1;1,0,1;1,1,1];

for i=1:1000
    flashed=false(sz);
    input=input+1;
    while 1
        flashed_now=input>9;
        flashed_i=find(flashed_now==1);
        if isempty(flashed_i)
            break
        end

        for j=1:numel(flashed_i)
            if flashed(flashed_i(j))==0
                [r,c]=ind2sub(sz,flashed_i(j));
                input(r-1:r+1,c-1:c+1)=input(r-1:r+1,c-1:c+1)+n;
                flashed(flashed_i(j))=1;
                input(r,c)=NaN;
            end
        end
    end
    input(flashed)=0;
    flash_check=sum(flashed,'all')==prod(sz-2);
    if flash_check==1
        break
    end
end
a2=i;
end