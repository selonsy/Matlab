clear;
clc;
% -----�������Һ����ͼ�������ĺ���----%
N = 10;
NN = 500;
x = linspace(0, 1, N); % ����ָ��,����0��1֮���N����ʸ��
x_fit = linspace(0,1,NN);
% sn �������Һ����� xn����sn�����õ��ĺ���,�����������ϸ�˹�ֲ�
sn = sin(2*pi*x);
% sn_fit���ڻ����⻬sn����
sn_fit = sin(2*pi*x_fit);
xn = sn + 0.25*normrnd(0,1,[1,N]); % normrnd��ʾ����1*N��,����Ϊ0,��׼��Ϊ1����̬�ֲ���.
plot(x_fit,sn_fit, 'g', x, xn, 'bo', 'LineWidth',2);
legend('s(n)', 'x(n)'); % ��ʶͼ��
figure;
plot(x,sn,'r'); % δ������������
% set(get(gca,'title'),'fontname','����')
% title('ģ��������Һ����Լ�����������ĺ���')  % ���ı��������


% -----���治ͬ��������ʽ���-----%
i=1;
figure;
for M=[0 1 3 9]
    % w����M�׶���ʽ��ϵ��
    w = polyfit(x, xn, M); % ����wΪ�ݴδӸߵ��͵Ķ���ʽϵ������w
    y = polyval(w, x_fit); % ���ض�Ӧ�Ա���x_fits�ڸ���ϵ��w�Ķ���ʽ��ֵ
        
    subplot(2,2,i); % ����2*2��С�ĺϲ���ͼ
    i=i+1;
    plot(x_fit, sn_fit, 'g', x, xn, 'bo', x_fit, y, 'r', 'LineWidth',2);
    str = ['M=' mat2str(M)]; % ��ʶM�Ľ���,mat2str������ת��Ϊ�ַ���
    text(0.6, 0.8, str); % ��ͼ��ָ��λ����ʾ�ַ���str
    legend('s(n)', 'x(n)', 'y'); % ��ʶͼ��
end

% -----����9�׶���ʽ��ϲ�ͬ���ݼ�-----%
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

%% �ҵĴ����


% -----�������L2���򻯺�ͬlambdaֵ9�׶���ʽ���-----%
figure;
N = 10;
lambda = 0.0001;
M = 9;
i=1;
x = linspace(0, 1, N);
X = x(ones(10,1),:); % ��x����ʮ��
b = linspace(0,9,N);
B = b(ones(10,1),:);
X = X'.^B;

sn = sin(2*pi*x);
xn = sn + 0.25*normrnd(0,1,[1,N]);
global w1 w2  %����ȫ�ֱ���

for lambda=[exp(-18) exp(0)]
    % ������С���˷��Ƶ������wֵ
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

% T ������ʾ��ͬlambdaʱ����ʽϵ��
T = table(w1, w2, 'VariableNames', {'lambdae18', 'lambdae0'});
