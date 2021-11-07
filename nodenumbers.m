clear all
clc

%vertices

white = 0;
red = 1;
black = 2;

map = imread('cbdped.bmp');     %read the map in
map = mod(map+2,3);
[V(1,:),V(2,:)] = find(map==black);     %find x y indices of black pixels in map
V = fliplr(V');                             %stores vertices' x coords in 1st col and y coords in 2nd col

a = [1:size(V,1)]'; b = num2str(a); Vlabels = cellstr(b);

hold on
image(1,-38,flipud(imread('cbdped.bmp')))
plot(V(:,1),size(V,1)-V(:,2),'g*')
text(V(:,1)+1,size(V,1)-V(:,2),Vlabels,'Color','r','FontSize',8)