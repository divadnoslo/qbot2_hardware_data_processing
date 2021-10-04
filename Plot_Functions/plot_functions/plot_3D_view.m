function plot_3D_view(out, P)

%% Plot 3D View

if (P.plot.full_3D_view == true)
    
    % Set Meas to Est for Aid Config = 0
    if (P.aiding_sensor_config == 0)
        out.r_t__t_b_est = out.r_t__t_b_meas;
    end
    
    % Rotate r_t__t_b data into C_c__c_b
    C_v__t = rotate_x(pi);
    for k = 1 : length(out.r_t__t_b_est)
        r_v__t_b_est(:,k) = (C_v__t * out.r_t__t_b_est(k,:)');
    end
    
    figure
    hold on
    plot3(r_v__t_b_est(1,:), r_v__t_b_est(2,:), r_v__t_b_est(3,:), 'ko', 'MarkerSize', 0.5)
    quiver3(0,0,0,1,0,0,'Color','r','LineWidth',2)
    quiver3(0,0,0,0,-1,0,'Color','g','LineWidth',2)
    quiver3(0,0,0,0,0,-1,'Color','b','LineWidth',2)
    title('Qbot2 Estimated Travel Path')
    xlabel('x^t (m)')
    ylabel('y^t (m)')
    zlabel('z^t (m)')
    grid on
    axis equal
    view(-48, 39)
    
    if (P.plot.ground_truth == 0)
        line([0, 2.8], [0, 0], [0, 0], 'Color', 'k')
        line([2.8, 2.8], [0, 2.8], [0, 0], 'Color', 'k')
        line([2.8, 0], [2.8, 2.8], [0, 0], 'Color', 'k')
        line([0, 0], [2.8, 0], [0, 0], 'Color', 'k')
    elseif (P.plot.ground_truth == 1)
        line([0, 2.8], [0, 0], [0, 0], 'Color', 'k')
        line([2.8, 2.8], [0, -2.8], [0, 0], 'Color', 'k')
        line([2.8, 0], [-2.8, -2.8], [0, 0], 'Color', 'k')
        line([0, 0], [-2.8, 0], [0, 0], 'Color', 'k')
    end
    
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
