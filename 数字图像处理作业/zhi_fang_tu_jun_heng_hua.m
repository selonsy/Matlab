
close all;
clear all;
clc;
%����histeq��������ֱ��ͼ���⻯����
I=imread('2.jpg');
J=histeq(I);  %ֱ��ͼ���⻯
figure,
subplot(121),imshow(uint8(I));
title('ԭͼ')
subplot(122),imshow(uint8(J));
title('���⻯��')
figure,
subplot(121),imhist(I,64);
title('ԭͼ��ֱ��ͼ');
subplot(122),imhist(J,64);
title('���⻯���ֱ��ͼ');
