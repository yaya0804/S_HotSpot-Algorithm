
function p = OutputPath(Route)

%% 输出第一条随机路径的函数

% 输入: 路径(R)
%给R末端添加起点即R(1)
Route = [Route, Route(1)];
n = length(Route);
p = num2str(Route(1));
for i = 2: n
    p = [p, ' —> ', num2str(Route(i))];
end
disp(p)