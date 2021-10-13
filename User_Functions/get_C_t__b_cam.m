function [C_t__b_cam, psi_sigma, SNHT_avail] = get_C_t__b_cam(n_f, n_fw, n_sw, psi_fw_sigma, psi_sw_sigma, C_t__b_meas, C_t__b_est)

%% Estimate what the front wall and side wall align perpendicularly to...

% Determine Front Wall and Side Wall Axes Estimates
fw_est = C_t__b_meas(:,1);
sw_est = C_t__b_meas(:,2);

% Create Possible Tan Frame Alignments
tan_axes = [ 1, 0, 0; ...
             0,  1, 0; ...
            -1,  0, 0; ...
             0, -1, 0]';

% Test Each Possibility via the Mahalanobis Distance
d_fw = [0; 0; 0; 0];
d_sw = [0; 0; 0; 0];
for k = 1 : 4
    d_fw(k) = sqrt((fw_est - tan_axes(:,k))' * (fw_est - tan_axes(:,k))) / 2;
    d_sw(k) = sqrt((sw_est - tan_axes(:,k))' * (sw_est - tan_axes(:,k))) / 2;
end

% Determine most likely tan axis alignment for each body axis
[~, fw_ind] = min(d_fw);
[~, sw_ind] = min(d_sw);

% Determine if it meets the threshold.  Threshold is 0.1736, as determined from
% User_Functions/find_threshold.mlx, which corresponds to the vector being
% within 20 degrees the selected tan frame axis
% threshold = 0.1736;
threshold = 0.32;

% When both axes are outside 20 nominal degrees
if ((d_fw(fw_ind) > threshold) & (d_sw(sw_ind) > threshold))
    SNHT_avail = 0;
    fw_axis = [0; 0; 0];
    sw_axis = [0; 0; 0];
    psi_fw_sigma = 45 * pi/180;
    psi_sw_sigma = 45 * pi/180;
    
% When both axes are within the threshold  
elseif ((d_fw(fw_ind) <= threshold) & (d_sw(sw_ind) <= threshold))
    SNHT_avail = 1;
    fw_axis = tan_axes(:,fw_ind);
    sw_axis = tan_axes(:,sw_ind);

% When only the front wall axis is aligned
elseif ((d_fw(fw_ind) <= threshold) & (d_sw(sw_ind) > threshold))
    SNHT_avail = 1;
    fw_axis = tan_axes(:,fw_ind);
    sw_axis = [0; 0; 0];
    psi_sw_sigma = 45 * pi/180;

% When only the side wall axis is aligned
elseif ((d_fw(fw_ind) > threshold) & (d_sw(sw_ind) <= threshold))
    SNHT_avail = 1;
    fw_axis = [0; 0; 0];
    sw_axis = tan_axes(:,sw_ind);
    psi_fw_sigma = 45 * pi/180;
    
else
    SNHT_avail = 0;
    fw_axis = [0; 0; 0];
    sw_axis = [0; 0; 0];
    psi_fw_sigma = 45 * pi/180;
    psi_sw_sigma = 45 * pi/180;
    
end
    
%% Compute C_t__b_cam

if (SNHT_avail == 1)
    
    % Assign applicable tan axis to local frame
    x_l = fw_axis;
    y_l = sw_axis;
    z_t = [0; 0; 1];
    
    % Define Body Frame Axes from Measurements, and Return Sigmas
    if (psi_fw_sigma <= psi_sw_sigma)
        x_b = n_fw;
        y_b = -(cross(n_fw, n_f));
        z_b = n_f;
        psi_sigma = psi_fw_sigma;
    else
        x_b = cross(n_sw, n_f);
        y_b = n_sw;
        z_b = n_f;
        psi_sigma = psi_sw_sigma;
    end
    
    % Build DCM
    C_b__t_cam = [dot(x_b, x_l), dot(y_b, x_l), dot(z_b, x_l); ...
                  dot(x_b, y_l), dot(y_b, y_l), dot(z_b, y_l); ...
                  dot(x_b, z_t), dot(y_b, z_t), dot(z_b, z_t)];
              
    % Transpose for Final Result
    C_t__b_cam = C_b__t_cam';
    
%% Perform Outlier Rejection
    
    % Extract Yaw from Estimate and Camera Measurement
    [yaw_est, ~, ~] = dcm2ypr(C_t__b_meas);
    [yaw_cam, ~, ~] = dcm2ypr(C_t__b_cam);
    
    % Compute Mahalanobis Distance with throwing away measurements outside of
    % 15 degrees
    d = sqrt((yaw_cam - yaw_est) * (yaw_cam - yaw_est)) /(2*pi);
    
    % Accept or Reject
    if (d <= (33/360))
        SNHT_avail = 1;
    else
        SNHT_avail = 0;
    end
    
else
    
    C_t__b_cam = eye(3);
    psi_sigma = 45 * pi/180;
    
end

