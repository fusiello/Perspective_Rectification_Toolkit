clear
close all

datadir   = '.'; % folder containing image
file_name = 'porta_aquileia.jpg';
%method = '4l'; % 4 lines
method = '4p'; % 4 points

% read  the image
fprintf('Processing %s \n', file_name);
I = imread([datadir,'/',file_name]);
if size(I,3) > 1
    I = rgb2gray(I);
end
figure(1), imshow(I,[],'InitialMagnification','fit'); hold on

switch lower(method)
    case '4p'
        disp('Select 4 coplanar points on a rectangle')
        % get 4 points from the user anticlockwise from the top-left
        %quad = ginput';
        load([datadir,'/quad']); disp('... bypassed for testing')
        
    case '4l'
        
        % get 8 points from the user that specify 4 lines on the same
        % plane
        disp('Select 2 horizontal and two vertical coplanar lines')
        %lines = ginput';
        load([datadir,'/lines']); disp('... bypassed for testing')
        
        lines = ensure_homogeneous(lines);
        l1 = cross(lines(:,1),lines(:,2));
        l2 = cross(lines(:,3),lines(:,4));
        l3 = cross(lines(:,5),lines(:,6));
        l4 = cross(lines(:,7),lines(:,8));
        
        % virtual rectangle
        quad(:,1) = cross(l1,l2);
        quad(:,2) = cross(l2,l3);
        quad(:,3) = cross(l3,l4);
        quad(:,4) = cross(l4,l1);
        
        quad = quad ./ repmat(quad(3,:),3,1); % projective division
        quad(3,:) = [];
        
    otherwise
        error('Unrecognized  method %s',method);
end

patch(quad(1,:), quad(2,:), 'y','FaceAlpha',.2, 'EdgeColor','yellow')


% guess the sides of a rectangle with same area and perimeter
[w,h] = guess_sides(quad');

% the user can accept the guess or specify dimensions
prompt = sprintf('Horizontal dist? [%d]:',round(w));
val = input(prompt);
if ~isempty(val)
    w=val;
end

prompt = sprintf('Vertical dist? [%d]:',round(h));
val = input(prompt);
if ~isempty(val)
    h=val;
end

rectangle = quad(:,1) + [0 0 w w ; 0 h h 0];

H = hom_lin(rectangle, quad);

% compute bounding box
p4 = [1, 1, size(I,2), size(I,2);
    1, size(I,1), 1, size(I,1)];
p4_x = htx(H,p4);
minx = floor(min(p4_x(1,:)));
maxx = ceil(max(p4_x(1,:))) ;
miny = floor(min(p4_x(2,:)));
maxy = ceil(max(p4_x(2,:))) ;
bb = [minx; miny; maxx; maxy];

% This processes a grayscale image; if you want a color image, the same
% warping has to be applied to each color channel.
If = imwarp(I,@(x)htx(inv(H),x),bb);

figure, imshow(If,[], 'InitialMagnification', 'fit'), hold on;
patch(rectangle(1,:)-bb(1), rectangle(2,:)-bb(2), 'y', 'FaceAlpha',.2, 'EdgeColor','yellow')

