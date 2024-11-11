clear; 
clc;
addpath("functions\")
addpath("Lab2\")

% Параметры OFDM
ofdm_symbol_params.bps = 4;              % Bits per symbol (QAM-16)
ofdm_symbol_params.pilot_bps = 2;        % Bits per symbol for pilots (QPSK)
ofdm_symbol_params.info_to_pilot = 16;   % Subcarriers between pilot symbols
ofdm_symbol_params.GI_to_Subc = 0.125;    % Guard Interval (Cyclic Prefix) to Subcarrier ratio
ofdm_symbol_params.cp_to_sig = 0.3;     % Cyclic Prefix to signal ratio
ofdm_symbol_params.nFFT = 2048;
ofdm_symbol_params.t_symb = 100e-6;
ofdm_symbol_params.fs = ofdm_symbol_params.nFFT/ofdm_symbol_params.t_symb;
ofdm_symbol_params.ts = 1 / ofdm_symbol_params.fs; 
ofdm_symbol_params.equalize = 1;
ofdm_symbol_params.null_cp = 0;
ofdm_symbol_params.max_dopp = 0;
ofdm_symbol_params.sync_by = "";
ofdm_symbol_params.delay = 0;

% 
% Ось Х
% SNR_values = 0:4:40;
% 
% task 1. COMPLETED
% delay_variants = 50:10:100;
% task1(ofdm_symbol_params, SNR_values, delay_variants);
% 
% task 2
% cp_lengths = 0.1:0.1:0.4;
% task2(ofdm_symbol_params, cp_lengths);
% 
% 
% task3(ofdm_symbol_params, SNR_values, cp_lengths)
% sig = create_ofdm_signal(ofdm_symbol_params, 2);