function plot_aiding_sensor_meas(out, P)

if (P.plot.plot_aiding_sensor_meas == true)

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
        
        % Determine Number of Frames
        num_frames = length(P.psi_fw_meas) + 1;
        n = 1 : num_frames;
        ypr = zeros(3, num_frames);
        
        % Plot C_t__b_cam Results
        for k = 2 : num_frames
            [ypr(3,:), ypr(2,:), ypr(1,:)] = dcm2ypr(out.C_t__b_cam(:,:,k));
        end
        
        % Plot Euler Rates of C_t__b_cam
        figure
        subplot(3,1,1)
        hold on
        plot(n, ypr(1,:) * 180/pi, 'r*')
        title('Kinect Camera:  Roll (\phi^t_t_b)')
        xlabel('Time (s)')
        ylabel('\phi^t_t_b (\circ)')
        grid on
        subplot(3,1,2)
        hold on
        plot(n, ypr(2,:) * 180/pi, 'g*')
        title('Kinect Camera:  Pitch (\theta^t_t_b)')
        xlabel('Time (s)')
        ylabel('\theta^t_t_b (\circ)')
        grid on
        subplot(3,1,3)
        hold on
        plot(n, ypr(3,:) * 180/pi, 'b*')
        title('Kinect Camera:  Yaw (\psi^t_t_b)')
        xlabel('Time (s)')
        ylabel('\psi^t_t_b (\circ)')
        grid on
        
    end
    
    %% Plot Barometer Measurements
    
    if (P.aiding_sensor_config == 7)
        
        figure
        hold on
        plot(t, out.z_baro_meas, 'b')
        title('Barometer:  r^t_t_b_,_z')
        xlabel('Time (s)')
        ylabel('r^t_t_b_,_z (m)')
        grid on
        
    end

end

