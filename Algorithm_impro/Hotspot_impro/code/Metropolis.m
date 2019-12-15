
function [S,E] = Metropolis(minSupport, new_minSupport, T, unique_labels, data)

%% 输入

% minSupport：  当前解
% new_minSupport:   新解
% D:    距离矩阵（两两城市的之间的距离）
% T:    当前温度
%% 输出
% S：   下一个当前解（最小支持度）
% E：   下一个当前解的能量值

E1=cal_Energy(minSupport, unique_labels, data); %计算能量函数E1  
E2=cal_Energy(new_minSupport, unique_labels, data); %计算能量函数E2  

dC = E2 - E1;                   % 计算能力之差
if dC < 0                       % 如果能力降低 接受新路线
    S = new_minSupport;                     % 接受新解
    E = E2;
elseif exp(-dC/T) >= rand       % 以exp(-dC/T)概率接受新支持度，rand函数产生0-1之间的随机数
    S = new_minSupport;
    E  = E2;
else                            % 不接受新的支持度
    S = minSupport;
    E  = E1;
end
end