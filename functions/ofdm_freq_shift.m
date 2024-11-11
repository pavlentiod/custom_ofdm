function ofdm_symbol_shifted = ofdm_freq_shift(ofdm_symbol, ofdm_symbol_params, delta_f)
    % apply_frequency_shift - Применяет частотный сдвиг к OFDM символу.
    %
    % Входные параметры:
    %   ofdm_symbol        - структура, содержащая временную компоненту t
    %   ofdm_symbol_params - структура с параметрами OFDM символа
    %   delta_f            - частота сдвига в Гц
    %
    % Выход:
    %   ofdm_symbol_shifted - структура OFDM символа с частотным сдвигом
    
    % Вычисляем период дискретизации
    Ts = ofdm_symbol_params.ts;
    
    % Создаем временной вектор для символа (длиной N отсчетов)
    N = length(ofdm_symbol.t);
    time_vector = (0:N-1) * Ts;
    
    % Применяем частотный сдвиг
    ofdm_symbol_shifted = ofdm_symbol;
    ofdm_symbol_shifted.t = ofdm_symbol.t .* exp(1j * 2 * pi * delta_f * time_vector');
end
