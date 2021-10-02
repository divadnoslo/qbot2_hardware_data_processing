function plot_state_est_error(delta_r_t__t_b_est_flag, ...
                              delta_v_t__t_b_est_flag, ...
                              delta_psi_t__t_b_est_flag, out, P)
                          
                          
% Plot the Kalman Filter State Outputs
t = out.tout;

if (delta_r_t__t_b_est_flag == true)
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.Delta_r_t__t_b(:,1), 'k', t, out.delta_r_t__t_b_est(:,1), 'r')
    title('Estimated Error in Position on X^t-Axis   (\deltar^t_t_b_,_x)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    subplot(3,1,2)
    plot(t, out.Delta_r_t__t_b(:,2), 'k', t, out.delta_r_t__t_b_est(:,2), 'g')
    title('Estimated Error in Position on Y^t-Axis   (\deltar^t_t_b_,_y)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    subplot(3,1,3)
    plot(t, out.Delta_r_t__t_b(:,3), 'k', t, out.delta_r_t__t_b_est(:,3), 'b')
    title('Estimated Error in Position on Z^t-Axis   (\deltar^t_t_b_,_z)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    legend('\Deltar', '\deltar', 'Location', 'Best')
    grid on
    
end

if (delta_v_t__t_b_est_flag == true)
        
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.Delta_v_t__t_b(:,1), 'k', t, out.delta_v_t__t_b_est(:,1), 'r')
    title('Estimated Error in Velocity on X^t-Axis   (\deltav^t_t_b_,_x)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    subplot(3,1,2)
    plot(t, out.Delta_v_t__t_b(:,2), 'k', t, out.delta_v_t__t_b_est(:,2), 'g')
    title('Estimated Error in Velocity on Y^t-Axis   (\deltav^t_t_b_,_y)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    subplot(3,1,3)
    plot(t, out.Delta_v_t__t_b(:,3), 'k', t, out.delta_v_t__t_b_est(:,3), 'b')
    title('Estimated Error in Velocity on Z^t-Axis   (\deltav^t_t_b_,_z)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    legend('\Deltav', '\deltav', 'Location', 'Best')
    grid on
    
end


if (delta_psi_t__t_b_est_flag == true)
    
    for ii = 1 : length(t)
        [yaw(ii), pitch(ii), roll(ii)] = dcm2ypr(out.delta_C_t__b_est(:,:,ii));
    end
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.Delta_euler_t__t_b(:,1) * 180/pi, 'k', t, roll * 180/pi, 'r')
    title('Estimated Error in Roll   (\delta\phi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
    grid on
    subplot(3,1,2)
    plot(t, out.Delta_euler_t__t_b(:,2) * 180/pi, 'k', t, pitch * 180/pi, 'g')
    title('Estimated Error in Pitch   (\delta\theta^t_t_b)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
    grid on
    subplot(3,1,3)
    plot(t, out.Delta_euler_t__t_b(:,3) * 180/pi, 'k', t, yaw * 180/pi, 'b')
    title('Estimated Error in Yaw   (\delta\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
    grid on
    
end

