clear;
clc;
% -----仿真正弦函数和加噪声后的函数----%
N = 10;
NN = 500;
x = linspace(0, 1, N); % 均分指令,产生0到1之间的N个行矢量
x_fit = linspace(0,1,NN);
% sn 代表正弦函数， xn代表sn加噪后得到的函数,所加噪声符合高斯分布
sn = sin(2*pi*x);
% sn_fit用于画出光滑sn曲线
sn_fit = sin(2*pi*x_fit);
xn = sn + 0.25*normrnd(0,1,[1,N]); % normrnd表示生成1*N的,期望为0,标准差为1的正态分布量.
plot(x_fit,sn_fit, 'g', x, xn, 'bo', 'LineWidth',2);
legend('s(n)', 'x(n)'); % 标识图例
figure;
plot(x,sn,'r'); % 未加噪的拟合曲线
% set(get(gca,'title'),'fontname','宋体')
% title('模拟仿真正弦函数以及增加噪声后的函数')  % 中文标题会乱码


% -----仿真不同阶数多项式拟合-----%
i=1;
figure;
for M=[0 1 3 9]
    % w代表M阶多项式的系数
    w = polyfit(x, xn, M); % 返回w为幂次从高到低的多项式系数向量w
    y = polyval(w, x_fit); % 返回对应自变量x_fits在给定系数w的多项式的值
        
    subplot(2,2,i); % 生成2*2大小的合并子图
    i=i+1;
    plot(x_fit, sn_fit, 'g', x, xn, 'bo', x_fit, y, 'r', 'LineWidth',2);
    str = ['M=' mat2str(M)]; % 标识M的阶数,mat2str将矩阵转化为字符串
    text(0.6, 0.8, str); % 在图中指定位置显示字符串str
    legend('s(n)', 'x(n)', 'y'); % 标识图例
end

% -----仿真9阶多项式拟合不同数据集-----%
figure;
i = 1;
for N=[15, 100]
    x = linspace(0, 1, N);
    sn = sin(2*pi*x);
    xn = sn + 0.25*normrnd(0,1,[1,N]);
    w = polyfit(x, xn, 9);
    y = polyval(w, x_fit);
    
    subplot(1,2,i);
    i = i+1;
    plot(x_fit, sn_fit,'g', x, xn, 'bo', x_fit, y, 'r', 'LineWidth',2);
    str = ['N=' mat2str(N)];
    text(0.6, 0.8, str);
    legend('s(n)', 'x(n)', 'y');
end

%% 我的代码节


% -----仿真添加L2正则化后不同lambda值9阶多项式拟合-----%
figure;
N = 10;
lambda = 0.0001;
M = 9;
i=1;
x = linspace(0, 1, N);
X = x(ones(10,1),:); % 将x复制十行
b = linspace(0,9,N);
B = b(ones(10,1),:);
X = X'.^B;

sn = sin(2*pi*x);
xn = sn + 0.25*normrnd(0,1,[1,N]);
global w1 w2  %声明全局变量

for lambda=[exp(-18) exp(0)]
    % 根据最小二乘法推导出最佳w值
    w = (X'*X + lambda.*eye(M+1,M+1))\(xn*X)';
    y = polyval(flipud(w), x_fit);
    
    if i == 1
        w1 = w;
    else 
        w2 = w;
    end
    subplot(1,2,i);
    i = i+1;
    plot(x_fit, sn_fit,'g', x, xn, 'bo', x_fit, y, 'r', 'LineWidth',2);
    str = ['ln(lambda)=' mat2str(log(lambda))];
    text(0.6, 0.8, str);
    legend('s(n)', 'x(n)', 'y');
end

% T 用于显示不同lambda时多项式系数
T = table(w1, w2, 'VariableNames', {'lambdae18', 'lambdae0'});
