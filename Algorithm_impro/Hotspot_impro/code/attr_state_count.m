function [ attrCount ] = attr_state_count( labels,unique_labels )
%% 针对单个label的不同state进行计数，这里就是计算以下5种目标值在总样本里有多少个
% 保护区安全隐患 --> 1
% 接地装置受损 --> 2
% 部件发热异常 --> 3
% 锈蚀、损伤 --> 4
% 鸟害 --> 5
rows = size(unique_labels,1);
attrCount = zeros(rows,1);
for i=1:rows
    attrCount(i,1)=sum(labels==i);
end


end

