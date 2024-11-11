function delayed_signal = add_time_delay_signal(signal)
    % Adds a random time delay of complex numbers to each column of the input matrix.
    % Zero padding is added after the column data if necessary.
    % 
    % Args:
    %     matrix (complex matrix): Input 2D array (matrix) of complex numbers.
    %     min_delay (int): Minimum number of random complex values to add.
    %     max_delay (int): Maximum number of random complex values to add.
    % 
    % Returns:
    %     delayed_signal (complex matrix): New matrix with added time delays.

    % Determine the size of the input matrix

    add_to_end = 0;

    [num_rows, num_cols] = size(signal.t);
    
    % Initialize a new matrix to store the delayed signal
    delayed_signal = zeros(num_rows + signal.params.max_delay + add_to_end, num_cols);

    for col = 1:num_cols
        % Generate a random delay value between min_delay and max_delay
        N = randi([signal.params.min_delay, signal.params.max_delay]);

        % Generate N random complex values with real and imaginary parts in range [-0.005, 0.005]
        real_part = -0.005 + (0.01) * rand(N, 1);
        imag_part = -0.005 + (0.01) * rand(N, 1);
        random_values = complex(real_part, imag_part);

        % Concatenate the random complex values with the original column
        new_column = [random_values; signal.t(:, col)];

        % Calculate zero padding needed to reach max_delay
        zero_padding = zeros(signal.params.max_delay - N + add_to_end, 1);

        % Concatenate the column data with zero padding at the end
        new_column_with_padding = [new_column; zero_padding];

        % Store the new column in the delayed_signal matrix
        delayed_signal(:, col) = new_column_with_padding;
    end
end
