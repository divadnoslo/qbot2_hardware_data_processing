function plot_3D_view(out, P)

%% Plot 3D View

if (P.plot.full_3D_view_flag == true)
    
    % Set Title
    if (P.aiding_sensor_config == 0)
        tit_str = 'IMU Only:  ';
    elseif (P.aiding_sensor_config == 4)
        tit_str = 'IMU + Odo:  ';
    elseif (P.aiding_sensor_config == 5)
        tit_str = 'IMU + Kinect:  ';
    elseif (P.aiding_sensor_config == 6)
        tit_str = 'IMU + Odo + Kinect:  ';
    elseif (P.aiding_sensor_config == 7)
        tit_str = 'IMU + Odo + Kinect + Baro:  ';
    end
    
    % Rotate r_t__t_b data into C_c__c_b
    C_v__t = rotate_x(pi);
    for k = 1 : length(out.r_t__t_b_est)
        r_v__t_b_est(:,k) = (C_v__t * out.r_t__t_b_est(k,:)');
    end
    
    figure
    hold on
    
    if (P.plot.ground_truth == 0)
        % Qbot2 Travel Path
        line([0, 2.8], [0, 0], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([2.8, 2.8], [0, 2.8], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([2.8, 0], [2.8, 2.8], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([0, 0], [2.8, 0], [0, 0], 'Color', 'k', 'LineStyle', '--')
        % Outside Walls
        line([-1, 3.8], [-1, -1], [0, 0], 'Color', 'k', 'LineStyle', '-')
        line([3.8, 3.8], [-1, 3.8], [0, 0], 'Color', 'k', 'LineStyle', '-')
        line([3.8, -1], [3.8, 3.8], [0, 0], 'Color', 'k', 'LineStyle', '-')
        line([-1, -1], [3.8, -1], [0, 0], 'Color', 'k', 'LineStyle', '-')
    elseif (P.plot.ground_truth == 1)
        % Qbot2 Travel Path
        line([0, 2.8], [0, 0], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([2.8, 2.8], [0, -2.8], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([2.8, 0], [-2.8, -2.8], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([0, 0], [-2.8, 0], [0, 0], 'Color', 'k', 'LineStyle', '--')
        % Outside Walls
        line([-1, 3.8], [-1, -1], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([3.8, 3.8], [-1, -3.8], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([3.8, -1], [-2.8, -3.8], [0, 0], 'Color', 'k', 'LineStyle', '--')
        line([-1, -1], [-3.8, -1], [0, 0], 'Color', 'k', 'LineStyle', '--')
    end
    
    
    
    hold on
    plot3(r_v__t_b_est(1,:), r_v__t_b_est(2,:), r_v__t_b_est(3,:), 'mo', 'MarkerSize', 0.5)
    x = r_v__t_b_est(1,end); y = r_v__t_b_est(2,end); z = r_v__t_b_est(3,end);
    [psi, ~, ~] = dcm2ypr(out.C_t__b_est(:,:,end));
    viscircles([x, y], 0.35/2, 'Color', 'k')
    quiver3(x, y, z, 0.25*cos(psi), 0.25*sin(psi), 0, 'Color', 'c', 'LineWidth', 2.5) 
    quiver3(0,0,0,1,0,0,'Color','r','LineWidth',2)
    quiver3(0,0,0,0,-1,0,'Color','g','LineWidth',2)
    quiver3(0,0,0,0,0,-1,'Color','b','LineWidth',2)
    title([tit_str, 'Qbot2 Estimated Travel Path'])
    xlabel('x^t (m)')
    ylabel('y^t (m)')
    zlabel('z^t (m)')
    grid on
    axis equal
    view(0, 90)
    
end


%     C_v__t = rotate_x(pi);
%     r_v__t_b = C_v__t * r_t__t_b;
%     
%     % Bird's Eye View
%     figure
%     hold on
%     plot3(r_v__t_b(1,:), r_v__t_b(2,:), r_v__t_b(3,:))
%     plot_frame(C_v__t, [0; 0; 0], 't', []);
%     view(-69, 76)
%     xlim([min(r_v__t_b(1,:)) - 1,  max(r_v__t_b(1,:)) + 1])
%     ylim([min(r_v__t_b(2,:)) - 1,  max(r_v__t_b(2,:)) + 1])
%     zlim([-1 1])
%     title('Qbot 2 Motion Plan')
%     xlabel('X')
%     ylabel('Y')
%     grid on
