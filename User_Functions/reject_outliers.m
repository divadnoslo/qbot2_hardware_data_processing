function [SNHT_avail, d] = reject_outliers(C_t__b_cam, C_t__b_est, psi_sigma, P_post)

%% Perform Outlier Rejection

% Extract Yaw from Estimate and Camera Measurement
[yaw_est, ~, ~] = dcm2ypr(C_t__b_est);
[yaw_cam, ~, ~] = dcm2ypr(C_t__b_cam);

% Angle Wrap if Neccessary
if (abs(yaw_cam - yaw_est) > pi)
    pos_adjust = (yaw_cam + 2*pi) - yaw_est;
    neg_adjust = (yaw_cam - 2*pi) - yaw_est;
    if (abs(pos_adjust) < abs(neg_adjust))
        yaw_cam = yaw_cam + 2*pi;
    else
        yaw_cam = yaw_cam - 2*pi;
    end
end

% Extract Uncertianty from C_t__b_est
[~, pitch, roll] = dcm2ypr(C_t__b_est);
J = [1, 0, -sin(pitch); ...
     0, cos(roll), sin(roll)*cos(pitch); ...
     0, -sin(roll), cos(roll)*cos(pitch)];
inv_J = inv(J);
R_k = P_post(1:3,1:3);
R_e = inv_J * R_k * inv_J';
sigma_est = R_e(3,3);

% Compute Total Uncertianty
sigma_tot = psi_sigma + sigma_est;
var_yaw_error = sigma_tot^2;

% Compute Mahalanobis Distance
d = sqrt((yaw_cam - yaw_est) * (1/var_yaw_error) * (yaw_cam - yaw_est));

% Accept or Reject
if (d <= 0.75) % 0.75 - 1.5
    SNHT_avail = 1;
else
    SNHT_avail = 0;
end

end

