function training_symbol = create_training_symbol_80211a()
    training_symbol_params.bps = 4;              % Биты на символ (QAM-16)
    training_symbol_params.pilot_bps = 2;        % Биты на символ для пилотов (QPSK)
    training_symbol_params.info_to_pilot = 8;   % Число субкредитов между пилотами
    training_symbol_params.GI_to_Subc = 0.125;  
    training_symbol_params.cp_to_sig = 0.2;      % Отношение циклического префикса к длине сигнала
    training_symbol_params.null_cp = 0;

    % Short preamble 10x64
    training_symbol_params.nFFT = 64;          % Число точек FFT для Short preamble
    ofdm_symbol = create_ofdm_symbol(training_symbol_params);
    short_preamble_data = ofdm_symbol.t(ofdm_symbol.cp_len+ 1:end);
    short_preamble = repmat(short_preamble_data, 10, 1);

    % Long preamble CP+2x128
    training_symbol_params.nFFT = 64; % Число точек FFT для Long preamble
    ofdm_symbol = create_ofdm_symbol(training_symbol_params);
    long_preamble_cp = ofdm_symbol.t(1:ofdm_symbol.cp_len);
    long_preamble_data = ofdm_symbol.t(ofdm_symbol.cp_len+ 1:end);
    training_symbol = [short_preamble;long_preamble_cp; repmat(long_preamble_data, 2, 1)];
end

