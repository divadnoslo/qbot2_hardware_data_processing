function plot_kalman_filter_tuning(r_KF_flag, v_KF_flag, psi_KF_flag, residuals_flag, z_k_X_flag, kalman_gains_flag, out, P)
% Plots truth minus estimate for error, w/ Covariance Matrix

% Build randn quantities from etrinsic functions
coder.extrinsic('unwrap');

% Extract Time
t = out.tout;

% Format P
P = format_P(out.P_posteriori);

% Position_________________________________________________________________
if (r_KF_flag == true)
    
    % Calculate Truth minus Error
    r_error = (out.P_truth - out.r_t__t_b_est)';
    
    figure
    subplot(3,1,1)
    hold on
    plot(t, r_error(1,:), 'r')
    plot(t, P(7,:), 'k', t, -P(7,:), 'k')
    title('KF Tuning Check:  True r^t_t_b_,_x - Estimated r^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
%     legend('r_x error', '\sigma_7_,_7', '-\sigma_7_,_7', 'Location', 'Best')
    grid on
    
    subplot(3,1,2)
    hold on
    plot(t, r_error(2,:), 'g')
    plot(t, P(8,:), 'k', t, -P(8,:), 'k')
    title('KF Tuning Check:  True r^t_t_b_,_y - Estimated r^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
%     legend('r_y error', '\sigma_8_,_8', '-\sigma_8_,_8', 'Location', 'Best')
    grid on
    
    subplot(3,1,3)
    hold on
    plot(t, r_error(3,:), 'b')
    plot(t, P(9,:), 'k', t, -P(9,:), 'k')
    title('KF Tuning Check:  True r^t_t_b_,_z - Estimated r^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
%     legend('r_z error', '\sigma_9_,_9', '-\sigma_9_,_9', 'Location', 'Best')
    grid on
    
end


if (v_KF_flag == true)
    
    % Calculate Truth minus Error
    v_error = (out.V_truth - out.v_t__t_b_est)';
    
    figure
    subplot(3,1,1)
    hold on
    plot(t, v_error(1,:), 'r')
    plot(t, P(4,:), 'k', t, -P(4,:), 'k')
    title('KF Tuning Check:  True v^t_t_b_,_x - Estimated v^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
%     legend('v_x error', '\sigma_4_,_4', '-\sigma_4_,_4', 'Location', 'Best')
    grid on
    
    subplot(3,1,2)
    hold on
    plot(t, v_error(2,:), 'g')
    plot(t, P(5,:), 'k', t, -P(5,:), 'k')
    title('KF Tuning Check:  True v^t_t_b_,_y - Estimated v^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
%     legend('v_y error', '\sigma_5_,_5', '-\sigma_5_,_5', 'Location', 'Best')
    grid on
    
    subplot(3,1,3)
    hold on
    plot(t, v_error(3,:), 'b')
    plot(t, P(6,:), 'k', t, -P(6,:), 'k')
    title('KF Tuning Check:  True v^t_t_b_,_z - Estimated v^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
%     legend('v_z error', '\sigma_6_,_6', '-\sigma_6_,_6', 'Location', 'Best')
    grid on
    
end


if (psi_KF_flag == true)
    
    % Convert delta_C_t__b into YPR
    ypr = zeros(3, length(t));
    for k = 1 : length(t)
        [ypr(3,k), ypr(2,k), ypr(1,k)] = dcm2ypr(out.C_t__b_est(:,:,k));
    end
    
    % Calculate Truth Minus Error
    unwrapped_psi = zeros(1, length(t));
    unwrapped_psi = unwrap(ypr(3,:));
    ypr(3,:) = unwrapped_psi;
    psi_error = (out.A_truth - ypr')';
    
    % Convert Angle-Axis Sigmas to Euler Angle Sigmas
    P_euler = zeros(3, length(t));
    for k = 1 : length(t)
        
        % Compute Jacobian
        roll = ypr(1,k);
        pitch = ypr(2,k);
        J = [1, 0, -sin(pitch); ...
             0, cos(roll), sin(roll)*cos(pitch); ...
             0, -sin(roll), cos(roll)*cos(pitch)];
        
        % Invert J
        inv_J = inv(J); 
         
        % Define R_e with known sigmas
        P_angle_axis = diag([P(1,k), P(2,k), P(3,k)]);
        
        % Convert R_e to R_k
         P_euler_cov = inv_J * P_angle_axis * inv_J';
         P_euler(:,k) = [P_euler_cov(1,1); P_euler_cov(2,2); P_euler_cov(3,3)];
        
    end
    
    % Begin Plots
    figure
    subplot(3,1,1)
    hold on
    plot(t, psi_error(1,:) * 180/pi, 'r')
    plot(t, P_euler(1,:) * 180/pi, 'k', t, -P_euler(1,:) * 180/pi, 'k')
    title('KF Tuning Check:  True \phi^t_t_b -  Estimated \phi^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
%     legend('\phi error', '\sigma_1_,_1', '-\sigma_1_,_1', 'Location', 'Best')
    grid on
    
    subplot(3,1,2)
    hold on
    plot(t, psi_error(2,:) * 180/pi, 'g')
    plot(t, P_euler(2,:) * 180/pi, 'k', t, -P_euler(2,:) * 180/pi, 'k')
    title('KF Tuning Check:  True \theta^t_t_b - Estimated \theta^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
%     legend('\theta error', '\sigma_2_,_2', '-\sigma_2_,_2', 'Location', 'Best')
    grid on
    
    subplot(3,1,3)
    hold on
    plot(t, psi_error(3,:) * 180/pi, 'b')
    plot(t, P_euler(3,:) * 180/pi, 'k', t, -P_euler(3,:) * 180/pi, 'k')
    title('KF Tuning Check:  True \psi^t_t_b - Estimated \psi^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
%     legend('\psi error', '\sigma_3_,_3', '-\sigma_3_,_3', 'Location', 'Best')
    grid on
    
end

if (residuals_flag == true)
    
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.residuals(:,1), 'r')
    title('Measurement Residuals (z_1 - H*x_1)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    hold on
    subplot(3,1,2)
    plot(t, out.residuals(:,2), 'g')
    title('Measurement Residuals (z_2 - H*x_2)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    subplot(3,1,3)
    plot(t, out.residuals(:,3), 'b')
    title('Measurement Residuals (z_3 - H*x_3)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    hold off
    
end

if (z_k_X_flag == true)
    
    if (sum(sum(out.z_k_1)) ~= 0)
        
        figure
        subplot(3,1,1)
        hold on
        plot(t, out.z_k_1(:,1), 'r')
        title('KF Measurements:  z_1 = \deltav^t_t_b_,_x (meas)')
        xlabel('Time (s)')
        xlim([0 t(end)])
        ylabel('m/s')
        grid on
        
        subplot(3,1,2)
        hold on
        plot(t, out.z_k_1(:,2), 'g')
        title('KF Measurements:  z_2 = \deltav^t_t_b_,_y (meas)')
        xlabel('Time (s)')
        xlim([0 t(end)])
        ylabel('m/s')
        grid on
        
        subplot(3,1,3)
        hold on
        plot(t, out.z_k_1(:,3), 'b')
        title('KF Measurements:  z_3 = \deltav^t_t_b_,_z (meas)')
        xlabel('Time (s)')
        xlim([0 t(end)])
        ylabel('m/s')
        grid on
        
    end
        
    if (sum(sum(out.z_k_2)) ~= 0)
        
        z_k_2 = zeros(3, length(t));
        for k = 1 : length(t)
            [yaw, pitch, roll] = dcm2ypr(k2dcm(out.z_k_2(k,:)'));
            z_k_2(:,k) = [roll; pitch; yaw];
        end
        
        figure
        subplot(3,1,1)
        hold on
        plot(t, out.z_k_2(:,1) * 180/pi, 'r')
        title('KF Measurements:  z_1 = \delta\phi^t_t_b (meas)')
        xlabel('Time (s)')
        xlim([0 t(end)])
        ylabel('(\circ)')
        grid on
        
        subplot(3,1,2)
        hold on
        plot(t, out.z_k_2(:,2) * 180/pi, 'g')
        title('KF Measurements:  z_2 = \delta\theta^t_t_b (meas)')
        xlabel('Time (s)')
        xlim([0 t(end)])
        ylabel('(\circ)')
        grid on
        
        subplot(3,1,3)
        hold on
        plot(t, out.z_k_2(:,3) * 180/pi, 'b')
        title('KF Measurements:  z_3 = \delta\psi^t_t_b (meas)')
        xlabel('Time (s)')
        xlim([0 t(end)])
        ylabel('(\circ)')
        grid on
        
    end
    
    
end
    
% Kalman Gains
if (kalman_gains_flag == true)
    
    % Format K_____________________________________________________________
    
    [k_r, k_v, k_a] = format_K(out.kalman_gains);
    
    % Position_____________________________________________________________
    figure
    subplot(3,1,1)
    plot(t, k_r(1,:), 'm', ...
         t, k_r(2,:), 'g', ...
         t, k_r(3,:), 'c')
    title('Kalman Gains:  X-Position')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on
    
    subplot(3,1,2)
    plot(t, k_r(4,:), 'm', ...
         t, k_r(5,:), 'g', ...
         t, k_r(6,:), 'c')
    title('Kalman Gains:  Y-Position')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on
    
    subplot(3,1,3)
    plot(t, k_r(7,:), 'm', ...
         t, k_r(8,:), 'g', ...
         t, k_r(9,:), 'c')
    title('Kalman Gains:  Z-Position')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on

    
    % Velocity_____________________________________________________________
    figure
    subplot(3,1,1)
    plot(t, k_v(1,:), 'm', ...
         t, k_v(2,:), 'g', ...
         t, k_v(3,:), 'c')
    title('Kalman Gains:  X-Velocity')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on
    
    subplot(3,1,2)
    plot(t, k_v(4,:), 'm', ...
         t, k_v(5,:), 'g', ...
         t, k_v(6,:), 'c')
    title('Kalman Gains:  Y-Velocity')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on
    
    subplot(3,1,3)
    plot(t, k_v(7,:), 'm', ...
         t, k_v(8,:), 'g', ...
         t, k_v(9,:), 'c')
    title('Kalman Gains:  Z-Velocity')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on
    
    % Attitude_____________________________________________________________
    figure
    subplot(3,1,1)
    plot(t, k_a(1,:), 'm', ...
         t, k_a(2,:), 'g', ...
         t, k_a(3,:), 'c')
    title('Kalman Gains:  Angle Axis Comp. k_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on
    
    subplot(3,1,2)
    plot(t, k_a(4,:), 'm', ...
         t, k_a(5,:), 'g', ...
         t, k_a(6,:), 'c')
    title('Kalman Gains:  Angle Axis Comp. k_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on
    
    subplot(3,1,3)
    plot(t, k_a(7,:), 'm', ...
         t, k_a(8,:), 'g', ...
         t, k_a(9,:), 'c')
    title('Kalman Gains:  Angle Axis Comp. k_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('K gains')
    grid on

end

