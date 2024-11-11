function task1(ofdm_symbol_params, SNR_values, delay_variants)
    ofdm_symbol_params.equalize = 1;
    
    iterator = delay_variants;
    ber_m = zeros(length(SNR_values), length(iterator));
    
    for i = 1:length(iterator)
        ofdm_symbol_params.delay = iterator(i);
        ber_m(:,i) = get_ber_by_params(ofdm_symbol_params, SNR_values, "EPA");
    end
    
    % Параметры графика
    title = 'BER для разной длины задержки';
    plot_multiple_lines(SNR_values, ber_m, title, iterator)
end

