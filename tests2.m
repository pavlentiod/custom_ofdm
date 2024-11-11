clc;
clear;

ofdm_symbol_params.bps = 4;             
ofdm_symbol_params.pilot_bps = 2;        
ofdm_symbol_params.info_to_pilot = 16;  
ofdm_symbol_params.GI_to_Subc = 0.125;    
ofdm_symbol_params.cp_to_sig = 0.3;     
ofdm_symbol_params.nFFT = 2048;
ofdm_symbol_params.t_symb = 100e-6;
ofdm_symbol_params.fs = ofdm_symbol_params.nFFT/ofdm_symbol_params.t_symb;
ofdm_symbol_params.ts = 1 / ofdm_symbol_params.fs; 
ofdm_symbol_params.equalize = 1;
ofdm_symbol_params.null_cp = 0;
ofdm_symbol_params.max_dopp = 0;

ofdm_signal_params.N = 10;
ofdm_signal_params.min_delay = 5;
ofdm_signal_params.max_delay = 50;
ofdm_signal_params.channel = "EPA";
ofdm_signal_params.SNR = 10;
ofdm_signal_params.sync_by = "cp";
ofdm_signal_params.nSync = 5;
ofdm_signal_params.symbol_params = ofdm_symbol_params;


if ofdm_signal_params.nSync > ofdm_signal_params.N
    dips("nSync VALUE IS'N CORRECT")
end


SNR_vals = 0:5:40;
bers = [];

for snr=SNR_vals
    ofdm_signal_params.SNR = snr;
    sig = create_ofdm_signal(ofdm_signal_params);
    sig.params = ofdm_signal_params;
    
    
    if ofdm_signal_params.max_delay > 0
        sig.t = add_time_delay_signal(sig);
    end
    
%     % Apply AWGN
    sig.t = awgn(sig.t, ofdm_signal_params.SNR, 'measured');
%     
%     % Apply channel
%     for symb = 1:ofdm_signal_params.N
%         sig.t(:, symb) = fading_channel(sig.t(:, symb), ofdm_signal_params.symbol_params, ofdm_signal_params.channel);
%     end
    
    % Sync by CP
    if ofdm_signal_params.sync_by == "cp"
        sig = sync_by_cp(sig);
    end
    
    % Demodulate signal
    bits = demodulate_ofdm_signal(sig);
    
    bers = [bers; count_signal_ber(sig.bits, bits)];
end

plot_multiple_lines(SNR_vals, errs, "dkdk", [1 1])













