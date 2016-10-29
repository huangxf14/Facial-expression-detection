function [ x ] = encode_conv( input_list, coef, tail ,tail_num)
% conv code encoder
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
        x(ii,:) = bitget(filter(coef(ii,:), 1, input_list), 1);
    end
    x = reshape(x, 1, []);
end
