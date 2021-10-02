function plot_baro(plot_baro_flag, out, P)

if (plot_baro_flag == true)
    
    t = out.tout;
    
    figure
    plot(t, out.baro_meas, 'b')
    title('Barometer Height Measurements in the {t} frame')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Height (m)')
    ylim([min(out.baro_meas) - 0.3, max(out.baro_meas) + 0.3])
    text(1, min(out.baro_meas) - 0.2, ...
        ['\sigma_b_a_r_o = ', num2str(std(out.baro_meas)), ' m'])
    grid on
    
    figure
    plot(t, out.z_k_3, 'b')
    title('Height Error (z_k_,_3) passed into the Kalman Filter')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Error in Height (m)')
    ylim([min(out.z_k_3) - 0.3, max(out.z_k_3) + 0.3])
    text(1, min(out.z_k_3) - 0.2, ...
        ['\sigma_z_k_,_3 = ', num2str(std(detrend(out.z_k_3))), ' m'])
    grid on
    
end
    
end

