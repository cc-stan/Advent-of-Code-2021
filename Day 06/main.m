%% Initialisation
clear
close all

fid=fopen('input.txt');
input=fscanf(fid,'%d,');
fclose(fid);  

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
x6=zeros(1,7);
x8=zeros(1,9);
x6(1)=1;
y=zeros(1,7);

c=0;
m=hist(input,0:6);

while c<80
    c=c+1;
    x_temp=x6(1)+x8(1);

    x6=[x6(2:end),x_temp];
    x8=[x8(2:end),x_temp];

    y=[y(2:end),sum([x6,x8])];
end
a1=y*m';
end

%% Part 2
function a2=part_2(input)
x6=zeros(1,7);
x8=zeros(1,9);
x6(1)=1;
y=zeros(1,7);

c=0;
m=hist(input,0:6);

while c<256
    c=c+1;
    x_temp=x6(1)+x8(1);

    x6=[x6(2:end),x_temp];
    x8=[x8(2:end),x_temp];

    y=[y(2:end),sum([x6,x8])];
end
a2=y*m';
end