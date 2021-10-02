function plot_3D_view(out, P)

%% Plot 3D View

if (P.plot.full_3D_view == true)
    
    % Set Meas to Est for Aid Config = 0
    if (P.aiding_sensor_config == 0)
        out.r_t__t_b_est = out.r_t__t_b_meas;
    end
    
    % Rotate r_t__t_b data into C_c__c_b
    C_c__t = rotate_x(pi);
    for k = 1 : length(out.r_t__t_b_est)
        out.r_t__t_b_est(k,:) = (C_c__t * out.r_t__t_b_est(k,:)')';
    end
    
    figure
    hold on
    plot3(out.r_t__t_b_est(:,1), out.r_t__t_b_est(:,2), out.r_t__t_b_est(:,3), 'bo')
    title('Qbot2 Estimated Travel Path')
    xlabel('x^t (m)')
    ylabel('y^t (m)')
    zlabel('z^t (m)')
    grid on
    view([60 45])
    
    if (P.plot.ground_truth == 0)
        line([0, 0, 0],      [2.8,    0, 0], 'Color', 'k')
        line([2.8, 0, 0],    [2.8, -2.8, 0], 'Color', 'k')
        line([2.8, -2.8, 0], [0, -2.8, 0], 'Color', 'k')
        line([0, -2.8, 0],   [0, 0, 0], 'Color', 'k')
    end
    
end

