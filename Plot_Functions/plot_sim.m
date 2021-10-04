function plot_sim(out, P)

%**************************************************************************
%% Plot Full 3D VIew

plot_3D_view(out, P)

%% PVA Meas ---------------------------------------------------------------

plot_meas(out, P)

%% Plot Aiding Sensor Frame Measurements-----------------------------------

plot_aiding_sensor_meas(out, P)

%% Plot Kalman Filter Measurement Update Signals --------------------------

plot_KF_meas(out, P)

% %% Plot IMU I/O -----------------------------------------------------------
% 
% plot_IMU(accel_flag, gyro_flag, delta_accel_flag, delta_gyro_flag, out, P)
%               
% %% Plot PVA Error ---------------------------------------------------------
% 
% plot_error(delta_p_flag, delta_v_flag, delta_a_flag, out, P)
% 
% %% Plot State Estimate for PVA Errors--------------------------------------
% 
% plot_state_est_error(delta_r_t__t_b_est_flag, delta_v_t__t_b_est_flag, ...
%                      delta_psi_t__t_b_est_flag, out, P)
%                   
% %% Plot Kalman Filter Tuning Check-----------------------------------------
% 
% plot_kalman_filter_tuning(r_KF_flag, v_KF_flag, psi_KF_flag, residuals_flag, z_k_X_flag, kalman_gains_flag, out, P)
%                  
% %% Plot Truth vs Estimates-------------------------------------------------
% 
% plot_truth_vs_est(r_truth_vs_est_flag, v_truth_vs_est_flag, ...
%                                              psi_truth_vs_est_flag, out, P)
%                                          
% %% Plot Complimentary Filter Outputs
% 
% plot_comp_filter(comp_filt_flag, psd_plot_flag, plot_omega_z_only, out, P)
% 
% %% Plot Odometry Aiding Sensor Outputs
% 
% plot_odo_outputs(plot_wheel_vel, plot_ang_vel_odo, plot_body_speed_odo, plot_C_t__b_comp, plot_tan_speed_odo, out, P)
% 
% %% Plot Kalman Filter Meas (z_k_x) PSD's
% 
% plot_KF_meas_PSD(zk1_psd_flag, zk2_psd_flag, out, P)
% 
% %% Plot Barometer Data
% 
% plot_baro(plot_baro_flag, out, P)