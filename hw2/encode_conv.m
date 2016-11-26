<<<<<<< HEAD
function [ x ] = encode_conv( input_list, coef, tail )
% conv code encoder
    tail_num=100;
    [m, n] = size(coef);
    if tail==true
     temp_list=[];
     for time=1:tail_num:length(input_list)
            temp_list=[temp_list input_list(time:min(length(input_list),time+tail_num-1)) zeros(1,tail*(n-1))];
     end;
     input_list=temp_list;
    end;
    %input_list = [input_list, zeros(1,tail*(n-1))];
    x = zeros(m, size(input_list, 2));
    for ii = 1:m
=======
function [ x ] = encode_conv( input_list, coef, tail, block_size )
% conv code encoder
    if nargin < 4
        block_size = size(input_list, 2);
    end
    [m, n] = size(coef);
    if tail  % 加收尾
        input_list = reshape(input_list, block_size, []);
        input_list = reshape([input_list; zeros(n-1, size(input_list, 2))], 1, []);
    end
    x = zeros(m, size(input_list, 2));
    for ii = 1:m
        % 利用filter完成卷积
>>>>>>> db461acb2df24eb52f5d91daa2d66c1ed20e622f
        x(ii,:) = bitget(filter(coef(ii,:), 1, input_list), 1);
    end
    x = reshape(x, 1, []);
end
