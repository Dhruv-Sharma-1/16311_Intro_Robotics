% @file centroids_to_dist.m
% @brief Function that takes in 4 centroids and calculates the distance to
% the tennis ball jig. Using focal length of camera, ball separation within
% the jig and the pinhole camera approximation, the distance to the balls
% is calculated using depth geometry. 
%
% @author Dhruv Sharma (ds1)
%--------------------------------------------------------------------------
function [dist] = centroids_to_dist(centroids, ball_separation, isTA)

% Set the focal length (unit : pixel) parameters found from calibrations
focalLength = 109.606299213 * 10.5;
if isTA
    % DO NOT change the TA focal length (unit : pixel)
    focalLength = 920;
end

% Your code here.
tlx = centroids(1, 1);
tly = centroids(1, 1);
blx = centroids(2, 1);
bly = centroids(2, 2);
trx = centroids(3, 1);
tryy = centroids(3, 2);
brx = centroids(4, 1);
bry = centroids(4, 2);

camDistL = (sqrt((tlx - blx)^(2) + (tly - bly)^(2)));
camDistR = (sqrt((trx - brx)^(2) + (tryy - bry)^(2)));
camDist = min(camDistL, camDistR);


dist = ball_separation * (focalLength/camDist);

end