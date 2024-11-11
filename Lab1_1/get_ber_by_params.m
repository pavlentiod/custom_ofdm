function ber = get_ber_by_params(ofdm_symbol_params, SNR_values, channel_type)
    ber = zeros(length(SNR_values), 1);
    
    for snr_i = 1:length(SNR_values)
        % Define SNR
        ofdm_symbol_params.SNR_dB = SNR_values(snr_i);

        % Create OFDM
        ofdm_symbol = create_ofdm_symbol(ofdm_symbol_params);
    
        % Add AWGN
        ofdm_symbol.t = awgn(ofdm_symbol.t, ofdm_symbol_params.SNR_dB, 'measured');
    
        % Pass throw channel
        ofdm_symbol.faded_t = fading_channel(ofdm_symbol.t, ofdm_symbol_params, channel_type);
    
        % Demodulate
        demodulated_ofdm = demodulate_ofdm_symbol(ofdm_symbol, ofdm_symbol_params);
    
        % Count errors
        ber(snr_i) = count_errors(ofdm_symbol.bits, demodulated_ofdm.bits)/length(ofdm_symbol.bits);
    end
end

