function plot_KF_covariance(out, P)
% Plot Kalman Filter Covariance (P_posteriori)

if (P.plot.plot_KF_covariance_flag == 1)
    
    % Establish Time
    t = P.t;
    
    % Format P
    P = format_P(out.P_posteriori);
    
    % Define Color Str
    clr_str = ['r', 'g', 'b'];
    
    % Plot Position Uncertianty
    %__________________________________________________________________________
    figure
    
    k = 1;
    subplot(3,1,k)
    hold on
    plot(t, P(7,:), clr_str(k))
    title('KF Covariance:  +1\sigma_r_,_x bound')
    xlabel('Time (s)')
    ylabel('(m)')
    zlim([0, t(end)])
    grid on
    
    k = 2;
    subplot(3,1,k)
    hold on
    plot(t, P(8,:), clr_str(k))
    title('KF Covariance:  +1\sigma_r_,_y bound')
    xlabel('Time (s)')
    ylabel('(m)')
    zlim([0, t(end)])
    grid on
    
    k = 3;
    subplot(3,1,k)
    hold on
    plot(t, P(9,:), clr_str(k))
    title('KF Covariance:  +1\sigma_r_,_z bound')
    xlabel('Time (s)')
    ylabel('(m)')
    zlim([0, t(end)])
    grid on
    
    % Plot Velocity Uncertianty
    %__________________________________________________________________________
    figure
    
    k = 1;
    subplot(3,1,k)
    hold on
    plot(t, P(4,:), clr_str(k))
    title('KF Covariance:  +1\sigma_v_,_x bound')
    xlabel('Time (s)')
    ylabel('(m/s)')
    zlim([0, t(end)])
    grid on
    
    k = 2;
    subplot(3,1,k)
    hold on
    plot(t, P(5,:), clr_str(k))
    title('KF Covariance:  +1\sigma_v_,_y bound')
    xlabel('Time (s)')
    ylabel('(m/s)')
    zlim([0, t(end)])
    grid on
    
    k = 3;
    subplot(3,1,k)
    hold on
    plot(t, P(6,:), clr_str(k))
    title('KF Covariance:  +1\sigma_v_,_z bound')
    xlabel('Time (s)')
    ylabel('(m/s)')
    zlim([0, t(end)])
    grid on
    
    % Plot Velocity Uncertianty
    %__________________________________________________________________________
    figure
    
    k = 1;
    subplot(3,1,k)
    hold on
    plot(t, P(1,:) * 180/pi, clr_str(k))
    title('KF Covariance:  +1\sigma_\phi bound')
    xlabel('Time (s)')
    ylabel('(\circ)')
    zlim([0, t(end)])
    grid on
    
    k = 2;
    subplot(3,1,k)
    hold on
    plot(t, P(2,:) * 180/pi, clr_str(k))
    title('KF Covariance:  +1\sigma_\theta bound')
    xlabel('Time (s)')
    ylabel('(\circ)')
    zlim([0, t(end)])
    grid on
    
    k = 3;
    subplot(3,1,k)
    hold on
    plot(t, P(3,:) * 180/pi, clr_str(k))
    title('KF Covariance:  +1\sigma_\psi bound')
    xlabel('Time (s)')
    ylabel('(\circ)')
    zlim([0, t(end)])
    grid on
    
end

end

