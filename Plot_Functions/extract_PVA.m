function [pos, vel, rpy] = extract_PVA(r, v, C)

% Takes in a PVA-structure and returns data-vectors that are easier to plot

% Extract Position
pos = [r(:,1)'; r(:,2)'; r(:,3)'];

% Extract Position
vel = [v(:,1)'; v(:,2)'; v(:,3)'];

% Extract Attitude
for ii = 1 : length(pos)
    [psi, theta, phi] = dcm2ypr(C(:,:,ii));
    roll(ii) = phi * 180/pi;
    pitch(ii) = theta * 180/pi;
    yaw(ii) = psi * 180/pi;
end

rpy = [roll; pitch; yaw];
    


