function plot_KF_meas(out, P)

if (P.plot.plot_KF_meas_flag == true)

    % Extract Time
    t = P.t;
    
    %% Plot Error in {t} 
    if ((P.aiding_sensor_config == 4) || (P.aiding_sensor_config == 6) || (P.aiding_sensor_config == 7))
        
        % Plot Body Frame Speed
        figure
        hold on
        subplot(4,1,1)
        plot(t, out.z_k_1(:,1), 'r')
        title('KF Meas Update: \deltav^t_t_b_,_x')
        xlabel('Time (s)')
        ylabel('\deltav^t_t_b_,_x (m/s)')
        grid on
        xlim([0 t(end)])
        subplot(4,1,2)
        plot(t, out.z_k_1(:,2), 'g')
        title('KF Meas Update: \deltav^t_t_b_,y')
        xlabel('Time (s)')
        ylabel('\deltav^t_t_b_,_y (m/s)')
        grid on
        xlim([0 t(end)])
        subplot(4,1,3)
        plot(t, out.z_k_1(:,3), 'b')
        title('KF Meas Update: \deltav^t_t_b_,_z')
        xlabel('Time (s)')
        ylabel('\deltav^t_t_b_,_z (m/s)')
        grid on
        xlim([0 t(end)])
        subplot(4,1,4)
        plot(t, out.ZVU_avail, 'k')
        title('Zero Velocity Update Availability')
        xlabel('Time (s)')
        ylabel('True (1) or False (0)')
        ylim([-0.2, 1.2])
        grid on
        
    end
    
    %% Plot Depth Camera Aiding
    if ((P.aiding_sensor_config == 5) || (P.aiding_sensor_config == 6) || (P.aiding_sensor_config == 7))
        
        % Determine Number of Frames
        num_frames = sum(out.SNHT_avail);
        n = 1 : num_frames;
        ypr = zeros(3, num_frames);
        
        % Shorten Down delta_C_t__b_meas
        z_k_2 = out.z_k_2(logical(out.SNHT_avail), :);
        
        % Plot delta_C_t__b_meas Results
        for k = 1 : num_frames
            [ypr(3,k), ypr(2,k), ypr(1,k)] = dcm2ypr(k2dcm(z_k_2(k,:)));
        end
        
        % Plot Euler Error of delta_C_t__b_meas
        figure
        subplot(3,1,1)
        hold on
        plot(n, ypr(1,:) * 180/pi, 'r*')
        title('KF Meas:  Error in Roll (\delta\phi^t_t_b)')
        xlabel('Time (s)')
        xlim([0 n(end)])
        ylabel('\delta\phi^t_t_b (\circ)')
        grid on
        subplot(3,1,2)
        hold on
        plot(n, ypr(2,:) * 180/pi, 'g*')
        title('KF Meas:  Error in Pitch (\delta\theta^t_t_b)')
        xlabel('Time (s)')
        xlim([0 n(end)])
        ylabel('\delta\theta^t_t_b (\circ)')
        grid on
        subplot(3,1,3)
        hold on
        plot(n, ypr(3,:) * 180/pi, 'b*')
        title('KF Meas:  Error in Yaw (\delta\psi^t_t_b)')
        xlabel('Time (s)')
        xlim([0 n(end)])
        ylabel('\delta\psi^t_t_b (\circ)')
        grid on
        
%         % Shorten Down Sigmas
%         theta_sigma = out.theta_sigma(logical(out.SNHT_avail));
%         psi_sigma = out.psi_sigma(logical(out.SNHT_avail));
%         
%         % Plot Extracted SNHT Sigmas
%         figure
%         hold on
%         subplot(2,1,1)
%         plot(n, theta_sigma * 180/pi, 'g*')
%         title('SNHT Pitch Uncertianty:  \sigma_\theta')
%         xlabel('Time (s)')
%         xlim([0 n(end)])
%         ylabel('\sigma_\theta (\circ)')
%         grid on
%         subplot(2,1,2)
%         hold on
%         plot(n, psi_sigma * 180/pi, 'b*')
%         title('SNHT Yaw Uncertianty:  \sigma_\psi')
%         xlabel('Time (s)')
%         xlim([0 n(end)])
%         ylabel('\sigma_\psi (\circ)')
%         grid on
        
        % Plot Angle Axis Error of delta_C_t__b_meas
        figure
        subplot(3,1,1)
        hold on
        plot(n, z_k_2(:,1) * 180/pi, 'r*')
        title('KF Meas: Error in Angle Axis Term 1 (\deltak_1)')
        xlabel('Time (s)')
        xlim([0 n(end)])
        ylabel('\deltak_1 (\circ)')
        grid on
        subplot(3,1,2)
        hold on
        plot(n, z_k_2(:,2) * 180/pi, 'g*')
        title('KF Meas: Error in Angle Axis Term 2 (\deltak_2)')
        xlabel('Time (s)')
        xlim([0 n(end)])
        ylabel('\deltak_2 (\circ)')
        grid on
        subplot(3,1,3)
        hold on
        plot(n, z_k_2(:,3) * 180/pi, 'b*')
        title('KF Meas: Error in Angle Axis Term 3 (\deltak_3)')
        xlabel('Time (s)')
        xlim([0 n(end)])
        ylabel('\deltak_3 (\circ)')
        grid on
%         subplot(4,1,4)
%         hold on
%         plot(t, out.d, 'k')
%         title('Outlier Rejection:  Mahalanobis Distance of each Measurement')
%         xlabel('Time (s)')
%         xlim([0 t(end)])
%         ylabel('Mahalanobis Distance (ratio)')
%         grid on
        
    end
    
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

