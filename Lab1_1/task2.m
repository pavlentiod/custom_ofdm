function task2(ofdm_symbol_params, SNR_values, info_to_pilot_variants)
    ofdm_symbol_params.cp_to_sig = 0;
    
    iterator = info_to_pilot_variants;
    ber_m = zeros(length(SNR_values), length(iterator));
    
    for i = 1:length(iterator)
        ofdm_symbol_params.info_to_pilot = iterator(i);
        ber_m(:,i) = get_ber_by_params(ofdm_symbol_params, SNR_values, "EPA");
    end
    
    % Параметры графика
    title = 'BER для разного шага пилотных поднесущих';
    plot_multiple_lines(SNR_values, ber_m, title, info_to_pilot_variants)
end

