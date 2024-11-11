function bits = demodulate_ofdm_signal(signal)
    
    bits = [];

    sig_params = signal.params;


    for s=1:sig_params.N
        symb = signal;
        symb.t = signal.t(:, s);
        symb.f = signal.f(:, s);
        symb.pilot_f = signal.pilot_f(:, s);
        symb.bits = signal.bits((s-1)*4 + 1:(s-1)*4 + 4,:);
        dem = demodulate_ofdm_symbol(symb, sig_params.symbol_params);
        bits = [bits; dem.bits'];
    end
end