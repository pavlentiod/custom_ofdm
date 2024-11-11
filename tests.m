% test sync by cp
clc;
num_symb = 50;
i = 5:5:25;
bers =  [];
for j = i
    ofdm_symbol_params.n_sync = j;
    ofdm_sig = create_ofdm_signal(ofdm_symbol_params, num_symb);
    ofdm_sig.t = add_time_delay_signal(ofdm_sig.t, 5, 50);
    
    est_delay = sync_by_cp(ofdm_sig.t, ofdm_symbol_params);
    for s=1:num_symb
        ber = 0;
        symb = ofdm_sig;
        symb.t = ofdm_sig.t(:, s);
        symb.f = ofdm_sig.f(:, s);
        symb.pilot_f = ofdm_sig.pilot_f(:, s);
        symb.bits = ofdm_sig.bits((s-1)*4 + 1:(s-1)*4 + 4,:);
        dem = demodulate_ofdm_symbol(symb, ofdm_symbol_params);
        ber = ber + count_errors(symb.bits, dem.bits);
    end
    bers = [bers; ber/num_symb];
end

plot(i, bers)

ofdm_signal_params.N = 50;
ofdm_signal_params.min_delay = 5;
ofdm_signal_params.max_delay = 50;
ofdm_signal_params.channel = 50;
ofdm_signal_params.SNR = 50;
ofdm_signal_params.sync_by = 50;
ofdm_signal_params.nSync = 40;
