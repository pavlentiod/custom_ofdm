function delayed_signal = add_time_delay(txSignal, delay)
    % ADD_TIME_DELAY Adds a time delay to the transmitted signal by 
    % prepending it with complex Gaussian noise.
    %
    % Inputs:
    %   txSignal - Transmitted signal (vector)
    %   delay    - Number of samples to delay (integer)
    %
    % Output:
    %   delayed_signal - Delayed received signal (vector)
    % Define N as the number of random vectors you want
    N = delay;  % Example: You can change this to any number you need
    
    % Initialize an empty array for storing complex numbers
    random_vectors = zeros(N, 1);
    
    % Generate N random complex vectors
    for i = 1:N
        % Generate random real and imaginary parts with values between -0.005 and 0.005
        real_part = -0.005 + (0.005 + 0.005) * rand;
        imag_part = -0.005 + (0.005 + 0.005) * rand;
        
        % Create the complex number
        random_vectors(i) = real_part + 1i * imag_part;
    end
    

    % Add the time delay to the transmitted signal
    delayed_signal = [random_vectors; txSignal];
end
