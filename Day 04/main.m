%% Initialisation
clear
close all

input=fileread('input.txt');
input=split(input);

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
seq=str2double(regexp(input{1},',','split'));
bingo=reshape(str2double(input(2:end)),5,5,[]);

bingo_sz=size(bingo);
bingo_check=false;
bingo_bitmap=zeros(bingo_sz);
i=0;

while ~bingo_check
    i=i+1;
    bingo_bitmap=bingo_bitmap+(bingo==seq(i));
    if any(sum(bingo_bitmap,1)==5,'all')
        bingo_check=true;
        winner=find(any(sum(bingo_bitmap,1)==5));        
    elseif any(sum(bingo_bitmap,2)==5,'all')
        bingo_check=true;
        winner=find(any(sum(bingo_bitmap,2)==5));
    end
end
a1=sum(~bingo_bitmap(:,:,winner).*bingo(:,:,winner),'all')*seq(i);
end

%% Part 2
function a2=part_2(input)
seq=str2double(regexp(input{1},',','split'));
bingo=reshape(str2double(input(2:end)),5,5,[]);

bingo_sz=size(bingo);
bingo_bitmap=zeros(bingo_sz);
i=0;

while sum(any([any(sum(bingo_bitmap,1)==5),any(sum(bingo_bitmap,2)==5)]))~=bingo_sz(3)-1
    i=i+1;
    bingo_bitmap=bingo_bitmap+(bingo==seq(i));
end
loser=find(~any([any(sum(bingo_bitmap,1)==5),any(sum(bingo_bitmap,2)==5)]));

while ~any([any(sum(bingo_bitmap(:,:,loser),1)==5),any(sum(bingo_bitmap(:,:,loser),2)==5)])
    i=i+1;
    bingo_bitmap(:,:,loser)=bingo_bitmap(:,:,loser)+(bingo(:,:,loser)==seq(i));
end

a2=sum(~bingo_bitmap(:,:,loser).*bingo(:,:,loser),'all')*seq(i);
end