    function demodulated_ofdm = demodulate_ofdm_symbol(ofdm_symbol, ofdm_symbol_params)
        %% Входные параметры
        % ofdm_symbol  - Принятый OFDM символ (комплексный массив)
        % bps          - Биты на символ для данных
        % pilot_bps    - Биты на символ для пилотов
        % nFFT         - Размер БПФ
        % info_to_pilot - Количество поднесущих между пилотами
        % GI_to_Subc   - Отношение защитного интервала к поднесущей
        % cp_to_sig    - Отношение длины циклического префикса к длине сигнала

        bps = ofdm_symbol_params.bps;
        pilot_bps = ofdm_symbol_params.pilot_bps;
        nFFT = ofdm_symbol_params.nFFT;
        info_to_pilot = ofdm_symbol_params.info_to_pilot;
        GI_to_Subc = ofdm_symbol_params.GI_to_Subc;
        cp_to_sig = ofdm_symbol_params.cp_to_sig;

        % Защитный интервал (поднесущие с нулями)
        GI = nFFT * GI_to_Subc; 
    
        %% Удаление циклического префикса
        cp_length = floor(nFFT * cp_to_sig);  % Длина циклического префикса
        ofdm_symbol_no_cp = ofdm_symbol.t(cp_length + 1:end);  % Удаление циклического префикса
    
        %% Применение БПФ
        fft_subcarriers = fft(ofdm_symbol_no_cp, nFFT);  % Прямое БПФ
        fft_subcarriers = fftshift(fft_subcarriers);  % Сдвиг для правильной индексации
        
        % Equalizer
        if ofdm_symbol_params.equalize == 1
            fft_subcarriers = equalize_ofdm_symbol(fft_subcarriers, ofdm_symbol.p_indexes, ofdm_symbol.pilot_f);
        end

        %% Индексация поднесущих для пилотов и данных
        pilot_indexes = GI : info_to_pilot : nFFT - GI;
        info_indexes = GI + 1 : nFFT - GI;
    
        % Удаление индексов пилотных поднесущих из информационных поднесущих
        info_indexes(info_to_pilot:info_to_pilot:end) = [];
    
        %% Извлечение данных и пилотных символов
        data_symbols = fft_subcarriers(info_indexes);    % Извлечение информационных символов
        pilot_symbols = fft_subcarriers(pilot_indexes);  % Извлечение пилотных символов
    
        %% Демодуляция информационных и пилотных символов
        M = 2^bps;  % Порядок модуляции для информационных символов
        M_pil = 2^pilot_bps;  % Порядок модуляции для пилотных символов
        % Разделить символы на информационных поднесущих на коэффициенты
        % передачи канала
        data_bits = qamdemod(data_symbols, M, 'OutputType', 'bit', 'UnitAveragePower', true);
    
        pilot_bits = qamdemod(pilot_symbols, M_pil, 'OutputType', 'bit', 'UnitAveragePower', true);
    
        % Разбиение символов данных
        data_bits_by_bps = zeros(length(data_symbols), bps);
        for col=1:bps
            data_bits_by_bps(:, col) = data_bits(col:bps:length(data_bits));
        end
    
        % Разбиение символов пилотов
        pilot_bits_by_bps = zeros(length(pilot_symbols), pilot_bps);
        for col = 1:pilot_bps
            pilot_bits_by_bps(:, col) = pilot_bits(col:pilot_bps:length(pilot_bits));
        end

        % ВЫВОД
        demodulated_ofdm.bits = data_bits_by_bps;
        demodulated_ofdm.pilot_bits = pilot_bits_by_bps;
    end
