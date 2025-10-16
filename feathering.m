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


im_bg = im2double(imresize(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/wave.jpg'),0.5));        % background image
im_obj = im2double(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/dolphin.jpg'));       % source image
poly_x   =[81.456403269754702	65.694822888283312	1.856198910081744e+02	5.762329700272481e+02	6.824523160762946e+02	6.653201634877387e+02	3.398092643051772e+02	1.513555858310626e+02	67.750681198910002	67.750681198910002];     % display x coords of polygon
poly_y  =[2.639925068119891e+02	2.845510899182561e+02	1.132295640326975e+02	1.310470027247956e+02	2.338399182561307e+02	3.633589918256131e+02	3.948821525885559e+02	3.722677111716621e+02	2.852363760217983e+02	2.852363760217983e+02];      % display y coords of polygon
objmask = poly2mask(poly_x, poly_y, size(im_obj, 1), size(im_obj, 2));
center_x  =6.004999999999999e+02;      % display x coord where center of object should be placed
bottom_y   =7.857861035422343e+02;     % display y coord where bottom of object should be placed
padding = 64; 
[im_s, mask_s] = alignSource(im_obj, objmask, im_bg, center_x, bottom_y, padding);
mask_s = im2double(mask_s);
result2 = feather_blend(im_bg, im_s, mask_s,blur);
figure; montage({im_bg, im_obj, mask_s, result2});
% REPEAT ABOVE FOR IMAGE SET 3
im_bg = im2double(imresize(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/field.jpg'),1));        % background image
im_obj = im2double(imresize(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/eagle.jpg'),1));       % source image
poly_x = [1.626959948320413e+03	1.770835917312661e+03	5.685620155038758e+02	5.900607235142118e+02	1.423549095607235e+03];
poly_y  =[66.701550387596740	9.828772609819121e+02	7.447377260981912e+02	3.230322997416019e+02	58.432816537467602];      % display y coords of polygon
objmask = poly2mask(poly_x, poly_y, size(im_obj, 1), size(im_obj, 2));
center_x  =1.252074931880109e+03;      % display x coord where center of object should be placed
bottom_y   =1.073350136239782e+03;     % display y coord where bottom of object should be placed
padding = 64;   % You may want to play with this parameter
[im_s, mask_s] = alignSource(im_obj, objmask, im_bg, center_x, bottom_y, padding);
mask_s = im2double(mask_s);
result2 = feather_blend(im_bg, im_s, mask_s,blur);
figure; montage({im_bg, im_obj, mask_s, result2});
% REPEAT ABOVE FOR IMAGE SET 4
im_bg = im2double(imresize(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/snow.jpg'),1));        % background image
im_obj = im2double(imresize(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/fox.jpg'),0.3));       % source image
poly_x=[1.552411444141689e+02	2.722901907356948e+02	2.677534059945503e+02	1.525190735694823e+02	1.537288828337874e+02];
poly_y = [61.141689373297027	63.258855585831071	1.476430517711172e+02	1.319155313351499e+02	61.444141689373318];% display y coords of polygon
objmask = poly2mask(poly_x, poly_y, size(im_obj, 1), size(im_obj, 2));
center_x = 3.767028423772609e+02;
bottom_y = 3.348992248062015e+02;
padding = 64;   % You may want to play with this parameter
[im_s, mask_s] = alignSource(im_obj, objmask, im_bg, center_x, bottom_y, padding);
mask_s = im2double(mask_s);
result2 = feather_blend(im_bg, im_s, mask_s,blur);
figure; montage({im_bg, im_obj, mask_s, result2});
% REPEAT ABOVE FOR IMAGE SET 5
im_bg = im2double(imresize(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/im2.jpg'),1));        % background image, I took these images
im_obj = im2double(imresize(imread('https://raw.githubusercontent.com/Fletch235/imagesCOMP572/main/fletch.jpg'),0.07));       % source image
poly_x = [1.448882833787466e+02	1.379564032697548e+02	1.394005449591281e+02	1.365122615803815e+02	1.240926430517711e+02	1.162942779291553e+02	1.211335298353986e+02	1.217131540066375e+02	1.179455968935845e+02	1.231622144347348e+02	1.335954495170355e+02	1.347546978595134e+02	1.472166175411503e+02	1.466369933699114e+02	1.559109801097343e+02	1.596785372227873e+02	1.550415438528759e+02	1.501147383973450e+02	1.451879329418141e+02];
poly_y = [2.112002724795641e+02	2.112002724795641e+02	1.898269754768393e+02	1.701866485013624e+02	2.100449591280654e+02	2.132220708446867e+02	1.727932849007714e+02	1.591721168766566e+02	1.383056467120552e+02	1.154104919481175e+02	1.136716194344008e+02	97.731954725330226	96.572706382852374	1.110633106638256e+02	1.200474853180290e+02	1.397547071401525e+02	1.635192981609486e+02	1.675766673596211e+02	2.093096076888239e+02];
objmask = poly2mask(poly_x, poly_y, size(im_obj, 1), size(im_obj, 2));
center_x =2.976539509536786e+02;
bottom_y = 8.930688010899183e+02;
padding = 64;   % You may want to play with this parameter
[im_s, mask_s] = alignSource(im_obj, objmask, im_bg, center_x, bottom_y, padding);
mask_s = im2double(mask_s);
result2 = feather_blend(im_bg, im_s, mask_s,blur);
figure; montage({im_bg, im_obj, mask_s, result2});



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
