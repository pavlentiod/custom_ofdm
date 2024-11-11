function [h, t] = fading_channel_model(fs, channel_type)
    % Определяем профиль канала на основе параметра channel_type
    switch channel_type
        case 'EPA'
            delay_ns = [0, 30, 70, 90, 110, 190, 410];  % Задержки (ns)
            relative_power_dB = [0, -1, -2, -3, -8, -17.2, -20.8];  % Мощность (дБ)
        case 'ETU'
            delay_ns = [0, 50, 120, 200, 230, 500, 1600, 2300, 5000];  % Задержки (ns)
            relative_power_dB = [-1.0, -1.0, -1.0, 0.0, 0.0, 0.0, -3.0, -5.0, -7.0];  % Мощность (дБ)
        case 'EVA'
            delay_ns = [0, 30, 150, 310, 370, 710, 1090, 1730, 2510];  % Задержки (ns)
            relative_power_dB = [0.0, -1.5, -1.4, -3.6, -0.6, -9.1, -7.0, -12.0, -16.9];  % Мощность (дБ)
        otherwise
            error('Неверный тип канала. Используйте EPA, ETU или EVA.');
    end

    % Преобразование задержек в секунды
    delay_sec = delay_ns * 1e-9;  % Перевод из наносекунд в секунды

    % Преобразование мощности из дБ в линейную шкалу
    relative_power_linear = 10.^(relative_power_dB / 10);

    % Импульсный отклик канала (h)
    % Для каждого пути генерируется импульс с амплитудой, пропорциональной мощности пути и задержкой.
  
    h = zeros(1, round(max(delay_ns) * fs * 1e-9) + 1);  % Инициализация
    for i = 1:length(delay_ns)
        % Индекс с учетом задержки в отсчетах
        delay_samples = round(delay_sec(i) * fs);  
        h(delay_samples + 1) = sqrt(relative_power_linear(i));  % Амплитуда для данного пути
    end
    
    % Время выборок
    t = (0:length(h)-1) / fs;  % Время в секундах
end
