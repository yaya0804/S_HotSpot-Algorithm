
function p = OutputPath(Route)

%% �����һ�����·���ĺ���

% ����: ·��(R)
%��Rĩ�������㼴R(1)
Route = [Route, Route(1)];
n = length(Route);
p = num2str(Route(1));
for i = 2: n
    p = [p, ' ��> ', num2str(Route(i))];
end
disp(p)