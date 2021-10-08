function plot_sim(out, P)

%**************************************************************************
%% PVA Meas ---------------------------------------------------------------

plot_meas(out, P)

%% Plot Aiding Sensor Frame Measurements-----------------------------------

plot_aiding_sensor_meas(out, P)

%% Plot Kalman Filter Measurement Update Signals --------------------------

plot_KF_meas(out, P)

%% Plot Kalman Filter PVA Error Estimates ---------------------------------

plot_KF_error_est(out, P)

%% Plot Final PVA Estimates -----------------------------------------------

plot_PVA_est(out, P)

%% Plot Full 3D View ------------------------------------------------------

plot_3D_view(out, P)