function out = d2b( in )
%D2B Summary of this function goes here
%   Detailed explanation goes here
out  = zeros(length(in),8);
for i = 1:length(in)
    out(i,:) = bitget(in(i),1:8);
end
out = reshape(out,[],1);
end

