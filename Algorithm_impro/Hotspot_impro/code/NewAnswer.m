
function  new_minSupport = NewAnswer(Time,count)

%% ���룬��ʾ�Ŷ�����
% minSupport:    ��ǰ֧�ֶ�
%% ���
%  new_minSupport��   �µ���С֧�ֶ�
%  s=0.005;
%  new_minSupport=rand(1,1)*(minSupport-s)+(1-rand(1,1))*(minSupport+s);
step=(1-0.001)/Time;
new_minSupport=0.001+count*step;
