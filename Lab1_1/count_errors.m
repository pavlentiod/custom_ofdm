function [errors_value] = count_errors(input_bits, output_bits)
    errors_value = sum(abs(output_bits' - input_bits), "all");
end

