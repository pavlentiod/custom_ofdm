function sig_after_fading_channel = fading_channel(ofdm_t, ofdm_symbol_params, fading_type)
    % Параметры многолучевого канала
    FadingType = fading_type;             % 'EPA', 'EVA','ETU'
    MaximumDopplerShift = ofdm_symbol_params.max_dopp;        % Hz
    Visualization = 'Off';          % 'Off', 'Impulse response', 'Frequency response', 'Impulse and frequency responses', 'Doppler spectrum' 
                                    % режим визуализации канала
    switch FadingType
        case 'EPA' 
            PathDelays = [0, 30, 70, 90, 110, 190, 410] * (10^-9);
            AveragePathGains = [0.0, -1.0, -2.0, -3.0, -8.0, -17.2, ...
                -20.8];
        case 'EVA' 
            PathDelays = [0, 30, 150, 310, 370, 710, 1090, 1730, ...
                2510] * (10^-9);
            AveragePathGains = [0.0, -1.5, -1.4, -3.6, -0.6, -9.1, ...
                -7.0, -12.0, -16.9];
        case 'ETU' 
            PathDelays = [0, 50, 120, 200, 230, 500, 1600, 2300, ...
                5000] * (10^-9);
            AveragePathGains = [-1.0, -1.0, -1.0, 0.0, 0.0, 0.0, ...
                -3.0, -5.0, -7.0];
    end


    FadingChannel = comm.RayleighChannel( ...
        'SampleRate', ofdm_symbol_params.fs, ...
        'PathDelays', PathDelays, ...
        'AveragePathGains', AveragePathGains, ...
        'MaximumDopplerShift', MaximumDopplerShift, ...
        'PathGainsOutputPort', 1, ...
        'Visualization', Visualization);


    sig_after_fading_channel = FadingChannel(ofdm_t);
    FadingChannel.release()
end

