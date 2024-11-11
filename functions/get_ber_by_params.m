function ber = get_ber_by_params(ofdm_symbol_params, SNR_values, channel_type)
    ber = zeros(length(SNR_values), 1);
    
    for snr_i = 1:length(SNR_values)
        % Define SNR
        ofdm_symbol_params.SNR_dB = SNR_values(snr_i);

        % Create OFDM
        err = 0;
        n = 100;
        for n = 1:n
            ofdm_symbol = create_ofdm_symbol(ofdm_symbol_params);
            
            % Add AWGN
            ofdm_symbol.t = awgn(ofdm_symbol.t, ofdm_symbol_params.SNR_dB, 'measured');
        
            % Pass throw channel
            if ofdm_symbol_params.channel_on == 1
                ofdm_symbol.t = fading_channel(ofdm_symbol.t, ofdm_symbol_params, channel_type);
            end

            % Demodulate
            demodulated_ofdm = demodulate_ofdm_symbol(ofdm_symbol, ofdm_symbol_params);
        
            % Count errors
            e = count_errors(ofdm_symbol.bits, demodulated_ofdm.bits);
            err = err + e;
        end
        ber(snr_i) = err/(numel(ofdm_symbol.bits)*n);
        disp("----")
        disp(SNR_values(snr_i))
        disp(ber(snr_i))
    end
end

