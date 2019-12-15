
function D = Distance(citys)

%% 计算两两城市之间的距离

% 输入:各城市的位置坐标(citys)

% 输出:两两城市之间的距离(D)
n = size(citys, 1);
D = zeros(n, n);
for i = 1: n%i,j表示行数，一共14行
    for j = i + 1: n
        D(i, j) = sqrt((citys(i, 1) - citys(j, 1))^2 + (citys(i, 2) - citys(j, 2))^2);
        D(j, i) = D(i, j);
    end
end