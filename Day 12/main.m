%% Initialisation
clear
close all

input=readmatrix('input.txt', Delimiter='-',OutputType='string');

G=graph(input(:,1),input(:,2));

%% Print the answers
fprintf('Answer to part 1 is %d\n',part_1(G,string([]),0,"start"))
fprintf('Answer to part 2 is %d\n',part_2(G,string([]),0,"start",1))

%% Part 1
function n_paths=part_1(G,vis,n_paths,cur_node)
if cur_node=="start" && numel(vis)>1
    return
end
vis(end+1)=cur_node;
if cur_node=="end"
    n_paths=n_paths+1;
    %fprintf('Path %d: %s\n',n_paths,strjoin(vis,','))
    return
end
nb=neighbors(G,cur_node);
for i=1:numel(nb)
    if nb(i)==upper(nb(i))
        n_paths=part_1(G,vis,n_paths,nb(i));
    elseif ~contains(nb(i),vis)
        n_paths=part_1(G,vis,n_paths,nb(i));
    end
end
end

%% Part 2
function n_paths=part_2(G,vis,n_paths,cur_node,extra_vis)

if cur_node=="start" && numel(vis)>1
    return
end

vis(end+1)=cur_node;

if cur_node=="end"
    n_paths=n_paths+1;
    %fprintf('Path %d: %s\n',n_paths,strjoin(vis,','))
    return
end

nb=neighbors(G,cur_node);
for i=1:numel(nb)
    if nb(i)==upper(nb(i))
        n_paths=part_2(G,vis,n_paths,nb(i),extra_vis);
    elseif ~contains(nb(i),vis)
        n_paths=part_2(G,vis,n_paths,nb(i),extra_vis);
    elseif sum(count(nb(i),vis)) <= extra_vis
        n_paths = part_2(G, vis, n_paths, nb(i), 0);
    end
end
end


