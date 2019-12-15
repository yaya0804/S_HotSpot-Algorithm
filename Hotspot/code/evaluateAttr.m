function queue=evaluateAttr(queue,data,attrIndex,targetValue,minSupportCount,minImprovement,labelStateIndex)
%% 评价第i列属性的某个值是否有潜力加入队列

% 判断是否有足够的数据
numInstances = size(data,1);%numInstances为样本数
if numInstances<=minSupportCount%如果所有样本数都小于最小支持度数程序结束
    return;
end

% 根据第i列进行数据排序
%attrIndex是constructChildren21行中的i，此时i从1到6，表示除了目标属性列其他的列序号
[~,b_index] = sort(data(:,attrIndex));%sort按照某列从小到大排序，b_index返回的是排序后的数据对应于在原序列中的下标
% A= 5*1        A排序后为   A_index为
% 7    5(2)        2           5
% 8    1(7)        7           1
% 9    2(8)        8           2
% 10   3(9)        9           3
% 2    4(10)       10          4
data = data(b_index,:); % 对第i列从小到大排序后的数据重新赋值给data，注意其他列还是乱序的

targetLeft =0;
%targetLeft 表示按顺序从小到大遍历点左边符合目标值I3的事务个数，初始值为0，自加
targetRight = sum(data(:,end)==labelStateIndex);
%表示从小到大遍历点右边符合目标值的事务个数，初始值为全部目标值数目 自减
%targetLeft+targetRight=card(Y)

% 初始化参数
bestMerit = 0.0;
bestSplit = 0.0;
bestSupport = 0.0;
bestSubsetSize = 0;
%  lessThan = true;
lessThan =1;

% denominators 分母
leftCount = 0;
%表示遍历点左边事务总个数 初始值为0  自加
rightCount = numInstances;
%表示遍历点右边事务个数 初始值为样本数  自减
%leftCount+rightCount=card(X)

%% for 遍历
for i=1:numInstances %i就是遍历点
    inst = data(i,:);%取出每一行的数据来
    if inst(1,end) == labelStateIndex %end终止代码块或指示最大数组索引，如果这行数据属于目标值沙尘暴等级的话就执行以下操作
        targetLeft=targetLeft+1;
        targetRight=targetRight-1;
    end
    leftCount=leftCount+1;
    rightCount=rightCount-1;
    
    % move to the end of any ties 
    if i < numInstances
        
        data_ii = data(i+1,:);%当i=1时data_ii存放着data中第二行的数据
        %如果排序后第attrIndex列属性上下相邻的样本值相等就结束本次for循环
        if data_ii(1,attrIndex)==inst(1,attrIndex)
            continue;
        end
    end
    
    % evaluate split 评估分割点
    
    if targetLeft >= minSupportCount%若目标值出现的个数大于等于最小支持度
        delta = (targetLeft / leftCount) - bestMerit;%保证置信度是增加的
        
        if delta > 0%置信度增加的前提下计算新的置信度
            bestMerit = targetLeft / leftCount;%计算满足最小支持数条件下的当前置信度,bestMerit应该是计算MaxC   
            %bestSplit = inst[attrIndex];
            bestSplit = inst(1,attrIndex);
            bestSupport = targetLeft;
            bestSubsetSize = leftCount;
            % lessThan = true;
            lessThan =1;
            
            fid=fopen('寻找最优分割点.txt','r+');
            fprintf(fid,' targetLeft >= minSupportCount & delta > 0 情况下：\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
            fclose(fid);
            
        else if delta == 0
                % break ties in favour of higher support
                if targetLeft > bestSupport
                    bestMerit = targetLeft / leftCount;
                    % bestSplit = inst[attrIndex];
                    bestSplit = inst(1,attrIndex);
                    bestSupport = targetLeft;
                    bestSubsetSize = leftCount;
                    % lessThan = true;
                    lessThan =1;
                    
                    fid=fopen('寻找最优分割点.txt','r+');
                    fprintf(fid,' targetLeft >= minSupportCount & delta=0 情况下：\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
                    fclose(fid);
                    
                end
            end
        end
        
    end
    
    if targetRight >= minSupportCount
        delta =(targetRight / rightCount) - bestMerit;
        
        if delta > 0
            bestMerit = targetRight / rightCount;%表示最大置信度
            % bestSplit = inst[attrIndex];
            bestSplit =inst(1,attrIndex);
            bestSupport = targetRight;
            bestSubsetSize = rightCount;
            % lessThan = false;
            lessThan =0;
            
            fid=fopen('寻找最优分割点.txt','r+');
            fprintf(fid,' targetRight >= minSupportCount & delta>0 情况下：\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
            fclose(fid);
            
        else if delta == 0
                
                if targetRight > bestSupport
                    bestMerit = targetRight / rightCount;
                    % 						bestSplit = inst[attrIndex];
                    bestSplit = inst(1,attrIndex);%最佳分割点
                    bestSupport = targetRight;
                    bestSubsetSize = rightCount;
                    % 						lessThan = false;
                    lessThan =0;
                    
                    fid=fopen('寻找最优分割点.txt','r+');
                    fprintf(fid,' targetLeft >= minSupportCount & delta=0 情况下：\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
                    fclose(fid);
                    
                end
            end
        end
        
    end
end % 此处结束for循环
    delta =  bestMerit- targetValue;
    
    % Have we found a candidate split?    bestSupport > 0是否可以删除
    if bestSupport > 0 && delta / targetValue >= minImprovement  %右边这个式子表示最小改进度
        
        %             AttrStateSup ass = new AttrStateSup(attrIndex,(float)bestSplit,
        %             (int)bestSubsetSize,(int)bestSupport,lessThan);
        % 构造结构体，插入queue
        queue_node =struct('attrIndex',attrIndex,'stateIndex',bestSplit,...
            'stateCount', bestSupport,'allCount',bestSubsetSize,'support',...
            bestSupport/bestSubsetSize,'lessThan',lessThan);
        %             pq.add(ass);
        queue= queue_push(queue,queue_node);%存储每一列选出来的最佳分割点及其比例
        
        
    end
end

