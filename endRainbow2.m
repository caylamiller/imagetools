function imageout = endRainbow2(imagein, map)
% Converts a colormapped RGB image to a grayscale image.
% 
% imageout = endRainbow2(imagein) returns a grayscale version of input 
% image imagein based on conversion from the rainbow (jet) colormap.
% Imagein must be a n*m*3 matrix. 
%
% imageout = endRainbow2(imagein, colormap) returns a grayscale version of 
% input image imagein based on conversion from a user-defined colormap.
% Colormap must be an q*3 matrix.
% 
%% Pt 1: Get the rainbow (jet) colormap and save as variable "map"
switch nargin
    case 2 % if user specifies colormap
        map = double(map);      % set colormap type to double
        map = map/max(map(:));  % scale colormap to [0 1]
        N   = size(map,1);
    case 1 % use rainbow (jet) colormap
        h   = figure; 
        imshow([0 255 ; 255 0]); colormap jet; 
        map = colormap;
        N   = size(map,1);
        close(h);
    otherwise
        error('missing input image')
end

%% Pt 2: Get size of input image and set up empty output image
imagein = double(imagein);
imagein = imagein/max(imagein(:)); % make sure image is scaled on 0 to 1 (instead of 0 to 255)
dims    = size(imagein); 
totpix  = dims(1)*dims(2); 
imageout= zeros(dims(1:2)); 

%% Pt 3: Match each pixel in image to closest color in colormap,  assign 
% gray vaue to output image
for i = 1:totpix
    [y, x]  = ind2sub(dims(1:2),i);    
    pxl     = double(reshape(imagein(y,x,:), 1, 3)); 
    A       = repmat(pxl, [N, 1]);
    [~, indx] = min(sum((A-map).^2,2)); 
    grayval = (indx-1)/(N-1); 
    imageout(y,x) = grayval; 
end

end  
