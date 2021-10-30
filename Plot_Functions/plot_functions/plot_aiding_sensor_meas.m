function plot_aiding_sensor_meas(out, P)

if (P.plot.plot_aiding_sensor_meas_flag == true)

    % Extract Time
    t = P.t;
    
    %% Plot Odometry Body Frame Speed Measurements
    if ((P.aiding_sensor_config == 4) || (P.aiding_sensor_config == 6) || (P.aiding_sensor_config == 7))
        
        % Plot Body Frame Speed
        figure
        hold on
        plot(t, out.v_b__t_b_odo(:,1), 'r')
        title('Body Frame Speed from Odometry')
        xlabel('Time (s)')
        ylabel('v^t_t_b_,_x (m/s)')
        grid on
        xlim([0 t(end)])
        
    end
    
    %% Plot Depth Camera Aiding
    if ((P.aiding_sensor_config == 5) || (P.aiding_sensor_config == 6) || (P.aiding_sensor_config == 7))
        
        % Plot C_t__b_cam Results
        
        % Find Yaw from C_t__b_cam
        psi = zeros(1, length(P.t));
        psi_meas = zeros(1, length(P.t));
        for k = 1 : length(P.t)
            [psi(k), ~, ~] = dcm2ypr(out.C_t__b_cam(:,:,k));
            [psi_meas(k), ~, ~] = dcm2ypr(out.C_t__b_imu(:,:,k));
        end
        
%         % Unwrap Everything
%         psi = unwrap(psi);
%         psi_meas = unwrap(psi_meas);
        
        % Capture Accepted Measurements
        mask_accepted = (out.SNHT_avail == 1);
        t_accepted = P.t(mask_accepted);
        psi_accepted = psi(mask_accepted);
        
        % Capture Rejected Measurements
        mask_rejected = (out.SNHT_avail == 0);
        t_rejected = P.t(mask_rejected);
        psi_rejected = psi(mask_rejected);
        
        % Plot Euler Rates of C_t__b_cam
        figure
        hold on
        plot(P.t, psi_meas * 180/pi, 'k')
        plot(t_accepted, psi_accepted * 180/pi, 'b*', ...
             t_rejected, psi_rejected * 180/pi, 'r*')
        title('Kinect Camera:  Yaw (\psi^t_t_b)')
        xlabel('Time (s)')
%         xlim([0 n(end)])
        ylabel('\psi^t_t_b (\circ)')
        grid on
        
    end
    
    %% Plot Barometer Measurements
    
    if (P.aiding_sensor_config == 7)
        
        figure
        hold on
        plot(t, out.z_baro, 'b')
        title('Barometer:  r^t_t_b_,_z')
        xlabel('Time (s)')
        ylabel('r^t_t_b_,_z (m)')
        grid on
        
    end

end

