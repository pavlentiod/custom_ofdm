function rx_signal = add_frequency_offset_and_noise(tx_signal, freq_offset, num_subcarriers, noise_flag, noise_level)
    % Add frequency offset and optional noise to the signal.
    %
    % Parameters:
    %   tx_signal: complex vector, the transmitted signal.
    %   freq_offset: scalar, the frequency offset to apply.
    %   num_subcarriers: scalar, the number of subcarriers.
    %   noise_flag: boolean, if true, noise will be added to the signal.
    %   noise_level: scalar, the level of noise to add (if noise_flag is true).
    %
    % Returns:
    %   rx_signal: complex vector, the received signal with frequency offset and noise (if applicable).

    % Time vector for the length of the signal
    t = (0:length(tx_signal)-1).';

    % Apply frequency offset to the signal
    rx_signal = tx_signal .* exp(1i * 2 * pi * freq_offset * t / num_subcarriers);

    % Add noise if noise_flag is true
    if noise_flag
        noise = noise_level * (randn(length(tx_signal), 1) + 1i * randn(length(tx_signal), 1));
        rx_signal = rx_signal + noise;
    end
end
