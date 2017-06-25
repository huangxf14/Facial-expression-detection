function f=chi_square_dis(Hn,H0)
    f=sum(((H0-Hn).^2)./(H0+Hn+1));
end
