close('all');   % close all open figures so we start with a clean slate!

im_bg = im2double(imread('swim.jpg'));        % background image
im_obj = im2double(imread('bear.jpg'));       % source image

poly_x = [276.4628  324.9961  391.5884  425.4488  453.6659  457.0519  433.3496 442.3791 ...
    441.2504  348.6984  248.2457  222.2860  238.0876  226.8008  222.2860  214.3853  224.5434  248.2457];
poly_y = [255.3512  238.4209  255.3512  250.8364  260.9946  283.5682  329.8442  349.0318 ...
    404.3372  419.0101  404.3372  356.9326  342.2597  308.3992  292.5977  265.5093  250.8364  247.4504];
objmask = poly2mask(poly_x, poly_y, size(im_obj, 1), size(im_obj, 2));

center_x = 575.9264;
bottom_y = 432.4922;
padding = 64;
[im_s, mask_s] = alignSource(im_obj, objmask, im_bg, center_x, bottom_y, padding);
mask_s = im2double(mask_s);

% Call the function to blend the images using the mask
blur = 16;     % width of crossfade
result1 = feather_blend(im_bg, im_s, mask_s, blur);

% Display:  target image, source image, mask, then blended result
figure; montage({im_bg, im_obj, mask_s, result1});


%%
% -------------------------------------------------------------------------
% IMPORTANT NOTE (please read carefully)
% -------------------------------------------------------------------------
% You must use the same images and mask and alignment coordinates as Part 1.
% Simply copy most of the code from Part 1 here.  The only difference
% is that the blending function called is now alpha_blend() instead of
% cut_and_paste().
% -------------------------------------------------------------------------


%%%%% your own images
im_bg = im2double(imread('..'));        % background image
im_obj = im2double(imread('..'));       % source image
%poly_x = ..
%poly_y = ..
objmask = poly2mask(poly_x, poly_y, size(im_obj, 1), size(im_obj, 2));
%center_x = ..
%bottom_y = ..
padding = 64;   % You may want to play with this parameter
[im_s, mask_s] = alignSource(im_obj, objmask, im_bg, center_x, bottom_y, padding);
mask_s = im2double(mask_s);

% % Apply your blending method

%blur = ..;     % width of crossfade, CHOOSE WISELY
result2 = feather_blend(im_bg, im_s, mask_s, blur);

% Display:  target image, source image, mask, then blended result
figure; montage({im_bg, im_obj, mask_s, result2});


% REPEAT ABOVE FOR IMAGE SET 3
% REPEAT ABOVE FOR IMAGE SET 4
% REPEAT ABOVE FOR IMAGE SET 5



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is your function that implements the blending method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function im_feather = feather_blend(im_bg, im_s, mask_s, blur)
    

    gauss = fspecial("gaussian",2*blur, blur);
    mask_s = imfilter(mask_s,gauss);
    im_feather = bsxfun(@times,im_s,cast(mask_s,class(im_s)))+bsxfun(@times,im_bg,cast(1-mask_s,class(im_bg)));

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Below are helper functions.  You DO NOT NEED TO MODIFY
% any of the code below.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [im_s2, mask2] = alignSource(im_s, mask, im_t, center_x, bottom_y, padding)
    % Inputs:  source image, mask, target/background image, ...
    % center_x, bottom_y are the coordinates of the bottom center location on the target image
    % padding is the number of extra rows/coumns to include around the
    % object to allow for feathering/blending.

    % Outputs: an aligned source image and also an aligned blending mask.
    
    % find the bounding box of the mask, and enlarge it by the amount of
    % padding
    [y, x] = find(mask);
    y1 = min(y)-1-padding; y2 = max(y)+1+padding; 
    x1 = min(x)-1-padding; x2 = max(x)+1+padding;
    im_s2 = zeros(size(im_t));

    yind = (y1:y2);
    yind2 = yind - max(y) + round(bottom_y);
    xind = (x1:x2);
    xind2 = xind - round(mean(x)) + round(center_x);
    
    % if the padding exceeds the image boundaries,
    % clip to image boundary
    yind(yind > size(im_s, 1)) = size(im_s, 1);
    yind(yind < 1) = 1;
    xind(xind > size(im_s, 2)) = size(im_s, 2);
    xind(xind < 1) = 1;
   
    yind2(yind2 > size(im_t, 1)) = size(im_t, 1);
    yind2(yind2 < 1) = 1;
    xind2(xind2 > size(im_t, 2)) = size(im_t, 2);
    xind2(xind2 < 1) = 1;

    y = y - max(y) + round(bottom_y);
    x = x - round(mean(x)) + round(center_x);
    ind = y + (x-1)*size(im_t, 1);
    mask2 = false(size(im_t, 1), size(im_t, 2));
    mask2(ind) = true;
    
    im_s2(yind2, xind2, :) = im_s(yind, xind, :);    
end
