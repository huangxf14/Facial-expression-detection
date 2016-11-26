# hw1

# hw2

channel_encode.m 信道编码

channel_decode.m 信道译码

encode_conv.m 卷积编码

decode_conv.m 卷积译码

encrypt_encode.m AMA编码

encrypt_decode.m AMA译码

encrypt_encode_rsa RSA编码

encrypt_decode_rsa.m RSA译码

exgcd.m 扩展gcd求解二元不定方程

fconv.m 重新实现了conv函数，$O(n^2) \to O(n\log n)$性能提升

findA.m 获取AMA的密钥矩阵A

howework2.m GUI(AMA)

howework2_rsa.m GUI(RSA)

hw1_1.m 无信道编码时各波形（发、收端波形，发、收端功率谱密度）绘制

hw1_2.m 有信道编码（1/2卷积+QPSK）时各波形绘制

* 上面这两个文件忘记改了，需要画一份semilogy，画之前要低通，明天早上起来写……

hw1_3.m BER曲线绘制，为了提高效率省去了载波调制/解调代码

hw2_2.m 用于获取联调误码图案

inv256.m 矩阵在模256意义下求逆

make_prime.m 获取大质数

mod_power.m 在取模意义下的快速幂

new_gcd.m sym下的gcd

rsa_pre.m 获取rsa密钥

test.m AMA性能测试
