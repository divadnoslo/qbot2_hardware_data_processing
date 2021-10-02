%% Load Qbot2 Data
% David Olson, 01 Oct 2021

close all
clear
clc

%% Load Desired Data

load('c__Complete_Data_Sets/SBT_CCW.mat')

% Save to Structure
P.Fs = Fs;                         % Hz
P.dt = dt;                         % s
P.t = t;                           % s
P.init_time = init_time;           % s
P.accel = accel;                   % m/s^2
P.gyro = gyro;                     % rad/s
P.odo = odo;                       % m
P.theta_meas = theta_meas;         % rad
P.theta_sigmas = theta_sigmas;     % rad
P.psi_fw_meas = psi_fw_meas;       % rad
P.psi_fw_sigmas = psi_fw_sigmas;   % rad
P.psi_sw_meas = psi_sw_meas;       % rad
P.psi_sw_sigmas = psi_sw_sigmas;   % rad

% Clear Variables
clear Fs dt t init_time accel gyro odo theta_meas theta_sigmas
clear psi_fw_meas psi_fw_sigmas psi_sw_meas psi_fw_sigmas

%% Load Supporting Data

% Load Transfer Alignment and Transfer Cal Data
load('d__Supporting_Data/Trans_Align.mat')
load('d__Supporting_Data/Trans_Cal.mat')

% Save Data to Structure
P.b_a_FB = b_a_FB;
P.b_g_FB = b_g_FB;
P.M_a = M_a; 
P.M_g = M_g;
P.C_b__imu = C_b__imu;

% Clear Variables
clear b_a_FB b_g_FB M_a M_g C_b__imu

%% Provide Initiialization Parameters

% Earth Characteristics (WGS-84 Values)
P.w_ie = 72.92115167e-6;                   % Earth's rotational rate (rad/s)
P.w_i__i_e = [0; 0; P.w_ie];               % Angular velocity of {e} wrt {i} resolved in {i} (rad/s)
P.Ohm_i__i_e = [0,      -P.w_ie, 0; ...         % Skew symmetric version of w_i__i_e (rad/s)
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
P.L_b = 34.61473980341071 * pi/180;          % rad
P.lambda_b = -112.45000967782227 * pi/180;   % rad
P.h_b = 1609.34; % m

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

%% Open Simulation

open('qbot2_post_processing.slx')

