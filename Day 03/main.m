%% Initialisation
clear
close all

input=fileread('input.txt');
input=char(splitlines(input));

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
[rows,cols]=size(input);
gam=blanks(cols);
eps=blanks(cols);
for i=1:cols
    gam(i)=char(round((sum(input(:,i))-'0'*rows)/rows)+'0');
    eps(i)=char(1-round((sum(input(:,i))-'0'*rows)/rows)+'0');
end
a1=bin2dec(gam)*bin2dec(eps);
end

%% Part 2
function a2=part_2(input)
c=1;

ox_temp=input;
car_temp=input;

while ~all(size(ox_temp)==[1,12])
    [rows,~]=size(ox_temp);
    com_bit=char(round((sum(ox_temp(:,c))-'0'*rows)/rows)+'0');
    ox_temp=ox_temp(ox_temp(:,c)==com_bit,:);
    c=c+1;
end

c=1;
while ~all(size(car_temp)==[1,12])
    [rows,~]=size(car_temp);
    com_bit=char(1-round((sum(car_temp(:,c))-'0'*rows)/rows)+'0');
    car_temp=car_temp(car_temp(:,c)==com_bit,:);
    c=c+1;
end

a2=bin2dec(ox_temp)*bin2dec(car_temp);
end