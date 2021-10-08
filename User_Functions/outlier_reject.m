function [SNHT_avail, d] = outlier_reject(C_t__b_est, C_t__b_cam, R_e)

% Set Threshold
threshold = 0.95;

% Extract the YPR from each dcm
[yaw_est, pitch_est, roll_est] = dcm2ypr(C_t__b_est);
e_est = [roll_est; pitch_est; yaw_est];
[yaw_cam, pitch_cam, roll_cam] = dcm2ypr(C_t__b_cam);
e_cam = [roll_cam; pitch_cam; yaw_cam];

% Normalize every measurement/estimate to the sigma's
sigmas = [R_e(1); R_e(2); R_e(3)];
e_est = e_est ./ sigmas;
e_cam = e_cam ./ sigmas;

% Compute Mahalonobis Distnaces
d = sqrt((e_cam - e_est)'  * (e_cam - e_est));

% Determine if Measurement should be rejected
if (d <= threshold)
    SNHT_avail = 1;
else
    SNHT_avail = 0;
end

end

