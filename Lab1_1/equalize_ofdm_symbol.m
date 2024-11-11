function equalizedSymbol = equalize_ofdm_symbol(symbol_f, pilot_indexes, pilot_reference)
    
    receivedPilots = symbol_f(pilot_indexes);

    % Estimate the channel frequency response using the pilots
    H_est = interp1(pilot_indexes, receivedPilots ./ pilot_reference, 1:length(symbol_f), 'linear', 'extrap');
    
    % Equalize the received OFDM symbol
    equalizedSymbol = symbol_f ./ H_est.';
    
%     % Extract and return the equalized data subcarriers
%     equalizedData = equalizedSymbol(dataIndices);
end
