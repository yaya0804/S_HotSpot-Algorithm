function [ attrCount ] = attr_state_count( labels,unique_labels )
%% ��Ե���label�Ĳ�ͬstate���м�����������Ǽ�������5��Ŀ��ֵ�����������ж��ٸ�
% ��������ȫ���� --> 1
% �ӵ�װ������ --> 2
% ���������쳣 --> 3
% ��ʴ������ --> 4
% �� --> 5
rows = size(unique_labels,1);
attrCount = zeros(rows,1);
for i=1:rows
    attrCount(i,1)=sum(labels==i);
end


end

