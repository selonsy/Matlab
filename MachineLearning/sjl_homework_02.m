clear;
clf;
clc;
% 返回一个在区间 (0,1) 内均匀分布的随机数的1000*2的矩阵
P = rand(2000, 2) * 100;
plot(P(:,1), P(:,2), '.')
hold on;
% 质心的坐标为所有点的算术平均位置
sum_x_y = sum(P,1);
avg_x = sum_x_y(1)/2000;
avg_y = sum_x_y(2)/2000;
plot(fix(avg_x),fix(avg_y),'ro');

% 另一种求质心的算法

X = P(:,1);
Y = P(:,2);
sum_A=0;
sum_cx = 0;sum_cy=0;
X(2001) = X(1);
Y(2001) = Y(1);
for i=1:2000
    sum_A = sum_A + (X(i)*Y(i+1)-X(i+1)*Y(i));
    sum_cx = sum_cx + ((X(i)+X(i+1))*(X(i)*Y(i+1))-X(i+1)*Y(i));
    sum_cy = sum_cy + ((Y(i)+Y(i+1))*(X(i)*Y(i+1))-X(i+1)*Y(i));
end
area_A = sum_A / 2;
cx = sum_cx / (6*sum_A);
cy = sum_cy / (6*sum_A);
hold on;
plot(fix(cx),fix(cy),'go');

