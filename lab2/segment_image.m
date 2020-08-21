% @file segment_image.m
% @brief Function to segment a given thresholded image, by distinct labels.
% The end goal is identify the segments containing the tennis balls. All
% white spaces are segmented while black pixels are ignored. 
%
% @author Dhruv Sharma (ds1)
%--------------------------------------------------------------------------
function [output] = segment_image(thresholded_image)
% Your code here.
import java.util.LinkedList


[r, c] = size(thresholded_image);
output = thresholded_image;

seg = 2;

for i = 2:(r-1)
    for j = 2:(c-1)
        if output(i, j) == 1
            q = LinkedList();
            output(i, j) = seg;
            q.add([i, j]);
            while (q.size() > 0)
                cord = q.remove();
                x = cord(1);
                y = cord(2);
                if y-1 > 0 && output(x, y-1) == 1
                    output(x, y-1) = seg;
                    q.add([x y-1]);
                end
                if y+1 < c && output(x, y+1) == 1
                    output(x, y+1) = seg;
                    q.add([x y+1]);
                end
                if x-1 > 0 && output(x-1, y) == 1
                    output(x-1, y) = seg;
                    q.add([x-1 y]);
                end
                if x+1 < r && output(x+1, y) == 1
                    output(x+1, y) = seg;
                    q.add([x+1 y]);
                end
            end
            seg = seg + 1;
        end
    end
end

output(1, 1) = seg;

end
