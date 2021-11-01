function plot_IMU_meas(out, P)

%% Begin Plots
if (P.plot.plot_IMU_meas_flag == true)

    %% Data Preparation________________________________________________________
    
    % Extract Time
    t = P.t;
    
    % Extract PVA
    pos = out.r_t__t_b_imu';
    vel = out.v_t__t_b_imu';
    rpy = zeros(3, length(t));
    for ii = 1 : length(t)
        [rpy(3,ii), rpy(2,ii), rpy(1,ii)] = dcm2ypr(out.C_t__b_imu(:,:,ii));
    end
    
    % Unwrap Yaw
    rpy(3,:) = unwrap(rpy(3,:));
    
    %% Plot Accel Data_____________________________________________________
    figure
    subplot(3,1,1)
    plot(t, out.f_b__i_b_meas(:,1), 'r')
    title('f^b_i_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('f^b_i_b_,_x (m/s^2)')
    grid on
    subplot(3,1,2)
    plot(t, out.f_b__i_b_meas(:,2), 'g')
    title('f^b_i_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('f^b_i_b_,_y (m/s^2)')
    grid on
    subplot(3,1,3)
    plot(t, out.f_b__i_b_meas(:,3), 'b')
    title('f^b_i_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('f^b_i_b_,_z (m/s^2)')
    grid on
    
    %% Plot Gyro Data______________________________________________________
    figure
    subplot(3,1,1)
    plot(t, out.w_b__i_b_meas(:,1) * 180/pi, 'r')
    title('\omega^b_i_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\omega^b_i_b_,_x (\circ/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.w_b__i_b_meas(:,2) * 180/pi, 'g')
    title('\omega^b_i_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\omega^b_i_b_,_y (\circ/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.w_b__i_b_meas(:,3) * 180/pi, 'b')
    title('\omega^b_i_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\omega^b_i_b_,_z (\circ/s)')
    grid on
   
    
%% Position Truth Plot_____________________________________________________
    
    % X-Position
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'r')
    title('IMU Only Measurement: r^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_x (m)')
    x = P.t_end - 9*P.t_end/10;
    y = pos(k,end) - pos(k,end)/2;
    text(x, y, ['Final Drift: ', num2str(pos(k,end)), ' m'])
    grid on
    hold off
    
    % Y-Position
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'g')
    title('IMU Only Measurement: r^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_y (m)')
    x = P.t_end - 9*P.t_end/10;
    y = pos(k,end) - pos(k,end)/2;
    text(x, y, ['Final Drift: ', num2str(pos(k,end)), ' m'])
    grid on
    hold off
    
    % Z-Position
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'b')
    title('IMU Only Measurement: r^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_z (m)')
    x = P.t_end - 9*P.t_end/10;
    y = pos(k,end) - pos(k,end)/2;
    text(x, y, ['Final Drift: ', num2str(pos(k,end)), ' m'])
    grid on
    hold off
    

%% Velocity Truth Plot_____________________________________________________
    
    % X-Velocity
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'r')
    title('IMU Only Measurement: v^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_x (m/s)')
    x = P.t_end - 9*P.t_end/10;
    y = vel(k,end) - vel(k,end)/2;
    text(x, y, ['Final Drift: ', num2str(vel(k,end)), ' m/s'])
    grid on
    hold off
    
    % Y-Velocity
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'g')
    title('IMU Only Measurement: v^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_y (m/s)')
    x = P.t_end - 9*P.t_end/10;
    y = vel(k,end) - vel(k,end)/2;
    text(x, y, ['Final Drift: ', num2str(vel(k,end)), ' m/s'])
    grid on
    hold off
    
    % Z-Velocity
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'b')
    title('IMU Only Measurement: v^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_z (m/s)')
    x = P.t_end - 9*P.t_end/10;
    y = vel(k,end) - vel(k,end)/2;
    text(x, y, ['Final Drift: ', num2str(vel(k,end)), ' m/s'])
    grid on
    hold off
    
%% Attitude________________________________________________________________
    
    % Roll
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'r')
    title('IMU Only Measurement: Roll (\phi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\phi^t_t_b (\circ)')
    x = P.t_end - 9*P.t_end/10;
    y = rpy(k,end) - rpy(k,end)/2;
    text(x, y * 180/pi, ['Final Drift: ', num2str(rpy(k,end) * 180/pi), '\circ'])
    grid on
    
    % Pitch
    k = 2;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'g')
    title('IMU Only Measurement: Pitch (\theta^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\theta^t_t_b (\circ)')
    x = P.t_end - 9*P.t_end/10;
    y = rpy(k,end) - rpy(k,end)/2;
    text(x, y * 180/pi, ['Final Drift: ', num2str(rpy(k,end) * 180/pi), '\circ'])
    grid on
    
    % Yaw
    k = 3;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'b')
    title('IMU Only Measurement: Yaw (\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\psi^t_t_b (\circ)')
    x = P.t_end - 9*P.t_end/10;
    y = rpy(k,end) - rpy(k,end)/2;
    text(x, y * 180/pi, ['Final Drift: ', num2str(rpy(k,end) * 180/pi), '\circ'])
    grid on
    
    % Plot Yaw Only
    nd = floor(P.t(end)) + 1;
    figure
    hold on
    line([0 nd], [0 0], 'Color', 'y', 'LineWidth', 0.5)
    line([0 nd], [90 90], 'Color', 'y', 'LineWidth', 0.5)
    line([0 nd], [180 180], 'Color', 'y', 'LineWidth', 0.5)
    line([0 nd], [270 270], 'Color', 'y', 'LineWidth', 0.5)
    line([0 nd], [360 360], 'Color', 'y', 'LineWidth', 0.5)
    plot(t, rpy(k,:) * 180/pi, 'b')
    title('IMU Only Measurement: Yaw (\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\psi^t_t_b (\circ)')
    grid on
    
end
