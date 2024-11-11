function [signal , corr] = sync_by_cp(signal)
    MAX_DELAY = 2000;

    sig_params = signal.params;
    symb_params = signal.params.symbol_params;

    cp_length = floor(symb_params.nFFT * symb_params.cp_to_sig);
    data_length = symb_params.nFFT;
    symbol_length = data_length + cp_length;
    
    mean_delay = 0;
    for s=1:sig_params.nSync
        symb = signal.t(:, s);
        symb = [symb;zeros(length(symb)*2, 1)];

        corr = zeros(MAX_DELAY, 1);
        for lag = 1:MAX_DELAY
            wind1 = symb(lag+1:lag + cp_length);
            wind2 = symb (lag+data_length + 1:lag+symbol_length);
            corr_metric = xcorr(wind2, wind1, 0, "normalized");
            corr(lag) = corr_metric;
        end
        
        [~, estimate_delay] = max(corr);
        
        mean_delay = mean_delay + estimate_delay;
    end
%     estimate_delay
%     stem(1:MAX_DELAY, corr)
    mean_delay = floor(mean_delay/sig_params.nSync);
    signal.t = signal.t(mean_delay+1:mean_delay+symbol_length,:);
end
