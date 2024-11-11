function [synced_signal, estimate_delay] = sync_by_training_symbol(rxSignal, training_symbol)
    % SYNC_BY_TRAINING_SYMBOL Synchronize rxSignal using a training symbol.
    %
    % Inputs:
    %   rxSignal        - Received signal to be synchronized
    %   training_symbol - Known training symbol used for synchronization
    %
    % Outputs:
    %   synced_signal   - Synchronized received signal
    %   estimate_delay  - Estimated delay of the training symbol in the received signal

    % Calculate cross-correlation between received signal and training symbol
    [corr_metric, lags] = xcorr(rxSignal, training_symbol);
    
    % Find the index of the maximum correlation metric for delay estimation
    [~, ind] = max(corr_metric(length(corr_metric)/2 + 1:end));
    
    % Calculate the estimated delay
    estimate_delay = ind;

    % Adjust the received signal based on the estimated delay
    synced_signal = rxSignal(length(training_symbol) + ind + 1:end);
end
