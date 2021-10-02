function [k_r, k_v, k_a] = format_K(k_gains)
%FORMAT_K Formats Kalman Gains for plotting since Simulink is being
%difficult

[~, ~, len] = size(k_gains);

% Preallocate Memory
k_r = zeros(9, len);
k_v = zeros(9, len);
k_a = zeros(9, len);

for k = 1 : len
    
    % Position_____________________________________________________________
    
    % Format X Position
    k_r(1,k) = k_gains(7,1,k);
    k_r(2,k) = k_gains(7,2,k);
    k_r(3,k) = k_gains(7,3,k);
    
    % Format Y Position
    k_r(4,k) = k_gains(8,1,k);
    k_r(5,k) = k_gains(8,2,k);
    k_r(6,k) = k_gains(8,3,k);
    
    % Format Z Position
    k_r(7,k) = k_gains(9,1,k);
    k_r(8,k) = k_gains(9,2,k);
    k_r(9,k) = k_gains(9,3,k);
    
    % Velocity_____________________________________________________________
    
    % Format X Velocity
    k_v(1,k) = k_gains(4,1,k);
    k_v(2,k) = k_gains(4,2,k);
    k_v(3,k) = k_gains(4,3,k);
    
    % Format Y Velocity
    k_v(4,k) = k_gains(5,1,k);
    k_v(5,k) = k_gains(5,2,k);
    k_v(6,k) = k_gains(5,3,k);
    
    % Format Z Velocity
    k_v(7,k) = k_gains(6,1,k);
    k_v(8,k) = k_gains(6,2,k);
    k_v(9,k) = k_gains(6,3,k);
    
    % Attitude_____________________________________________________________
    
    % Format k_x
    k_a(1,k) = k_gains(1,1,k);
    k_a(2,k) = k_gains(1,2,k);
    k_a(3,k) = k_gains(1,3,k);
    
    % Format k_y
    k_a(4,k) = k_gains(2,1,k);
    k_a(5,k) = k_gains(2,2,k);
    k_a(6,k) = k_gains(2,3,k);
    
    % Format k_z
    k_a(7,k) = k_gains(3,1,k);
    k_a(8,k) = k_gains(3,2,k);
    k_a(9,k) = k_gains(3,3,k);
    
    
    
    
end

