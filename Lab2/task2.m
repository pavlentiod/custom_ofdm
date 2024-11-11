function task2(ofdm_symbol_params, cp_s)
    % Initialize an array to store correlation metrics
    corr_metrics = [];
    
    % Loop over different cyclic prefix-to-signal ratios
    for cp = 1:length(cp_s)
        % Set OFDM symbol parameters
        ofdm_symbol_params.cp_to_sig = cp_s(cp);
        
        % Generate OFDM signal with given parameters
        ofdm_sig = create_ofdm_symbol(ofdm_symbol_params);
        
        % Add time delay to the signal (example: 100 samples)
        ofdm_sig.t = add_time_delay(ofdm_sig.t, 100);
        
        % Perform synchronization by cyclic prefix and get correlation metric
        [sig, corr] = sync_by_cp(ofdm_sig.t, ofdm_symbol_params);
        
        % Store the correlation result
        corr_metrics = [corr_metrics corr];
    end
    
    % Plot the autocorrelation function metrics
    plot_AC_lines(1:2000, corr_metrics, "Autocorrelation Function", cp_s);
    
end
