
function S2 = NewAnswer(S1)

%% ���룬��ʾ�Ŷ�����
% S1:    ��ǰ��
%% ���
% S2��   �½�
n = length(S1);
S2 = S1;
a = round(rand(1, 2) * (n - 1) + 1);    %�����������λ�ã����ڽ���
W = S2(a(1));
S2(a(1)) = S1(a(2));
S2(a(2)) = W;