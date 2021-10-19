%% Load Qbot2 Data
% David Olson, 01 Oct 2021

% Start Fresh
close all
clear
clc

% Load User Functions
addpath('Nav_Functions', 'Plot_Functions', ...
        'Plot_Functions/plot_functions', 'User_Functions')

%% Load Desired Data

% Load Data File
load('c__Complete_Data_Sets/SBT_CCW.mat');    

%% Select Plotting Parameters

% Set Desired Plot Flags
P.plot.plot_IMU_meas_flag = false;
P.plot.plot_aiding_sensor_meas_flag = false;
P.plot.plot_outlier_reject_flag = true;
P.plot.plot_KF_meas_flag = false;
P.plot.plot_KF_error_est_flag =false;
P.plot.plot_KF_covariance_flag = false;
P.plot.plot_PVA_est_flag = false;
P.plot.full_3D_view_flag = true;

% Set Ground Truth for Plotting
% 0.) SBT_CCW
% 1.) SBT_CW
% 2.) King Building
P.plot.ground_truth = 0;

%% Select Aiding Sensor Configuration

% Allow User to Select Aiding Sensor Configuration
ASC = menu('Select Aiding Sensor Configuration', 'IMU Only', ...
           'IMU + Odo', 'IMU + Kinect', 'IMU + Odo + Kinect', ...
           'IMU + Odo + Kinect + Baro');

       % Select Desired Settings
       switch ASC
           case 1
               P.aiding_sensor_config = 0;
           case 2
               P.aiding_sensor_config = 4;
           case 3
               P.aiding_sensor_config = 5;
           case 4
               P.aiding_sensor_config = 6;
           case 5
               P.aiding_sensor_config = 7;
           otherwise
               error('Aiding Sensor Configuration not valid')
       end
       
       clear ASC

%% Load Supporting Data

% Load Transfer Alignment and Transfer Cal Data
load('d__Supporting_Data/Trans_Align.mat')
load('d__Supporting_Data/Trans_Cal.mat')
load('d__Supporting_Data/IMU_Cal_Varying_Error_Sources.mat')

% Save Data to Structure
P.b_a_FB = b_a_FB;
P.b_g_FB = b_g_FB;
P.M_a = M_a; 
P.M_g = M_g;
P.C_b__imu = C_b__imu;
P.accel_VRW = accel_VRW;
P.gyro_ARW = gyro_ARW;
P.sigma_n_accel = sigma_n_accel;
P.sigma_n_gyro = sigma_n_gyro;
P.cor_time = 1;

% Clear Variables
clear b_a_FB b_g_FB M_a M_g C_b__imu
clear accel_std accel_VRW gyro_ARW gyro_std 
clear sigma_ARW sigma_n_accel sigma_n_gyro sigma_VRW

%% Provide Initiialization Parameters

% Earth Characteristics (WGS-84 Values)
P.w_ie = 72.92115167e-6;                   % Earth's rotational rate (rad/s)
P.w_i__i_e = [0; 0; P.w_ie];               % Angular velocity of {e} wrt {i} resolved in {i} (rad/s)
P.Ohm_i__i_e = [0,      -P.w_ie, 0; ...    % Skew symmetric version of w_i__i_e (rad/s)
                P.w_ie,  0,      0; ...
                0,       0,      0];
P.mu = 3.986004418e14;      % Earth's gravitational constant (m^3/s^2)
P.J2 = 1.082627e-3;         % Earth's second gravitational constant
P.R0 = 6378137.0;           % Earth's equatorial radius (meters)
P.Rp = 6356752.314245;      % Earth's polar radius (meters)
P.e = 0.0818191908425;      % Eccentricity
P.f = 1 / 298.257223563;    % Flattening

%% Enter Lat/Long/Height from Test Location

% Test Location:  AXFAB Building at ERAU, Prescott AZ
P.L_b = 34.614939 * pi/180;          % rad
P.lambda_b = 247.549025 * pi/180;   % rad
P.h_b = 1557; % m

% Compute Additional Parameters
P.R_N = (P.R0*(1 - P.e^2)) / ((1 - P.e^2*sin(P.L_b)^2)^3/2);  % m
P.R_E = P.R0 / sqrt(1 - P.e^2*sin(P.L_b)^2);
P.C_e__n = Lat_Lon_2C_e__n(P.L_b, P.lambda_b);                      
P.C_n__t = eye(3); % Subject to change
P.C_e__t = P.C_e__n * P.C_n__t;
P.r_e__e_t = [(P.R_E + P.h_b)*cos(P.L_b)*cos(P.lambda_b); ...
              (P.R_E + P.h_b)*cos(P.L_b)*sin(P.lambda_b); ...  
              (P.R_E*(1 - P.e^2) + P.h_b) * sin(P.L_b)];
P.Ohm_t__i_e = P.C_e__t' * P.Ohm_i__i_e * P.C_e__t;

%% Initialize Measurementes based on first ten seconds

[P.f_b__i_b_meas, P.w_b__i_b_meas, ~, ~] = calibrate_imu(P);

[P.C_t__b_init, P.H_avg, P.pitch_trans_align] = init_conditions(P);

%% Open Simulation

open('qbot2_post_processing.slx')

