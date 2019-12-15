
function S2 = NewAnswer(S1)

%% 输入，表示扰动函数
% S1:    当前解
%% 输出
% S2：   新解
n = length(S1);
S2 = S1;
a = round(rand(1, 2) * (n - 1) + 1);    %产生两个随机位置，用于交换
W = S2(a(1));
S2(a(1)) = S1(a(2));
S2(a(2)) = W;