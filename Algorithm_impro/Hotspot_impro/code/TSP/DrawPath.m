
function DrawPath(Route, citys)

%% 画路径函数,将路径用图的形式表示出来

% 输入

% Route  待画路径   

% citys  各城市坐标位置

%画出初始路线
figure%将citys(Route, 1)：citys中的第一列按route排列，中间加分号是多写
plot([citys(Route, 1); citys(Route(1), 1)], [citys(Route, 2); citys(Route(1), 2)], 'o-');
grid on
%给每个地点标上序号

for i = 1: size(citys, 1)
    text(citys(i, 1), citys(i, 2), ['   ' num2str(i)]);
end

text(citys(Route(1), 1), citys(Route(1), 2), '       起点');
text(citys(Route(end), 1), citys(Route(end), 2), '       终点');