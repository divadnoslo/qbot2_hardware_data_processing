function plot_outlier_rejection(out, P)
% Plot Outlier Rejection Results

if (P.plot.plot_outlier_reject_flag == 1)
    
    % Find Yaw from C_t__b_cam
    psi = zeros(1, length(P.t));
    psi_meas = zeros(1, length(P.t));
    psi_est_KF = zeros(1, length(P.t));
    psi_est_post = zeros(1, length(P.t));
    for k = 1 : length(P.t)
        [psi(k), ~, ~] = dcm2ypr(out.C_t__b_cam(:,:,k));
        [psi_meas(k), ~, ~] = dcm2ypr(out.C_t__b_imu(:,:,k));
        [psi_est_KF(k), ~, ~] = dcm2ypr(out.C_t__b_est_KF(:,:,k));
        [psi_est_post(k), ~, ~] = dcm2ypr(out.C_t__b_est(:,:,k));
    end
    
    % Capture Accepted Measurements
    mask_accepted = (out.SNHT_avail == 1);
    t_accepted = P.t(mask_accepted);
    psi_accepted = psi(mask_accepted);
    
    % Capture Rejected Measurements
    mask_rejected = (out.SNHT_avail == 0);
    t_rejected = P.t(mask_rejected);
    psi_rejected = psi(mask_rejected);
    
    % Capture KF Est
    n = 1;
    for k = 1 : length(P.t)
        if (mod(P.t(k),1) == 0)
            psi_est_KF_new(n) = psi_est_KF(k);
            n = n + 1;
        end
    end
    psi_est_KF = psi_est_KF_new;
    n = 1 : length(psi_est_KF);
    
    % Unwrap Everything
    psi_meas = unwrap(psi_meas);
    psi_est_KF = unwrap(psi_est_KF);
    psi_est_post = unwrap(psi_est_post);
    psi_accepted = unwrap(psi_accepted);
    psi_rejected = unwrap(psi_rejected);
    
    % Plot Accepted vs. Rejected Results
    figure
    hold on
    plot(P.t, psi_meas * 180/pi, 'k-', ...
         n, psi_est_KF * 180/pi, 'c*', ...
         P.t, psi_est_post * 180/pi, 'g-')
    plot(t_accepted, psi_accepted * 180/pi, 'b*', ...
        t_rejected, psi_rejected * 180/pi, 'r*')
    title('Accepted vs. Rejected SNHT Measurements')
    xlabel('Time (s)')
    ylabel('(\circ)')
    grid on
    xlim([0 floor(P.t(end))+1])
    legend('Yaw from IMU', 'Attitude Input into C cam', 'Post Yaw from KF', 'Accepted', 'Rejected', 'Location', 'SouthWest')
    x = (3/5) * P.t(end);
    y = 0;
    text(x, y, ['Final Value:  ', num2str(psi_est_post(end)*180/pi), '\circ'])
    
end

end