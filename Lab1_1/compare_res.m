% Параметры OFDM
bps = 4;              % Bits per symbol (QAM-16)
pilot_bps = 2;        % Bits per symbol for pilots (QPSK)
info_to_pilot = 64;   % Subcarriers between pilot symbols
GI_to_Subc = 0.25;    % Guard Interval (Cyclic Prefix) to Subcarrier ratio
cp_to_sig = 0.2;     % Cyclic Prefix to signal ratio
nSymb = 2;
nFFT = 2048;
SNR_dB = 100;
t_symb = 100e-6;
fs = nFFT/t_symb;

% Значения для исследования
nFFT_values = [512, 1024, 2048];  % Разные значения FFT
SNR_dB_values = -60:5:20;  % Диапазон значений SNR от -60 до 20 дБ с шагом 5

% ﻿Помехоустойчивость приема сигналов с OFDM в канале с АБГШ для разного количества информационных поднесущих
% errors_matrix = investigate_ofdm_performance(SNR_dB_values, nFFT_values, bps, pilot_bps, info_to_pilot, GI_to_Subc, cp_to_sig);

% Помехоустойчивость приема сигналов с OFDM в канале с замираниями (максимальный допплеровский сдвиг 0 Гц) при использовании эквалайзера на приеме без защитного интервала по времени для разного шага пилотных поднесущих
pilot_spacing_steps = [4, 8, 16, 32, 64, 128, 256, 512, 1024];
fs = 1e6; % Частота дискретизации
% ofdm_pilot_analysis(pilot_spacing_steps, fs, bps, pilot_bps, nFFT, nSymb, GI_to_Subc, cp_to_sig);



%% TASK 3
% Помехоустойчивость приема сигналов с OFDM в канале с замираниями при использовании эквалайзера на приеме для разных защитных интервалов (нулевое заполнение и циклический префикс)
cp_to_sig_arr = [0.05, 0.35, 0.45];  % Значения защитных интервалов (в долях от OFDM символа)
ber_results = zeros(length(cp_to_sig_arr), 1);

    
% Релеевский канал
EPA_awg_path_gains = [0 30 70 90 110 190 410];
EPA_path_delays = [0 -1 -2 -3 -8 -17.2 -20.8];
chan = comm.RayleighChannel('ChannelFiltering', 1, 'MaximumDopplerShift', 0, 'AveragePathGains', EPA_awg_path_gains, 'SampleRate', fs, 'PathDelays', EPA_path_delays);

for i = 1:length(cp_to_sig_arr)
    % Генерация одного символа
    [ofdm_symbol, bits, pilot_bits] = create_ofdm_symbol(bps, pilot_bps, nFFT, info_to_pilot, GI_to_Subc, cp_to_sig_arr(i));
    
    % Переход через канал
    ofdm_from_channel = chan(ofdm_symbol);
    release(chan)

    % Добавление шума к переданному OFDM символу
    ofdm_symbol_gauss = awgn(ofdm_from_channel, SNR_dB);
    
    % Демодуляция
    [data_bits_by_bps, ~] = demodulate_ofdm_symbol(ofdm_symbol_gauss, bps, pilot_bps, nFFT, info_to_pilot, GI_to_Subc, cp_to_sig_arr(i));
    
    % Вычисление количества ошибок
    errors_count = sum(abs(data_bits_by_bps' - bits), "all");
    disp([cp_to_sig_arr(i) errors_count]);
    ber_results(i) = errors_count;
end

% Построение графиков
figure;
plot(cp_to_sig_arr, ber_results, '-o');
xlabel('Относительная длина ЦП');
ylabel('Кол-во ошибок на символ');
title('Анализ помехоустойчивости OFDM при разных длинах ЦП');
grid on;
