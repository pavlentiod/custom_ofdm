function task1(ofdm_symbol_params, SNR_values, subc_variants)
    ofdm_symbol_params.equalize = 0;
    ofdm_symbol_params.channel_on = 0;
    
    iterator = subc_variants;
    ber_m = zeros(length(SNR_values), length(iterator));
    
    for i = 1:length(iterator)
        ofdm_symbol_params.nFFT = iterator(i);
        ber_m(:,i) = get_ber_by_params(ofdm_symbol_params, SNR_values, "EPA");
    end
    
    % Параметры графика
    title = 'BER для разного количества поднесущих';
    plot_multiple_lines(SNR_values, ber_m, title, subc_variants)
end

