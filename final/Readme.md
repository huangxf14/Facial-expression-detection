# 代码说明

train.m 提取doc下所有文件夹内的图片，并对图片提取特征，将特征和label写入model.mat中
test.m 提取file下所有图片，对图片进行判断，并将结果写入txt文件中
WLD.m 对提供的图片区域提取WLD特征
chi_square_dis.m 计算直方图的卡方距离
classifyEpcl.m和classifyFai.m为求WLD特征的辅助函数