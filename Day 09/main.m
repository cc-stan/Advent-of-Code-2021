%% Initialisation
clear
close all

input=fileread("input.txt");
input=strtrim(regexprep(input, '.{1}', '$0 '));
input=str2num(input);

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
loc_min_vert=checkmin(input,1);
loc_min_hor=checkmin(input,2);
loc_min=loc_min_vert+loc_min_hor>1;
a1=sum(input(loc_min)+1,'all');
end

%% Part 2
function a2=part_2(input)
pools=poolit(input);
pools_sorted=sort(reshape(pools,1,[]),'descend');
a2=prod(pools_sorted(1:3));
end

%% Additional functions
function result=checkmin(M,dim)
M_sz=size(M);

if ~exist('dim','var')
    if M_sz(1)==1 && M_sz(2)==1
        result=1;
        return
    elseif M_sz(1)==1
        dim=2;
    else
        dim=1;
    end
end
if dim~=1 && dim~=2
    fprintf(2,'Dimension in second position has to be either 1(vert) or 2(hor)\n')
    return
end

result=zeros(M_sz);

if dim==1
    for i=1:M_sz(1)
        for j=1:M_sz(2)
            if i==1
                if M(i,j)<=M(i+1,j)
                    result(i,j)=1;
                end
            elseif i==M_sz(1)
                if M(end,j)<=M(end-1,j)
                    result(i,j)=1;
                end
            else
                if M(i,j)<M(i+1,j) && M(i,j)<M(i-1,j)
                    result(i,j)=1;
                end
            end

        end
    end
end

if dim==2
    for i=1:M_sz(1)
        for j=1:M_sz(2)
            if j==1
                if M(i,j)<=M(i,j+1)
                    result(i,j)=1;
                end
            elseif j==M_sz(2)
                if M(i,end)<=M(i,end-1)
                    result(i,j)=1;
                end
            else
                if M(i,j)<M(i,j+1) && M(i,j)<M(i,j-1)
                    result(i,j)=1;
                end
            end

        end
    end
end
end

function result=poolit(input)
loc_min_vert=checkmin(input,1);
loc_min_hor=checkmin(input,2);
loc_min=loc_min_vert+loc_min_hor>1;
result=zeros(size(input));

input_sz=size(input);

for i=1:input_sz(1)
    for j=1:input_sz(2)
        i_temp=i;
        j_temp=j;
        if input(i,j)~=9
            while ~loc_min(i_temp,j_temp)
                cur=input(i_temp,j_temp);
                if i_temp~=1
                    u=input(i_temp-1,j_temp);
                else
                    u=9;
                end

                if i_temp~=input_sz(1)
                    d=input(i_temp+1,j_temp);
                else
                    d=9;
                end

                if j_temp~=1
                    l=input(i_temp,j_temp-1);
                else
                    l=9;
                end

                if j_temp~=input_sz(2)
                    r=input(i_temp,j_temp+1);
                else
                    r=9;
                end

                if cur-u>cur-d && cur-u>cur-l && cur-u>cur-r
                    i_temp=i_temp-1;
                elseif cur-d>cur-l && cur-d>cur-r
                    i_temp=i_temp+1;
                elseif cur-l>cur-r
                    j_temp=j_temp-1;
                else
                    j_temp=j_temp+1;
                end
            end
            result(i_temp,j_temp)=result(i_temp,j_temp)+1;
        end
    end
end
end