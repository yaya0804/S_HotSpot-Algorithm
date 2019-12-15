
function  new_minSupport = NewAnswer(Time,count)

%% 输入，表示扰动函数
% minSupport:    当前支持度
%% 输出
%  new_minSupport：   新的最小支持度
%  s=0.005;
%  new_minSupport=rand(1,1)*(minSupport-s)+(1-rand(1,1))*(minSupport+s);
step=(1-0.001)/Time;
new_minSupport=0.001+count*step;
