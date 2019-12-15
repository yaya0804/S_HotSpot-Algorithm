function queue=evaluateAttr(queue,data,attrIndex,targetValue,minSupportCount,minImprovement,labelStateIndex)
%% ���۵�i�����Ե�ĳ��ֵ�Ƿ���Ǳ���������

% �ж��Ƿ����㹻������
numInstances = size(data,1);
if numInstances<=minSupportCount
    return;
end

% ���ݵ�i�н�����������
[~,b_index] = sort(data(:,attrIndex));
data = data(b_index,:); % ����������

targetLeft =0;
targetRight = sum(data(:,end)==labelStateIndex);%��ʾĿ��ֵ�ĸ���

% ��ʼ������
bestMerit = 0.0;
bestSplit = 0.0;
bestSupport = 0.0;
bestSubsetSize = 0;
%  lessThan = true;
lessThan =1;
% denominators
leftCount = 0;
rightCount = numInstances;


%% for ����
for i=1:numInstances
    
    inst = data(i,:);%ȡ��ÿһ�е�������
    if inst(1,end) == labelStateIndex %���������������Ŀ��ֵɳ�����ȼ��Ļ���ִ�����²���
        targetLeft=targetLeft+1;
        targetRight=targetRight-1;
    end
    leftCount=leftCount+1;
    rightCount=rightCount-1;
    
    % move to the end of any ties
    if i < numInstances
        %ȡ����һ��Ҫѭ�������ݣ������������ֵ��ȣ��ͽ�������ѭ������Ϊ�������ѷָ�㣬��Ҫ�ۼ�һ��leftcount����Ϊ����ֵ��ȣ�������ѭ��һ��
        data_ii = data(i+1,:);
        if data_ii(1,attrIndex)==inst(1,attrIndex)%%����������ʪ����Ⱦͽ�������ѭ��
            continue;
        end
    end
    
    % evaluate split
    
    if targetLeft >= minSupportCount
        delta = (targetLeft / leftCount) - bestMerit;%---------��֤���Ŷ������ӵ�
        
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
                if targetLeft > bestSupport%��������ߵķ���Ŀ������������������ԭ�ȵĸ������
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
            bestMerit = targetRight / rightCount;%��ʾ������Ŷ�
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
                    bestSplit = inst(1,attrIndex);%��ѷָ��
                    bestSupport = targetRight;
                    bestSubsetSize = rightCount;
                    % 						lessThan = false;
                    lessThan =0;
                end
            end
        end
        
    end
end % for 
    delta =  bestMerit- targetValue;%��һ�е�������Ŷ�-֧�ֶȣ����ڼ�����С�Ľ���
    
    % Have we found a candidate split?
    if bestSupport > 0 && delta / targetValue >= minImprovement  %�ұ����ʽ�ӱ�ʾ��С�Ľ���
        
        %             AttrStateSup ass = new AttrStateSup(attrIndex,(float)bestSplit,
        %             (int)bestSubsetSize,(int)bestSupport,lessThan);
        % ����ṹ��queue_node��������ŵ�ǰ��ѷָ�����queue
        queue_node =struct('attrIndex',attrIndex,'stateIndex',bestSplit,...
            'stateCount', bestSupport,'allCount',bestSubsetSize,'support',...
            bestSupport/bestSubsetSize,'lessThan',lessThan);
        %             pq.add(ass);
        queue= queue_push(queue,queue_node);%�洢ÿһ��ѡ��������ѷָ�㣨�������е���ѷָ�㣩�������
        
        
    end
end

