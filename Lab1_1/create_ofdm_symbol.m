function ofdm_symbol_output = create_ofdm_symbol(ofdm_symbol_params)
    %% Входные параметры
    % bps         - Биты на символ для данных
    % pilot_bps   - Биты на символ для пилотов
    % nFFT        - Размер БПФ
    % info_to_pilot - Количество поднесущих между пилотами
    % GI_to_Subc  - Отношение защитного интервала к поднесущей
    % cp_to_sig   - Отношение длины циклического префикса к длине сигнала
    bps = ofdm_symbol_params.bps;
    pilot_bps = ofdm_symbol_params.pilot_bps;
    nFFT = ofdm_symbol_params.nFFT;
    info_to_pilot = ofdm_symbol_params.info_to_pilot;
    GI_to_Subc = ofdm_symbol_params.GI_to_Subc;
    cp_to_sig = ofdm_symbol_params.cp_to_sig;
    % Защитный интервал (поднесущие с нулями)
    GI = nFFT * GI_to_Subc;
    %% Расчет параметров модуляции
    M = 2^bps;             % Порядок модуляции для информационных символов
    M_pil = 2^pilot_bps;   % Порядок модуляции для пилотных символов

    %% Инициализация массива поднесущих OFDM
    ofdm_subcarriers = zeros(nFFT, 1);

    %% Индексация поднесущих для пилотов и данных
    pilot_indexes = GI : info_to_pilot : length(ofdm_subcarriers) - GI;
    info_indexes = GI + 1 : length(ofdm_subcarriers) - GI;

    % Удаление индексов пилотных поднесущих из информационных поднесущих
    info_indexes(info_to_pilot:info_to_pilot:end) = [];
    
    %% Создание информационных символов
    info_subcarries_number = length(info_indexes);
    bits = randi([0, 1], log2(M), info_subcarries_number);  % Генерация случайных битов
    data_symbols = qammod(bits, M, 'InputType', 'bit', 'UnitAveragePower', true);

    % Вставка информационных символов в поднесущие
    
    ofdm_subcarriers(info_indexes) = data_symbols;

    %% Создание пилотных символов
    pilot_bits = randi([0, 1], log2(M_pil), 1);   % Генерация случайных битов для пилотов
    pilot_symbol = qammod(pilot_bits, M_pil, 'InputType', 'bit', 'UnitAveragePower', true);

    % Вставка пилотных символов в поднесущие
    ofdm_subcarriers(pilot_indexes) = pilot_symbol;

    %% Применение ОБПФ (сдвиг перед применением ОБПФ)
    shifted_ofdm_subcarriers = ifftshift(ofdm_subcarriers);
    ifft_subcarriers = ifft(shifted_ofdm_subcarriers, nFFT);

    %% Добавление циклического префикса
    n = length(ifft_subcarriers);
    cp_length = floor(n * cp_to_sig);  % Длина циклического префикса

    % Извлечение последней части для циклического префикса
    cyclic_prefix = ifft_subcarriers(end - cp_length + 1:end);

    if ofdm_symbol_params.null_cp == 1
        cyclic_prefix = zeros(cp_length, 1);
    end


    % Присоединение циклического префикса к началу символа
    ofdm_symbol = [cyclic_prefix; ifft_subcarriers];

    % ВЫВОД
    ofdm_symbol_output.t = ofdm_symbol;
    ofdm_symbol_output.f = shifted_ofdm_subcarriers;
    ofdm_symbol_output.pilot_f = pilot_symbol;
    ofdm_symbol_output.cp_len = length(cyclic_prefix);
    ofdm_symbol_output.bits = bits;
    ofdm_symbol_output.pilot_bits = pilot_bits;
    ofdm_symbol_output.i_indexes = info_indexes;
    ofdm_symbol_output.p_indexes = pilot_indexes;

end
