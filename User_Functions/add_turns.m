function C_t__b_cam = add_turns(C_t__b_est, C_t__b_cam_nom)

% Convert C_t__b_est to YPR
[yaw, ~, ~] = dcm2ypr(C_t__b_est);

% When yaw is centered around 0
if ((yaw > -pi/4) & (yaw < pi/4))
    yaw_add = 0;
    
% When yaw is centered around -pi/2    
elseif ((yaw > (-pi/2 - pi/4)) & (yaw < (-pi/2 + pi/4)))
    yaw_add = -pi/2;
    
% When yaw is centered around pi/2     
elseif ((yaw > (pi/2 - pi/4)) & (yaw < (pi/2 + pi/4)))
    yaw_add = pi/2;

% When abs(yaw) is centered at pi    
elseif (abs(yaw) > (pi/2 + pi/4))
    yaw_add = pi;
    
else
    yaw_add = 0;
    
end

% Add the turn to C_t__b_cam_nom
C_t__b_cam = rotate_z(yaw_add) * C_t__b_cam_nom;

end

