%% Initialisation
clear
close all

input=fileread('input.txt');
input=splitlines(input);

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
a1=0;
for i=1:numel(input)
    while 1
        num_ch=numel(input{i});
        input{i}=regexprep(input{i},{'\(\)','\[\]','<>','\{\}'},'');
        if num_ch==numel(input{i})
            x=double(input{i}==')')+double(input{i}==']')+double(input{i}=='>')+double(input{i}=='}');
            x=find(x,1,'first');
            if ~isempty(x)
                a1=a1+(input{i}(x)==[')',']','}','>'])*[3;57;1197;25137];
            end
            break
        end
    end
end
end

%% Part 2
function a2=part_2(input)
cor_lines=zeros(numel(input),1);
for i=1:numel(input)
    while 1
        num_ch=numel(input{i});
        input{i}=regexprep(input{i},{'\(\)','\[\]','<>','\{\}'},'');
        if num_ch==numel(input{i})
            x=double(input{i}==')')+double(input{i}==']')+double(input{i}=='>')+double(input{i}=='}');
            x=find(x,1,'first');
            if ~isempty(x)
                cor_lines(i)=1;
            end
            break
        end
    end
end

input=input(~cor_lines);
a2=zeros(numel(input),1);
for i=1:numel(input)
    while ~isempty(input{i})
        switch input{i}(end)
            case '('
                a2(i)=a2(i)*5+1;
                input{i}(end)='';
            case '['
                a2(i)=a2(i)*5+2;
                input{i}(end)='';
            case '{'
                a2(i)=a2(i)*5+3;
                input{i}(end)='';
            case '<'
                a2(i)=a2(i)*5+4;
                input{i}(end)='';
        end
    end
end
a2=median(a2);
end