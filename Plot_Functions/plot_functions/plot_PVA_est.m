function plot_PVA_est(out, P)

%% Begin Plots
if (P.plot.plot_PVA_est_flag == true)
    
    %% Data Preparation________________________________________________________
    
    % Extract Time
    t = P.t;
    
    % Extract PVA
    pos = out.r_t__t_b_est';
    vel = out.v_t__t_b_est';
    rpy = zeros(3, length(t));
    for ii = 1 : length(t)
        [rpy(3,ii), rpy(2,ii), rpy(1,ii)] = dcm2ypr(out.C_t__b_est(:,:,ii));
    end
    
    % Unwrap Yaw
    rpy(3,:) = unwrap(rpy(3,:));
    
    %% Position Truth Plot_____________________________________________________
    
    % X-Position
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'r')
    title('Position Estimate: r^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_x (m)')
    x = P.t_end - 9*P.t_end/10;
    y = pos(k,end) - pos(k,end)/2;
    text(x, y, ['Final Value: ', num2str(pos(k,end)), ' m'])
    grid on
    hold off
    
    % Y-Position
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'g')
    title('Position Estimate: r^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_y (m)')
    x = P.t_end - 9*P.t_end/10;
    y = pos(k,end) - pos(k,end)/2;
    text(x, y, ['Final Value: ', num2str(pos(k,end)), ' m'])
    grid on
    hold off
    
    % Z-Position
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'b')
    title('Position Estimate: r^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_z (m)')
    x = P.t_end - 9*P.t_end/10;
    y = pos(k,end) - pos(k,end)/2;
    text(x, y, ['Final Value: ', num2str(pos(k,end)), ' m'])
    grid on
    hold off
    
    
    %% Velocity Truth Plot_____________________________________________________
    
    % X-Velocity
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'r')
    title('Velocity Estimate: v^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_x (m/s)')
    x = P.t_end - 9*P.t_end/10;
    y = vel(k,end) - vel(k,end)/2;
    text(x, y, ['Final Value: ', num2str(pos(k,end)), ' m/s'])
    grid on
    hold off
    
    % Y-Velocity
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'g')
    title('Velocity Estimate: v^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_y (m/s)')
    x = P.t_end - 9*P.t_end/10;
    y = vel(k,end) - vel(k,end)/2;
    text(x, y, ['Final Value: ', num2str(pos(k,end)), ' m/s'])
    grid on
    hold off
    
    % Z-Velocity
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'b')
    title('Velocity Estimate: v^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_z (m/s)')
    x = P.t_end - 9*P.t_end/10;
    y = vel(k,end) - vel(k,end)/2;
    text(x, y, ['Final Value: ', num2str(pos(k,end)), ' m/s'])
    grid on
    hold off
    
    %% Attitude________________________________________________________________
    
    % Roll
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'r')
    title('Attitude Estimate: (\phi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\phi^t_t_b (\circ)')
    x = P.t_end - 9*P.t_end/10;
    y = rpy(k,end) - rpy(k,end)/2;
    text(x, y * 180/pi, ['Final Value: ', num2str(rpy(k,end) * 180/pi), '\circ'])
    grid on
    
    % Pitch
    k = 2;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'g')
    title('Attitude Estimate: (\theta^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\theta^t_t_b (\circ)')
    x = P.t_end - 9*P.t_end/10;
    y = rpy(k,end) - rpy(k,end)/2;
    text(x, y * 180/pi, ['Final Value: ', num2str(rpy(k,end) * 180/pi), '\circ'])
    grid on
    
    % Yaw
    k = 3;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'b')
    title('Attitude Estimate: (\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\psi^t_t_b (\circ)')
    x = P.t_end - 9*P.t_end/10;
    y = rpy(k,end) - rpy(k,end)/2;
    text(x, y * 180/pi, ['Final Value: ', num2str(rpy(k,end) * 180/pi), '\circ'])
    grid on
    
end

end

