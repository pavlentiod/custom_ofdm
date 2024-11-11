function symb = ofdm_time_shift(symb, t)
   sig_len = length(symb.t);
   tau = floor(sig_len*t);
   symb.t = circshift(symb.t, tau); 
end

