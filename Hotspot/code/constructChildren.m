function [ curr_children ] = constructChildren( data,targetValue,splitValues,tests,...
    minSupportCount,minImprovement,maxBranches,labelStateIndex )
%% 创建孩子节点
% 输出值：
% children： 孩子节点
% queue 初始化
% 输入参数：
% data：656*7
% targetValue：0.2668
% splitValues和tests 都是1*7的数组
% minSupportCount：最小支持度数
% minImprovement：最小改进度
% maxBranches：最大分支数
% labelStateIndex：3

queue =[];%初始化队列
[~,cols] = size(data);%求出data的列数cols=7
%% 筛选出可能的属性列（不包括目标属性列 ）加入到queue中
for i=1:cols-1  % 最后一列不加入筛选
    % evaluateAttr评价第i列属性的某个值是否有潜力加入队列，返回值是queue
    queue=evaluateAttr(queue,data,i,targetValue,minSupportCount,minImprovement,labelStateIndex);
end

if isempty(queue)%isempty(x) x为空返回1，x非空返回0
    curr_children=[];
    return;
end
%% 获得children ，这里应该获得全部，而不是maxBranches
cols = size(queue,2);
queue = queue_sort(queue,cols,'descend');%降序排列

%% 针对children中的每个child构造全局规则
children = [];
splitValues_list =[];
tests_list =[];
cols=size(queue,2);

for i=1:cols
    child = queue(1,i);
    newSplitValues = splitValues;
    newTests = tests;
    newSplitValues(1,child.attrIndex)=child.stateIndex+1;%将最佳分割点加一，attrIndex表示列数，这里等于2，表示这个分割点属于第二列
    if child.lessThan ==1 % '<=' 
        newTests(1,child.attrIndex) =1; 
    else  % '>'
        newTests(1,child.attrIndex) =3;
    end
    if ~m_rules_containkey(newSplitValues,newTests) % 0表示不在，需要添加
       % 判断是否children的size已到maxBranches
       children_size = size(children,2);
       if children_size==maxBranches%树的大小如果等于最大分支数跳出循环
           break; % 退出for循环
       end
       node = struct('splitAttributeIndex',child.attrIndex,'stateIndex',child.stateIndex,...
         'stateCount',child.stateCount,'allCount',child.allCount,'support',child.support,...
         'lessThan',child.lessThan,'children',[]);
        children=[children,node];
        splitValues_list =[splitValues_list;newSplitValues];
        tests_list =[tests_list;newTests];
    else % 可能的规则，不过已经添加
%         disp('');
    end
end

%% 针对每个孩子节点，构造其自身的孩子节点
% children_size 只会小于或等于maxBranches
children_size = size(children,2);
curr_children=children;
for i=1:children_size
   child = children(1,i);
   
%    disp_children(children,i,splitValues_list(i,:));
   
   subData = getSubData(data,child);
   child.children=constructChildren(subData,child.support,splitValues_list(i,:),tests_list(i,:),minSupportCount,...
       minImprovement,maxBranches,labelStateIndex);
   curr_children(1,i)= child;  % 写回
%    curr_child_i=curr_child_i+1;
end


end

function subData = getSubData(data,child)
%% 获取子集
    if child.lessThan % 当lessThan=1执行下列操作，表示bestMerit=target/leftCount
        subData = data(data(:,child.splitAttributeIndex)<=child.stateIndex,:);%child.splitAttributeIndex表示取第二列的子集，其值小于最佳分割点
    else%当lessThan=0时，取大于最佳分割点那个值后边的数据
        subData = data(data(:,child.splitAttributeIndex)>child.stateIndex,:);%child.splitAttributeIndex取出分割点所在的列
    end
end


% function disp_children(children,i,splitValues)
% %% 仅作测试
% global unique_labels_  attributes_;
% disp('开始--------------***********');
% cols =size(children,2);
% for j=1:cols
%    child = children(1,j);
%    if j==i
%        disp([node_2_string(child,unique_labels_,attributes_) '(当前节点)']);
%        disp(splitValues);
%    else
%     disp(node_2_string(child,unique_labels_,attributes_));   
%    end
%     
% end
%    
%    disp('***************---------结束');
% end