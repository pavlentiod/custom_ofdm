function ofdm_sig = create_ofdm_signal(ofdm_signal_params)
    symbN = ofdm_signal_params.N;

    ofdm_sig = create_ofdm_symbol(ofdm_signal_params.symbol_params);
    for i = 1:symbN-1
        ofdm_symbol = create_ofdm_symbol(ofdm_signal_params.symbol_params);
        ofdm_sig.t = [ofdm_sig.t, ofdm_symbol.t];
        ofdm_sig.f = [ofdm_sig.f, ofdm_symbol.f];
        ofdm_sig.pilot_f = [ofdm_sig.pilot_f, ofdm_symbol.pilot_f];
        ofdm_sig.bits = [ofdm_sig.bits; ofdm_symbol.bits];
        ofdm_sig.pilot_bits = [ofdm_sig.pilot_bits; ofdm_symbol.pilot_bits];
    end
end

