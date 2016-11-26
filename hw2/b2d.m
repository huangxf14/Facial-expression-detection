function [ out ] = b2d( in )
%B2D Summary of this function goes here
%   Detailed explanation goes here
out = reshape(in,[],8);
%out = out*[128,64,32,16,8,4,2,1]';
out = out*[1,2,4,8,16,32,64,128]';
out = uint8(out);
end

