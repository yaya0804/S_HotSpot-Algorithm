
function Length = PathLength(D, Route)

%% ����������յ�֮���·������
% ���룺
% D     ��������֮��ľ���

% Route ·��
Length = 0;
n = length(Route);
for i = 1: (n - 1)
    Length = Length + D(Route(i), Route(i + 1));
end
Length = Length + D(Route(n), Route(1));