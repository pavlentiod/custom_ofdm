function task3(ofdm_symbol_params, SNR_values, cp_var, nulls)
    if nulls == 1
        ofdm_symbol_params.null_cp = 1;
    end
    iterator = cp_var;
    ber_m = zeros(length(SNR_values), length(iterator));
    
    for i = 1:length(iterator)
        ofdm_symbol_params.cp_to_sig = iterator(i);
        ber_m(:,i) = get_ber_by_params(ofdm_symbol_params, SNR_values, "EPA");
    end
    
    % Параметры графика
    title = ['BER для разной длины ЦП. Заполнение нулями:', num2str(nulls)];
    plot_multiple_lines(SNR_values, ber_m, title, iterator)
end

