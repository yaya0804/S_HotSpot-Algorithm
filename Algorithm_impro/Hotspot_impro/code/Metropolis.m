
function [S,E] = Metropolis(minSupport, new_minSupport, T, unique_labels, data)

%% ����

% minSupport��  ��ǰ��
% new_minSupport:   �½�
% D:    ��������������е�֮��ľ��룩
% T:    ��ǰ�¶�
%% ���
% S��   ��һ����ǰ�⣨��С֧�ֶȣ�
% E��   ��һ����ǰ�������ֵ

E1=cal_Energy(minSupport, unique_labels, data); %������������E1  
E2=cal_Energy(new_minSupport, unique_labels, data); %������������E2  

dC = E2 - E1;                   % ��������֮��
if dC < 0                       % ����������� ������·��
    S = new_minSupport;                     % �����½�
    E = E2;
elseif exp(-dC/T) >= rand       % ��exp(-dC/T)���ʽ�����֧�ֶȣ�rand��������0-1֮��������
    S = new_minSupport;
    E  = E2;
else                            % �������µ�֧�ֶ�
    S = minSupport;
    E  = E1;
end
end