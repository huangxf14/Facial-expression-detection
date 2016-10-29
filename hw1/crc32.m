function output_data = crc32(bitdata)

poly = uint32(hex2dec('EDB88320'));
data = zeros(1,length(bitdata)/8);
for i =1:1:length(data)
    for j=1:1:8
        data(i)=(data(i)+bitdata(i*8-7))*2;
    end
end
data = uint8(data);
output_data=[];
% Compute CRC-32 value
for x=1:length(data)/25
crc  = uint32(hex2dec('FFFFFFFF'));
for i = 1:25
    crc = bitxor(crc,uint32(data((x-1)*25+i)));
    for j = 1:8
        mask = bitcmp(bitand(crc,uint32(1)));
        if mask == intmax('uint32'), mask = 0; else mask = mask+1; end
        crc = bitxor(bitshift(crc,-1),bitand(poly,mask));
    end
end
output_data=[output_data bitdata((x-1)*200+1:x*200) u32tobit(bitcmp(crc))];
end;
output_data=logical(output_data);




function outputbit = u32tobit ( crc )
outputbit=zeros(1,32);
for i=1:1:32
    outputbit(i)=bitget(crc,33-i);
end;