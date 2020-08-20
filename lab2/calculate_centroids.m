% @file calculate_centroids.m
% @brief Function to calculate centroids of segmented images. The centroids
% that are bigger than the expected size of the balls are discarded. The
% end result is a matrix of 4 centroid cooordinates representing the 4
% tennis balls on the jig. 
%
% @author Dhruv Sharma (ds1)
%--------------------------------------------------------------------------
function [centroids] = calculate_centroids(segmented_image)
% Your code here.
total = segmented_image(1, 1) - 1;
[r, c] = size(segmented_image);
tmp = zeros(total, 3);

for n = 2:total
    for y = 2:r
        for x = 2:c
            if segmented_image(y, x) == n
                tmp(n, 1) = tmp(n, 1) + 1;
                tmp(n, 2) = tmp(n, 2) + x;
                tmp(n, 3) = tmp(n, 3) + y;
            end
        end
    end
end
centroids = zeros(4, 2);

cnt = 1;
for n = 2:total
    if tmp(n, 1) < 30
        continue
    end
    
    Xc = double(tmp(n, 2)) / double(tmp(n, 1));
    Yc = double(tmp(n, 3)) / double(tmp(n, 1));
    centroids(cnt, 1) = round(Xc);
    centroids(cnt, 2) = round(Yc);
    cnt = cnt + 1;
end

end
