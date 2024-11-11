function ber = count_signal_ber(input_bits, output_bits)
    ber = sum(abs(output_bits - input_bits), "all")/numel(input_bits);
end

