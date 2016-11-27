%% Constellation

test_num = 4000;
x = randi([0 1], 1, test_num);
scatterplot(x);
title('Constellation before AWGN');
axis([-2 2 -2 2]);
x_enc = complex(x);
x_recv = awgn(x_enc.* exp(2i * pi * rand(1,test_num)), 8, 'measured');
scatterplot(x_recv);
title('Constellation after AWGN');
axis([-2 2 -2 2]);
