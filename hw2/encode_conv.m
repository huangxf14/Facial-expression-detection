function [ x ] = encode_conv( input_list, coef, tail, block_size )
% conv code encoder
    if nargin < 4
        block_size = size(input_list, 2);
    end
    [m, n] = size(coef);
    if tail  
        input_list = reshape(input_list, block_size, []);
        input_list = reshape([input_list; zeros(n-1, size(input_list, 2))], 1, []);
    end
    x = zeros(m, size(input_list, 2));
    for ii = 1:m
        x(ii,:) = bitget(filter(coef(ii,:), 1, input_list), 1);
    end
    x = reshape(x, 1, []);
end
