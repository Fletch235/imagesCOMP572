%% Filter effect description
%{

Filter Name:  Night Vision

Effect Description:

Find the edges using gradients, make edges green and reapply to a darkened version of the origional image

Describe the filter's effects in 2-3 lines (plain English!).
This is how you should start this exercise, by writing down
what effect you are trying to achieve, before writing any code!

%}


% Specify your chosen images in the imread() commands below.
% Indicate which picture was shot by you personally.
% Read the note at the beginning of the assignment regarding image sizes
% and server timeouts.

close('all');    % Close all figures so we start with a clean slate


im=imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/im1.jpg');
% resize the picture if needed so it is no more than 1000x1000
filtered = myFilter(im);
% display the result
figure(1); montage({im, filtered}, 'Size', [1 2], 'BorderSize', [25 25], 'BackgroundColor', [1 1 1]);

im=imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/im2.jpg');
% resize the picture if needed so it is no more than 1000x1000
filtered = myFilter(im);
% display the result
figure(2); montage({im, filtered}, 'Size', [1 2], 'BorderSize', [25 25], 'BackgroundColor', [1 1 1]);

im=imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/im3.jpg');
% resize the picture if needed so it is no more than 1000x1000
filtered = myFilter(im);
% display the result
figure(3); montage({im, filtered}, 'Size', [1 2], 'BorderSize', [25 25], 'BackgroundColor', [1 1 1]);

im=imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/im4.jpg');
% resize the picture if needed so it is no more than 1000x1000
filtered = myFilter(im);
% display the result
figure(4); montage({im, filtered}, 'Size', [1 2], 'BorderSize', [25 25], 'BackgroundColor', [1 1 1]);

im=imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/im5.jpg');
% resize the picture if needed so it is no more than 1000x1000
filtered = myFilter(im);
% display the result
figure(5); montage({im, filtered}, 'Size', [1 2], 'BorderSize', [25 25], 'BackgroundColor', [1 1 1]);

im=imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/im6.jpg');
% resize the picture if needed so it is no more than 1000x1000
filtered = myFilter(im);
% display the result
figure(6); montage({im, filtered}, 'Size', [1 2], 'BorderSize', [25 25], 'BackgroundColor', [1 1 1]);

function result = myFilter(im)
    rgb = im2double(im);%convert to double
    gray = rgb2gray(rgb);%convert to gray
    
    hgauss = imgaussfilt(gray, 1.2);%apply gaussian blur; sigma = 1.2
    gradx = imfilter(hgauss, fspecial('sobel')');%gradient in x direction (vertical)
    grady = imfilter(hgauss, fspecial('sobel'));%gradient in y direction (horizontal)
    grad = hypot(gradx,grady);%total gradient
    percent = double(grad > prctile(grad(:), 84)); % select from grad the strongest 16% of edges
    
    edges = imgaussfilt(percent, 1.8); %slightly blur edges w factor 1.8
    green = cat(3, zeros(size(edges)), ones(size(edges)), zeros(size(edges)));%make green block to use for coloring edges    
    base = rgb * 0.5;% dark base
    
    result = base .* (1-edges) + green .* edges;%where there are edges use green as the color, where edges are not selected use the dark background.
end
