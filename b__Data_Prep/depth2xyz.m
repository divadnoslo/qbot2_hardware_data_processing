function [xyz] = depth2xyz(depthData, numPoints, frame)

% Error Handling
if ((numPoints < 1) || (numPoints > 307200))
    error('Input numPoints not reasonable, must be between 1 & 307200')
end

% Capture the specific frame of interest
depthData = double(depthData);
depthData = depthData(frame, 1:307200);


%% This Section was written by Dr. Gentillini in 2017(?)
%DEPTH2XYZ Converts data from the IR camera of the Qbot2 into XYZ
%coordinates, needs a 480x640x42 array as input.  
%   Detailed explanation goes here later

% Scale Down and Re-size 3-dim array into 2 dimensions
map = reshape(depthData, [480, 640]);
map(map>3000) = 0;
map(map<500) = 0;

% Calculate Angles
thetas = -((1:640) - 320) * 57/640 * pi/180;
gammas = -((1:480) - 240) * 43/480 * pi/180;

% Convert data plot the xyz coordinates per elevation scan
for ii = 1 : 480
    
    Dxs = map(ii,:);
    rho = Dxs./cos(thetas);
    
    % Convert Segment of Data
    x = rho.*cos(thetas);
    y = rho.*sin(thetas);
    z = Dxs*tan(gammas(ii));
    
    % Concatinate Data into one Matrix
    if (ii == 1)
        x_all = x;
        y_all = y;
        z_all = z;
    else
        x_all = [x_all, x];
        y_all = [y_all, y];
        z_all = [z_all, z];
    end
    
end

%% Additional Data Conditioning

% Concatinate and Convert from millimeters to meters
xyz = [(x_all ./ 1000); (y_all ./ 1000); (z_all ./ 1000)];

% Remove All Zero Points
non_zero_mask = logical(sum(xyz) ~= 0);
xyz = xyz(:, non_zero_mask);
len = length(xyz);

% Error Handling
if (numPoints > len)
    fprintf('Number of all non-zero xyz points: %i \n\n', len)
    error(['numPoints is greater than the number of non-zero points available in frame ', num2str(frame)])
end

% Generate Random Indexes (without replacement)
p = randperm(len, numPoints);
p = sort(p);

% Store the randomly selected xyz points
xyz = xyz(:,p);

% Adjust and Store Point
for k = 1 : numPoints
    xyz(:,k) = rotate_y(21.5 * pi/180)*xyz(:,k) + [0; 0; 0.2];
end


end

