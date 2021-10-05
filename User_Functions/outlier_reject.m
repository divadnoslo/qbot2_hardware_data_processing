function [SNHT_avail, d] = outlier_reject(delta_k_t__t_b_est, delta_k_t__t_b_meas, R_k)

% Set Threshold
threshold = 4;

% Compute Mahalonobis Distnaces
d = sqrt((delta_k_t__t_b_meas(3) - delta_k_t__t_b_est(3)) * ...
         (1 / R_k(3,3)) * ...
         (delta_k_t__t_b_meas(3) - delta_k_t__t_b_est(3)));

% Determine if Measurement should be rejected
if (d <= threshold)
    SNHT_avail = 1;
else
    SNHT_avail = 0;
end

end

