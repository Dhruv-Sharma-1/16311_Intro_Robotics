% @file threshold_image.m
% @brief Function produces a black and white thesholded image. Using 2 
% distinct threshold values, the tennis balls are represented in white, and
% the background in black. 
%
% @author Dhruv Sharma (ds1)
%--------------------------------------------------------------------------
function [output] = threshold_image(input_image, threshold)
% Your code here.

img = rgb2hsv(input_image);

img = imgaussfilt(img, 1);

% assign hue, saturation and value
h1 = threshold(1);
h2 = threshold(2);
s1 = threshold(3);
s2 = threshold(4);
v1 = threshold(5);
v2 = threshold(6);

[r, c, ~] = size(img);
output = zeros(r, c);

for i = 1:c
    for j = 1:r
        curr = img(j, i, :);
        hue = curr(1);
        sat = curr(2);
        val = curr(3);
        
        if (h1 < hue && hue < h2) && (s1 < sat && sat < s2) && (v1 < val && val < v2) 
            output(j, i) = 1;
        else
            output(j, i) = 0;
        end
    end
end

end
