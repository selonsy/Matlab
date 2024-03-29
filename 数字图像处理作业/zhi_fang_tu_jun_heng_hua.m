
close all;
clear all;
clc;
%函数histeq（）进行直方图均衡化处理
I=imread('2.jpg');
J=histeq(I);  %直方图均衡化
figure,
subplot(121),imshow(uint8(I));
title('原图')
subplot(122),imshow(uint8(J));
title('均衡化后')
figure,
subplot(121),imhist(I,64);
title('原图像直方图');
subplot(122),imhist(J,64);
title('均衡化后的直方图');
