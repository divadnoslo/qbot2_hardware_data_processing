function plot_KF_meas(out, P)

if (P.plot.plot_KF_meas == true)

    % Extract Time
    t = P.t;
    
    %% Plot Error in {t} 
    if ((P.aiding_sensor_config == 4) || (P.aiding_sensor_config == 6) || (P.aiding_sensor_config == 7))
        
        % Plot Body Frame Speed
        figure
        hold on
        subplot(3,1,1)
        plot(t, out.z_k_1(:,1), 'r')
        title('KF Meas Update: \deltav^t_t_b_,_x')
        xlabel('Time (s)')
        ylabel('\deltav^t_t_b_,_x (m/s)')
        grid on
        xlim([0 t(end)])
        subplot(3,1,2)
        plot(t, out.z_k_1(:,2), 'g')
        title('KF Meas Update: \deltav^t_t_b_,y')
        xlabel('Time (s)')
        ylabel('\deltav^t_t_b_,_y (m/s)')
        grid on
        xlim([0 t(end)])
        subplot(3,1,3)
        plot(t, out.z_k_1(:,3), 'b')
        title('KF Meas Update: \deltav^t_t_b_,_z')
        xlabel('Time (s)')
        ylabel('\deltav^t_t_b_,_z (m/s)')
        grid on
        xlim([0 t(end)])
        
    end
    
%     %% Plot Depth Camera Aiding
%     if ((P.aiding_sensor_config == 5) || (P.aiding_sensor_config == 6) || (P.aiding_sensor_config == 7))
%         
%         % Determine Number of Frames
%         num_frames = sum(out.SNHT_avail);
%         n = 1 : num_frames;
%         ypr = zeros(3, num_frames);
%         
%         % Shorten Down C_t__b_cam
%         C_t__b_cam = out.C_t__b_cam(:,:,logical(out.SNHT_avail));
%         
%         % Plot C_t__b_cam Results
%         for k = 1 : num_frames
%             [ypr(3,:), ypr(2,:), ypr(1,:)] = dcm2ypr(C_t__b_cam(:,:,k));
%         end
%         
%         % Plot Euler Rates of C_t__b_cam
%         figure
%         subplot(3,1,1)
%         hold on
%         plot(n, ypr(1,:) * 180/pi, 'r*')
%         title('Kinect Camera:  Roll (\phi^t_t_b)')
%         xlabel('Time (s)')
%         xlim([0 n(end)])
%         ylabel('\phi^t_t_b (\circ)')
%         grid on
%         subplot(3,1,2)
%         hold on
%         plot(n, ypr(2,:) * 180/pi, 'g*')
%         title('Kinect Camera:  Pitch (\theta^t_t_b)')
%         xlabel('Time (s)')
%         xlim([0 n(end)])
%         ylabel('\theta^t_t_b (\circ)')
%         grid on
%         subplot(3,1,3)
%         hold on
%         plot(n, ypr(3,:) * 180/pi, 'b*')
%         title('Kinect Camera:  Yaw (\psi^t_t_b)')
%         xlabel('Time (s)')
%         xlim([0 n(end)])
%         ylabel('\psi^t_t_b (\circ)')
%         grid on
%         
%     end
    
    %% Plot Barometer Measurements
    
    if (P.aiding_sensor_config == 7)
        
        figure
        hold on
        plot(t, out.z_k_3, 'b')
        title('KF Meas Update:  \deltar^t_t_b_,_z')
        xlabel('Time (s)')
        ylabel('\deltar^t_t_b_,_z (m)')
        grid on
        
    end

end

end

