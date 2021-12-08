%% Initialisation
clear
close all

input=fileread('input.txt');
input=regexprep(input,'\| ','');
input=split(input);
input=reshape(input,14,[])';

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(input))
fprintf('Answer to part 2 is %d\n',part_2(input))

%% Part 1
function a1=part_1(input)
screen=input(:,end-3:end);
screen=str2double(string(cellfun(@(x)numstr2num(x),screen,'UniformOutput', false)));
a1=sum(~isnan(screen),'all');
end

%% Part 2
function a2=part_2(input)
pats=input(:,1:end-4);
screen_cor=zeros(length(input(:,1)),7);
screen_str=input(:,end-3:end);
screen_str=cellfun(@(x)sort(x),screen_str,'UniformOutput',false);
screen_str=string(screen_str);
screen=zeros(size(screen_str));

for i=1:length(input(:,1))
    y=cell2mat(cellfun(@(x)count_char(x),pats(i,:),'UniformOutput',false));
    n=sum(y,2);
    n_ch=sum(y);
    
    str_1=pats{i,n_ch==2};
    str_4=pats{i,n_ch==4};
    str_7=pats{i,n_ch==3};

    for k=1:2
        str_7=erase(str_7,str_1(k));
    end

    screen_cor(i,2)=find(n==6);
    screen_cor(i,5)=find(n==4);
    screen_cor(i,6)=find(n==9);

    screen_cor(i,1)=double(str_7-'a'+1);
    screen_cor(i,3)=double(erase(str_1,char(screen_cor(i,6)+'a'-1))-'a'+1);
    screen_cor(i,4)=double(erase(str_4,{char(screen_cor(i,2)+'a'-1),char(screen_cor(i,3)+'a'-1),char(screen_cor(i,6)+'a'-1)})-'a'+1);
    screen_cor(i,7)=setdiff(1:7,screen_cor(i,:));

end
screen_cor=screen_cor+'a'-1;

for i=1:length(screen_str(:,1))
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,2,3,5,6,7])))))    =0;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[3,6])))))            =1;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,3,4,5,7])))))      =2;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,3,4,6,7])))))      =3;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[2,3,4,6])))))        =4;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,2,4,6,7])))))      =5;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,2,4,5,6,7])))))    =6;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,3,6])))))          =7;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,2,3,4,5,6,7])))))  =8;
    screen(i,screen_str(i,:)==sort((char(screen_cor(i,[1,2,3,4,6,7])))))    =9;
end
a2=sum(screen(:,1)*1000+screen(:,2)*100+screen(:,3)*10+screen(:,4));
end

%% Additional functions
function str=numstr2num(str)
    switch numel(str)
        case 2
            str='1';
        case 3
            str='7';
        case 4
            str='4';
        case 7
            str='8';
    end
end

function result=count_char(str)
    result=zeros(7,1);
    result(1)=any(str=='a');
    result(2)=any(str=='b');
    result(3)=any(str=='c');
    result(4)=any(str=='d');
    result(5)=any(str=='e');
    result(6)=any(str=='f');
    result(7)=any(str=='g');  
end