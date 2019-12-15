function queue=evaluateAttr(queue,data,attrIndex,targetValue,minSupportCount,minImprovement,labelStateIndex)
%% 评价第i列属性的某个值是否有潜力加入队列

% 判断是否有足够的数据
numInstances = size(data,1);
if numInstances<=minSupportCount
    return;
end

% 根据第i列进行数据排序
[~,b_index] = sort(data(:,attrIndex));
data = data(b_index,:); % 排序后的数据

targetLeft =0;
targetRight = sum(data(:,end)==labelStateIndex);%表示目标值的个数

% 初始化参数
bestMerit = 0.0;
bestSplit = 0.0;
bestSupport = 0.0;
bestSubsetSize = 0;
%  lessThan = true;
lessThan =1;
% denominators
leftCount = 0;
rightCount = numInstances;


%% for 遍历
for i=1:numInstances
    
    inst = data(i,:);%取出每一行的数据来
    if inst(1,end) == labelStateIndex %如果这行数据属于目标值沙尘暴等级的话就执行以下操作
        targetLeft=targetLeft+1;
        targetRight=targetRight-1;
    end
    leftCount=leftCount+1;
    rightCount=rightCount-1;
    
    % move to the end of any ties
    if i < numInstances
        %取出下一行要循环的数据，如果两个属性值相等，就结束本次循环，因为如果是最佳分割点，需要累计一次leftcount，因为属性值相等，避免再循环一次
        data_ii = data(i+1,:);
        if data_ii(1,attrIndex)==inst(1,attrIndex)%%如果上下最高湿度相等就结束本次循环
            continue;
        end
    end
    
    % evaluate split
    
    if targetLeft >= minSupportCount
        delta = (targetLeft / leftCount) - bestMerit;%---------保证置信度是增加的
        
        if delta > 0
            bestMerit = targetLeft / leftCount;
            % 					bestSplit = inst[attrIndex];
            bestSplit = inst(1,attrIndex);
            bestSupport = targetLeft;
            bestSubsetSize = leftCount;
            % 					lessThan = true;
            lessThan =1;
        else if delta == 0
                % break ties in favour of higher support
                if targetLeft > bestSupport%遍历点左边的符合目标数据项的事务个数和原先的个数相比
                    bestMerit = targetLeft / leftCount;
                    % 						bestSplit = inst[attrIndex];
                    bestSplit = inst(1,attrIndex);
                    bestSupport = targetLeft;
                    bestSubsetSize = leftCount;
                    % 						lessThan = true;
                    lessThan =1;
                end
            end
        end
        
    end
    
    if targetRight >= minSupportCount
        delta =(targetRight / rightCount) - bestMerit;
        
        if delta > 0
            bestMerit = targetRight / rightCount;%表示最大置信度
            % 					bestSplit = inst[attrIndex];
            bestSplit =inst(1,attrIndex);
            bestSupport = targetRight;
            bestSubsetSize = rightCount;
            % 					lessThan = false;
            lessThan =0;
            
        else if delta == 0
                
                if targetRight > bestSupport
                    bestMerit = targetRight / rightCount;
                    % 						bestSplit = inst[attrIndex];
                    bestSplit = inst(1,attrIndex);%最佳分割点
                    bestSupport = targetRight;
                    bestSubsetSize = rightCount;
                    % 						lessThan = false;
                    lessThan =0;
                end
            end
        end
        
    end
end % for 
    delta =  bestMerit- targetValue;%这一列的最大置信度-支持度，用于计算最小改进度
    
    % Have we found a candidate split?
    if bestSupport > 0 && delta / targetValue >= minImprovement  %右边这个式子表示最小改进度
        
        %             AttrStateSup ass = new AttrStateSup(attrIndex,(float)bestSplit,
        %             (int)bestSubsetSize,(int)bestSupport,lessThan);
        % 构造结构体queue_node，用来存放当前最佳分割点插入queue
        queue_node =struct('attrIndex',attrIndex,'stateIndex',bestSplit,...
            'stateCount', bestSupport,'allCount',bestSubsetSize,'support',...
            bestSupport/bestSubsetSize,'lessThan',lessThan);
        %             pq.add(ass);
        queue= queue_push(queue,queue_node);%存储每一列选出来的最佳分割点（就是所有的最佳分割点）及其比例
        
        
    end
end

