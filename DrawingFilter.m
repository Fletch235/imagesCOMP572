%% Filter effect description
%{

Filter Name:  Drawing

Effect Description:
Should add an effect to the pictures that 
1. isolates the edges 2. turns the background white 3. add a slight vignette to emulate faded edges.

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
    % Effectively the same as the edge detection problem with tweaked parameters {
    sigma = 1;
    h = fspecial("gaussian",[3*sigma 3*sigma],sigma);
    blurred = imfilter(im, h);
    h2 = fspecial("sobel");
    h2t = h2';
    ygrad = imfilter(blurred, h2);
    xgrad = imfilter(blurred, h2t);
    xgrad = im2double(xgrad);
    ygrad = im2double(ygrad);
    total = hypot(xgrad, ygrad);
    t = prctile(total(:), 85);
    r = double(total > t);% }
    
    r = r(1:end-1,1:end-1,:);%clip the edge cases off (they add a black line to the bottom and right side)
    beforeVignette = 1-((1/3)*r(:,:,1) + (1/3)*r(:,:,2) + (1/3)*r(:,:,3));%Take the inverse of the black background 'drawn lines'
    
    [rows,cols,~] = size(beforeVignette);%get size for vignette filter
    [x, y] = meshgrid(1:cols,1:rows);%create grid to match image
    d = sqrt((x - cols/2).^2 + (y - rows/2).^2);%distance from center
    r = d/(sqrt((cols/2).^2 + (rows/2).^2)); %normalize over range
    mask = (1 - (r.^3))*1.4; %create mask using inverse * strength factor
    
    result = beforeVignette .* mask;
end