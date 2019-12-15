
function Length = PathLength(D, Route)

%% 计算起点与终点之间的路径长度
% 输入：
% D     两两城市之间的距离

% Route 路线
Length = 0;
n = length(Route);
for i = 1: (n - 1)
    Length = Length + D(Route(i), Route(i + 1));
end
Length = Length + D(Route(n), Route(1));