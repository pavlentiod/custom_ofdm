function bers = get_ber_by_params_signal(ofdm_signal_params, SNR_values)
    bers = [];

    for snr=SNR_values
        ofdm_signal_params.SNR = snr;
        sig = create_ofdm_signal(ofdm_signal_params);
        sig.params = ofdm_signal_params;
        
        
        if ofdm_signal_params.max_delay > 0
            sig.t = add_time_delay_signal(sig);
        end
        
    %     % Apply AWGN
        sig.t = awgn(sig.t, ofdm_signal_params.SNR, 'measured');
        
        % Sync by CP
        if ofdm_signal_params.sync_by == "cp"
            sig = sync_by_cp(sig);
        end
        
        % Demodulate signal
        bits = demodulate_ofdm_signal(sig);
        
        bers = [bers; count_signal_ber(sig.bits, bits)];
    end
end

