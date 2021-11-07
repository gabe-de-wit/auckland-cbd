clear all
clc

%vertices

white = 0;
red = 2;
black = 1;

map = imread('cbdped.bmp');     %read the map in
map = mod(map+1,3);
[V(1,:),V(2,:)] = find(map==black);     %find x y indices of black pixels in map
V = V';                             %stores vertices' x coords in 1st col and y coords in 2nd col

%weighted adjacency matrix

D = zeros(size(V,1));

for i=1:size(V,1)
    for j=1:5
        if(adjlist(i,j)>0)
            D(i,adjlist(i,j)) = sqrt((V(i,1)-V(adjlist(i,j),1))^2+(V(i,2)-V(adjlist(i,j),2))^2);
            D(adjlist(i,j),i) = D(i,adjlist(i,j));
        end
    end
end

%plot weighted adjacency matrix
hold on
for i=1:size(V,1)
    for j=1:size(V,1)
        if D(i,j)>0
            plot([V(i,2),V(j,2)],[size(map,1)-V(i,1),size(map,1)-V(j,1)],'k-')
        end
    end
    plot(V(i,2),size(map,1)-V(i,1),'b*')
end
clear i j

%shortestpaths
shortestpaths = allspath(D);

%catchments
threshold = 100;
catchment = shortestpaths < threshold;
nodeofinterest = 28;

figure(2)
hold on
for i=1:size(V,1)
    for j=1:size(V,1)
        if D(i,j)>0
            plot([V(i,1),V(j,1)],[size(map,2)-V(i,2),size(map,2)-V(j,2)],'k-')
        end
    end
end
clear i j
for j=1:size(V,1)
    if catchment(nodeofinterest,j) == 1
        plot(V(j,1),size(map,2)-V(j,2),'g*','linewidth',3)
    end
end
plot(V(nodeofinterest,1),size(map,2)-V(nodeofinterest,2),'r*','linewidth',7)

