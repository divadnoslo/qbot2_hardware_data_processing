function [C_t__b_cam, psi_sigma] = get_C_t__b_cam(n_f, n_fw, n_sw, psi_fw_sigma, psi_sw_sigma, C_t__b_meas, C_t__b_est)

%% Estimate what the front wall and side wall align perpendicularly to...

% Determine Front Wall and Side Wall Axes Estimates
C_b__t_est = C_t__b_meas';
fw_est = C_b__t_est(:,1);
sw_est = C_b__t_est(:,2);

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

% Assign Axes
x_t_main = tan_axes(:,fw_ind);
y_t_main = tan_axes(:,sw_ind);
z_t_main = [0; 0; 1];    

%% Compute C_t__b_cam

% Define Body Frame Axes from Measurements, and Return Sigmas
if (psi_fw_sigma <= psi_sw_sigma)
    x_t = n_fw;
    y_t = (cross(n_fw, n_f));
    z_t = n_f;
    psi_sigma = psi_fw_sigma;
else
    x_t = -cross(n_sw, n_f);
    y_t = n_sw;
    z_t = n_f;
    psi_sigma = psi_sw_sigma;
end

% Build DCM
C_b__t_cam = [dot(x_t, x_t_main), dot(y_t, x_t_main), dot(z_t, x_t_main); ...
              dot(x_t, y_t_main), dot(y_t, y_t_main), dot(z_t, y_t_main); ...
              dot(x_t, z_t_main), dot(y_t, z_t_main), dot(z_t, z_t_main)];

% Transpose for Final Result
C_t__b_cam = C_b__t_cam;

end


