%% Initialisation
clear
close all

fid=fopen('input_test.txt');
input=fscanf(fid,'%d,');
fclose(fid);

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
start=median(input);
i1=[sum(abs(input-start-1)),sum(abs(input-start)),sum(abs(input-start+1))];
[~,min_i]=min(i1);
c=1;
switch min_i
    case 1
        cur=i1(min_i);
        cur_temp=cur;
        while cur<=cur_temp
            c=c+1;
            cur_temp=cur;
            cur=sum(abs(input-start-c));
        end
    case 2
        cur_temp=i1(min_i);
    case 3
        cur=i1(min_i);
        cur_temp=cur;
        while cur<=cur_temp
            c=c+1;
            cur_temp=cur;
            cur=sum(abs(input-start+c));
        end
end
a1=cur_temp;
end

%% Part 2
function a2=part_2(input)
start=round(mean(input));
i1=[sum(arrayfun(@tria_num, abs(input-start-1))),sum(arrayfun(@tria_num, abs(input-start))),sum(arrayfun(@tria_num, abs(input-start+1)))];
[~,min_i]=min(i1);
c=1;
switch min_i
    case 1
        cur=i1(min_i);
        cur_temp=cur;
        while cur<=cur_temp
            c=c+1;
            cur_temp=cur;
            cur=sum(arrayfun(@tria_num, abs(input-start-c)));
        end
    case 2
        cur_temp=i1(min_i);
    case 3
        cur=i1(min_i);
        cur_temp=cur;
        while cur<=cur_temp
            c=c+1;
            cur_temp=cur;
            cur=sum(arrayfun(@tria_num, abs(input-start+c)));
        end
end
a2=cur_temp;
end

%% Extra Functions
function result=tria_num(n)
sum=0;
result=0;
for i=1:n
    sum=sum+1;
    result=result+sum;
end
end