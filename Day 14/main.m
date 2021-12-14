%% Initialisation
clear
close all

input=fileread('input.txt');
input=regexp(input,'\s\s\s\s','split');

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
seq=string(input{1});
inst=splitlines(input{2});
inst=string(split(inst,' -> ',2));
inst_s=inst(:,1);
for i=1:numel(inst_s)
    inst_s(i)=insertAfter(inst_s(i),1,'(?=');
    inst_s(i)=insertAfter(inst_s(i),strlength(inst_s(i)),')');
end

for k=1:10
    ind=regexp(seq,inst_s);
    ind=[ind{:}]';
    ins=strings(numel(ind),1);
    for j=1:numel(ind)
    ins(j)=seq{1}(ind(j):ind(j)+1);
    end

    ind=[ind,ins];
    [~,x]=sort(str2double(ind(:,1)));
    ind=ind(x,:);
    c=0;
    for i=1:numel(ind(:,1))
        seq=insertAfter(seq,double(ind(i,1))+c,inst(contains(inst(:,1),ind(i,2)),2));
        c=c+1;
    end
end
letters=zeros(26,1);
for i=0:25
    letters(i+1)=count(seq,char(65+i));
end
a1=max(letters)-min(letters(letters>0));
end

%% Part 2
function a2=part_2(input)
seq=string(input{1});
inst=splitlines(input{2});
inst=string(split(inst,' -> ',2));

for i=1:numel(inst(:,1))
    poly.(inst(i,1))=count(seq,inst(i,1));
    c_1(i,1)=inst{i,1}(1);
    c_end(i,1)=inst{i,1}(2);
end
u_chars=unique(inst(:,2));
for i=1:numel(u_chars)
    chars.(u_chars(i))=count(seq,u_chars(i));
end

for k=1:40
    poly_temp=poly;
    for i=1:numel(inst(:,1))
        c=poly_temp.(inst(i,1));
        poly.(inst(i,1))=poly.(inst(i,1))-c;
        poly.((c_1(i)+inst(i,2)))=poly.((c_1(i)+inst(i,2)))+c;
        poly.((inst(i,2)+c_end(i)))=poly.((inst(i,2)+c_end(i)))+c;
        chars.(inst(i,2))=chars.(inst(i,2))+c;
    end
end
x=[];
for i=1:numel(u_chars)
x=[x;chars.(u_chars(i))];
end
a2=max(x)-min(x);
end