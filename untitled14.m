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

ofdm_signal_params.N = 50;
ofdm_signal_params.min_delay = 5;
ofdm_signal_params.max_delay = 25;
ofdm_signal_params.channel = "EPA";
ofdm_signal_params.SNR = 10;
ofdm_signal_params.sync_by = "cp";
ofdm_signal_params.nSync = 5;
ofdm_signal_params.symbol_params = ofdm_symbol_params;

arr = 5:5:25;
SNR_vals = 0:10:30;

bers = [];
for n = arr
    ofdm_signal_params.nSync = n;
    ber = get_ber_by_params_signal(ofdm_signal_params, SNR_vals);
    bers = [bers, ber];
end

plot_multiple_lines(SNR_vals, bers, "ds", arr);
