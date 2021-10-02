function plot_point_cloud(xyz, title_str)
% Provide XYZ point cloud size[3, 3072, 1] to plot

figure
hold on
plot3(xyz(1,:), xyz(2,:), xyz(3,:), 'b.');
viscircles([0,0], 0.35/2, 'Color', 'k');
quiver3(0,0,0,0.25,0,0, 'Color', 'r', 'LineWidth', 3);
title(title_str)
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
xlim([-0.5 3.5])

axis equal
view([-156.521 13.341])
grid on
hold off

end

