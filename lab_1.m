clear; 
clc;
addpath("functions\")
addpath("Lab1\")

% Параметры OFDM
ofdm_symbol_params.bps = 4;              % Bits per symbol (QAM-16)
ofdm_symbol_params.pilot_bps = 2;        % Bits per symbol for pilots (QPSK)
ofdm_symbol_params.info_to_pilot = 16;   % Subcarriers between pilot symbols
ofdm_symbol_params.GI_to_Subc = 0.125;    % Guard Interval (Cyclic Prefix) to Subcarrier ratio
ofdm_symbol_params.cp_to_sig = 0.2;     % Cyclic Prefix to signal ratio
ofdm_symbol_params.nFFT = 2048;
ofdm_symbol_params.t_symb = 100e-6;
ofdm_symbol_params.fs = ofdm_symbol_params.nFFT/ofdm_symbol_params.t_symb;
ofdm_symbol_params.equalize = 1;
ofdm_symbol_params.channel_on = 1;
ofdm_symbol_params.null_cp = 0;
ofdm_symbol_params.max_dopp = 0;

% Ось Х
SNR_values = 0:4:40;

% ﻿Помехоустойчивость приема сигналов с OFDM в канале с АБГШ для разного количества информационных поднесущих
subc_variants = [64, 512, 2048];
task1(ofdm_symbol_params, SNR_values, subc_variants)

% КАНАЛ С ЗАМИРАНИЯМИ + ЭКВАЛАЙЗЕР
% % ﻿Помехоустойчивость приема без защитного интервала по времени для разного шага пилотных поднесущих
info_to_pilot_variants = [4, 1024];
task2(ofdm_symbol_params, SNR_values, info_to_pilot_variants)
% 
% % % Помехоустойчивость приема для разных защитных интервалов по времени (заполнение нулями и циклический префикс)
cp_var = [0, 0.1 , 0.3, 0.4, 1];
nulls = 0;
task3(ofdm_symbol_params, SNR_values, cp_var, nulls)
% 
% % % Помехоустойчивость приема для разных значений максимального допплеровского сдвига при фиксированной длине циклического префикса
doppler_shift = 1:20:100;
task5(ofdm_symbol_params, SNR_values, doppler_shift)