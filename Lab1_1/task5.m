function task5(ofdm_symbol_params, SNR_values, doppler_shift)
    iterator = doppler_shift;
    ber_m = zeros(length(SNR_values), length(iterator));
    
    for i = 1:length(iterator)
        ofdm_symbol_params.max_dopp = iterator(i);
        ber_m(:,i) = get_ber_by_params(ofdm_symbol_params, SNR_values, "EPA");
    end
    
    % Параметры графика
    title = 'BER для разного значения Допплеровского сдвига';
    plot_multiple_lines(SNR_values, ber_m, title, iterator)
end

