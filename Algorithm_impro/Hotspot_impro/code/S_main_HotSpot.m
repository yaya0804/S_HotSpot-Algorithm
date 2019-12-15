%% 清空环境变量
clear;
clc;
tic;
%%
% inputfile ='D:\R2016a\workpace\experiment\Hotspot\code\data\hotspotdata.xls';
% % hotspottreefile = '../tmp/hstree.mat';
% labelIndex = 3;
% attrsIndex_txt=6;%[8,10];%
% attrsIndex=1;%[3,5]; % 
% % level =0; % 打印root节点设置为0
 %% 初始化参数
inputfile ='..\code\data\winequality-white.xlsx';
% hotspottreefile = '../tmp/hstree.mat';%
labelIndex = 1; % 给定目标列是离散型数据，也就是目标属性所在的列，需要自己去定位
%TXT 月份2、小型蒸发量3、20-20累计降水量4、平均相对湿度5、日照时数6、平均气温7、平均风速8（自变量8列）
%num  1           2            3                4          5         6         7       
attrsIndex_txt=[2,3,4,5,6,7,8,9,10,11,12];%分别表示平均地表温度和20-20累计降水量这两列
attrsIndex=[1,2,3,4,5,6,7,8,9,10,11]; % 给定属性列都是连续型数据,就是想通过HotSpot算法分析目标属性：沙尘暴等级与某几列属性的关联关系

% attrsIndex_txt=[2,3,4,5,6,7];%以季节性数据集为挖掘背景时
% attrsIndex=[1,2,3,4,5,6]; % 

%% 要改目标属性labelStateIndex，除了改cal_Energy，还要改print_opt_Tree函数里边的变量

% attrsIndex_txt=[3,4];%分别表示平均地表温度和平均本站气压这两列
% attrsIndex=[2,3]; % 给定属性列都是连续型数据,就是想通过HotSpot算法分析目标属性：沙尘暴等级与某几列属性的关联关系
%% 数据预处理---将原始目标属性列拥有的值转化为对应的编码
[unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt);

%%温度参数
T0 = 1e20;      % 初始温度10的20次方，自行设置
Tf = 1e-30;     % 终止温度10的-30次方，自行设置
% T0 = 1e10;    
% Tf = 1e-10;
%L = 2;       % 各温度下的迭代次数，也就是内循环，代表Lk,如果忽略就是非时齐算法 
q = 0.9;        % 降温速率，自行设置
Time = ceil(double(solve([num2str(T0) '*(0.9)^x = ', num2str(Tf)])));       % 计算迭代的次数 T0 * (0.9)^x = Tf
%solve函数主要是用来求解代数方程的解析解或者精确解
 count = 0;                                                                  % 初始化迭代此=次数
 rem_E_Support = zeros(Time, 2);  %第一列用来记录每次每次迭代过程的最小支持度，第二列用来记录支持度对应的能量函数值                                                     % 目标值矩阵初始化
%% V. %随机产生一个初始支持度
minSupport=0.001;%最小支持度在0-1内等可能的取到，表示0.1%
% minSupport=rand(1,1);%最小支持度在0-1内等可能的取到
 %% VI. 迭代优化
while T0 > Tf
     count = count + 1;  % 更新迭代次数
    % 1. 产生新解
     new_minSupport = NewAnswer(Time,count);%随机交换原始路径的两个位置
    % 2. Metropolis法则判断是否接受新解
    [minSupport,E] = Metropolis(minSupport, new_minSupport, T0, unique_labels, data);                                    % Metropolis 抽样算法
% 3.1记录每次迭代后的最优解，
    % 下边代码表示就算新的能量函数值之差dC = E2 -E1大于0，并且以一定概率被接受，此时，只接受支持度作为当前解，不接受该能量值，
    %因为该能量值还要与上一行的E进行比较，只有小于上一个最优解才被记录，否则仍记录上一个的最优解，所以rem_E_Support数组
    %不表示支持度与之对应的能量值，而是迭代到该支持度时的最优能量值。
%     if E==1 %E==1表示没有挖掘到关联区间
%         break;
%     else
%         if count == 1 || E < rem_E_Support(count-1,2)                                       % 如果当前温度下的距离小于上个温度的距离，记录当前距离
%             rem_E_Support(count,2) = E;                                                     
%         else
%             rem_E_Support(count,2) = rem_E_Support(count-1,2);                                          
%         end
%             rem_E_Support(count,1) = minSupport; 
%     end
% 3.2.记录每次迭代的解,rem_E_Support最终的结果后边的支持度和能量值都没有变，表示E2大于E1,并且exp(-dC/T)概率太低，不会被接受，使得一直跳不出当前最优解。
    if E==1 %E==1表示没有挖掘到关联区间
        break;
    else
      rem_E_Support(count,1) = minSupport;    
      rem_E_Support(count,2) = E;          
    end
% 5.以q的速率降温，温度更新函数--指数退温
    T0 = q * T0;        
end 
 rem_E_Support(rem_E_Support(:,1)==0,:) = [];
 min_E=min(rem_E_Support(:,2));
 opt_Support=rem_E_Support(rem_E_Support(:,2)==min_E,1);%因为第一列存放的是最小支持度
 disp(['最优支持度区间为：',num2str(min(opt_Support)*100), '% - ',num2str(max(opt_Support)*100),'% ']);
 opt_Support=opt_Support(1,1);
 disp('最优HotSpot关联规则树如下：');
 print_opt_Tree(opt_Support, unique_labels, data,attributes);
 toc;