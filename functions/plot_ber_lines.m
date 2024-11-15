function plot_ber_lines(X_values, Y_matrix, title_s, lines, title_x)
%     This function plots multiple lines where each column in Y_matrix 
%     represents one line corresponding to SNR_values on the x-axis.
    
%     Check if the number of rows in Y_matrix matches the length of SNR_values
    if size(Y_matrix, 1) ~= length(X_values)
        error('The number of rows in Y_matrix must match the length of SNR_values.');
    end

%     Number of lines to plot (number of columns in Y_matrix)
    num_lines = size(Y_matrix, 2);

%     Start the plot
    figure;
    hold on; % Hold the plot to overlay multiple lines

%     Loop to plot each column as a separate line
    for i = 1:num_lines
%         Extract the i-th column as Y values for this line
        Y_values = Y_matrix(:, i);
        
%         Plot each line
        plot(X_values, Y_values, '-o', 'DisplayName', [num2str(lines(i))]);
    end

%     Add labels and title
    xlabel(title_x);
    ylabel('BER');
    title(title_s);

%     Add a legend
    legend show;

%     Show the grid
    grid on;

%     Release the hold on plot
    hold off;
end
