function plot_KF_error_est(out, P)

%% Begin Plots
if (P.plot.plot_KF_error_est_flag == true)

    %% Data Preparation________________________________________________________
    
    % Extract Time
    t = P.t;
    
    % Extract PVA
    pos = out.delta_r_t__t_b_est';
    vel = out.delta_v_t__t_b_est';
    rpy = zeros(3, length(t));
    for ii = 1 : length(t)
        [rpy(3,ii), rpy(2,ii), rpy(1,ii)] = dcm2ypr(out.delta_C_t__b_est(:,:,ii));
    end
    
%     % Unwrap Yaw
%     rpy(3,:) = unwrap(rpy(3,:));
    
%% Position Truth Plot_____________________________________________________
    
    % X-Position
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'r')
    title('KF Estimate: \deltar^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\deltar^t_t_b_,_x (m)')
    grid on
    hold off
    
    % Y-Position
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'g')
    title('KF Estimate: \deltar^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\deltar^t_t_b_,_y (m)')
    grid on
    hold off
    
    % Z-Position
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'b')
    title('KF Estimate: \deltar^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\deltar^t_t_b_,_z (m)')
    grid on
    hold off
    

%% Velocity Truth Plot_____________________________________________________
    
    % X-Velocity
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'r')
    title('KF Estimate: \deltav^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\deltav^t_t_b_,_x (m/s)')
    grid on
    hold off
    
    % Y-Velocity
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'g')
    title('KF Estimate: \deltav^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\deltav^t_t_b_,_y (m/s)')
    grid on
    hold off
    
    % Z-Velocity
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'b')
    title('KF Estimate: \deltav^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\deltav^t_t_b_,_z (m/s)')
    grid on
    hold off
    
%% Attitude________________________________________________________________
    
    % Roll
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'r')
    title('KF Estimate:  (\delta\phi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\delta\phi^t_t_b (\circ)')
    grid on
    
    % Pitch
    k = 2;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'g')
    title('KF Estimate:  (\delta\theta^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\delta\theta^t_t_b (\circ)')
    grid on
    
    % Yaw
    k = 3;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'b')
    title('KF Estimate:  (\delta\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\delta\psi^t_t_b (\circ)')
    grid on
    
end

end

