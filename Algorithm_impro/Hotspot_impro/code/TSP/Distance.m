
function D = Distance(citys)

%% ������������֮��ľ���

% ����:�����е�λ������(citys)

% ���:��������֮��ľ���(D)
n = size(citys, 1);
D = zeros(n, n);
for i = 1: n%i,j��ʾ������һ��14��
    for j = i + 1: n
        D(i, j) = sqrt((citys(i, 1) - citys(j, 1))^2 + (citys(i, 2) - citys(j, 2))^2);
        D(j, i) = D(i, j);
    end
end