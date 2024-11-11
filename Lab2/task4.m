function task4(ofdm_symbol_params, SNR_values, cp_s)
    ofdm_symbol_params.equalize = 1;
    ofdm_symbol_params.sync_by = "cp";
    
    iterator = cp_s;
    ber_m = zeros(length(SNR_values), length(iterator));
    
    for i = 1:length(iterator)
        ofdm_symbol_params.cp_to_sig = iterator(i);
        ber_m(:,i) = get_ber_by_params(ofdm_symbol_params, SNR_values, "EPA");
    end
    
    % Параметры графика
    title = 'BER для разного кол-ва символов синхронизации';
    plot_multiple_lines(SNR_values, ber_m, title, iterator)
end

