%% Initialisation
clear
close all

input=fileread('input.txt');
input=splitlines(input);
input=regexp(input,'[0-9]','match');
rows=numel(input);
cols=numel(input{1});
input=arrayfun(@(x)str2double(x),[input{:}]);
input=reshape(input,[rows,cols])';

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
[m, n] = size(input);

s=zeros(m*n*2-m-n,1);
t=zeros(m*n*2-m-n,1);
w=zeros(m*n*2-m-n,1);
k=1;

for R = 1 : m
    for C = 1 : n
        fromNode = (R - 1) * n + C;
        % Down
        if R < m
            r = R + 1;
            c = C;
            toNode = (r - 1) * n + c;
            s(k)=fromNode;
            t(k)=toNode;
            w(k)=input(r, c) + input(R, C);
            k=k+1;
        end
        % Right
        if C < n
            r = R ;
            c = C + 1;
            toNode = (r - 1) * n + c;
            s(k)=fromNode;
            t(k)=toNode;
            w(k)=input(r, c) + input(R, C);            
            k=k+1;
        end
    end
end

G=graph(s,t,w);
x=shortestpath(G,1,numel(input));

a1=0;
for i=2:numel(x)
    r=ceil(x(i)/m);
    c=x(i)-(r-1)*m;
    a1=a1+input(r,c);
end
end

%% Part 2
function a2=part_2(input)
input=[input,input+1,input+2,input+3,input+4;...
      input+1,input+2,input+3,input+4,input+5;...
      input+2,input+3,input+4,input+5,input+5;...
      input+3,input+4,input+5,input+6,input+7;...
      input+4,input+5,input+6,input+7,input+8];
input=mod(input-1,9)+1;

[m, n] = size(input);

s=zeros(m*n*2-m-n,1);
t=zeros(m*n*2-m-n,1);
w=zeros(m*n*2-m-n,1);
k=1;

for R = 1 : m
    for C = 1 : n
        fromNode = (R - 1) * n + C;
        % Down
        if R < m
            r = R + 1;
            c = C;
            toNode = (r - 1) * n + c;
            s(k)=fromNode;
            t(k)=toNode;
            w(k)=input(r, c) + input(R, C);
            k=k+1;
        end
        % Right
        if C < n
            r = R ;
            c = C + 1;
            toNode = (r - 1) * n + c;
            s(k)=fromNode;
            t(k)=toNode;
            w(k)=input(r, c) + input(R, C);            
            k=k+1;
        end
    end
end
G=graph(s,t,w);
x=shortestpath(G,1,numel(input));

a2=0;
for i=2:numel(x)
    r=ceil(x(i)/m);
    c=x(i)-(r-1)*m;
    a2=a2+input(r,c);
end
end