% @file image_to_dist.m
% @brief Function to run the entire pipeline used to calculate the
% distance from the camera to the tennis ball jig
%
% @author Dhruv Sharma (ds1)
%--------------------------------------------------------------------------
function [dist] = image_to_dist(input_image, threshold, ball_separation, isTA)
% Your code here.

thresh = threshold_image(input_image, threshold);
segment = segment_image(thresh);

centroids = calculate_centroids(segment);

dist = centroids_to_dist(centroids, ball_separation, isTA);
end
