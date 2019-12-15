
%% I. 清空环境变量
clear;
clc;
 
%% II. 导入城市位置数据
X = [16.4700   96.1000 %第1 个位置
     16.4700   94.4400 %  2
     20.0900   92.5400
     22.3900   93.3700
     25.2300   97.2400
     22.0000   96.0500
     20.4700   97.0200
     17.2000   96.2900
     16.3000   97.3800
     14.0500   98.1200
     16.5300   97.3800
     21.5200   95.5900
     19.4100   97.1300
     20.0900   92.5500]; 

%% III. 计算距离矩阵
D = Distance(X);  %计算距离矩阵,对角线上为0
n = size(D,1);    %城市的个数
 
%% IV. 初始化参数
T0 = 1e10;      % 初始温度10的10次方，自行设置
Tf = 1e-30;     % 终止温度10的-30次方，自行设置
%L = 2;                                                                     % 各温度下的迭代次数
q = 0.9;        % 降温速率，自行设置
Time = ceil(double(solve([num2str(T0) '*(0.9)^x = ', num2str(Tf)])));       % 计算迭代的次数 T0 * (0.9)^x = Tf
%solve函数主要是用来求解代数方程的解析解或者精确解
count = 0;                                                                  % 初始化迭代计数
Obj = zeros(Time, 1);  %记录每次迭代过程的最优路线的距离                                                     % 目标值矩阵初始化
path = zeros(Time, n);                                                      % 每代的最优路线矩阵初始化
%% V. 随机产生一个初始路线
S1 = randperm(n);%将一列序号随机打乱，序号必须是整数
DrawPath(S1, X)                                                             % 画出初始路线
disp('初始种群中的一个随机值:')
OutputPath(S1);                                                             % 用箭头的形式表述初始路线
rlength = PathLength(D, S1);                                                % 计算初始路线的总长度
disp(['总距离：', num2str(rlength)]);
 
%% VI. 迭代优化
while T0 > Tf
    count = count + 1;                                                      % 更新迭代次数
    %temp = zeros(L,n+1);
    % 1. 产生新解
    S2 = NewAnswer(S1);%随机交换原始路径的两个位置
    % 2. Metropolis法则判断是否接受新解
    [S1, R] = Metropolis(S1, S2, D, T0);                                    % Metropolis 抽样算法
    % 3. 记录每次迭代过程的最优路线
    if count == 1 || R < Obj(count-1)                                       % 如果当前温度下的距离小于上个温度的距离，记录当前距离
        Obj(count) = R;                                                     
    else
        Obj(count) = Obj(count-1);                                          
    end
    path(count,:) = S1;                                                     % 记录每次迭代的路线
    T0 = q * T0;         % 以q的速率降温
end 

%% VII. 优化过程迭代图
figure
plot(1: count, Obj)%最优距离的选择过程
xlabel('迭代次数')
ylabel('距离')
title('优化过程')
grid on
 
%% VIII. 绘制最优路径图

DrawPath(path(end, :), X)                                                   % path矩阵的最后一行一定是最优路线 

%% IX. 输出最优解的路线和总距离
disp('最优解:')
S = path(end, :);
p = OutputPath(S);
disp(['总距离：', num2str(PathLength(D, S))]);