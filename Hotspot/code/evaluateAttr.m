function queue=evaluateAttr(queue,data,attrIndex,targetValue,minSupportCount,minImprovement,labelStateIndex)
%% ���۵�i�����Ե�ĳ��ֵ�Ƿ���Ǳ���������

% �ж��Ƿ����㹻������
numInstances = size(data,1);%numInstancesΪ������
if numInstances<=minSupportCount%���������������С����С֧�ֶ����������
    return;
end

% ���ݵ�i�н�����������
%attrIndex��constructChildren21���е�i����ʱi��1��6����ʾ����Ŀ�������������������
[~,b_index] = sort(data(:,attrIndex));%sort����ĳ�д�С��������b_index���ص������������ݶ�Ӧ����ԭ�����е��±�
% A= 5*1        A�����Ϊ   A_indexΪ
% 7    5(2)        2           5
% 8    1(7)        7           1
% 9    2(8)        8           2
% 10   3(9)        9           3
% 2    4(10)       10          4
data = data(b_index,:); % �Ե�i�д�С�����������������¸�ֵ��data��ע�������л��������

targetLeft =0;
%targetLeft ��ʾ��˳���С�����������߷���Ŀ��ֵI3�������������ʼֵΪ0���Լ�
targetRight = sum(data(:,end)==labelStateIndex);
%��ʾ��С����������ұ߷���Ŀ��ֵ�������������ʼֵΪȫ��Ŀ��ֵ��Ŀ �Լ�
%targetLeft+targetRight=card(Y)

% ��ʼ������
bestMerit = 0.0;
bestSplit = 0.0;
bestSupport = 0.0;
bestSubsetSize = 0;
%  lessThan = true;
lessThan =1;

% denominators ��ĸ
leftCount = 0;
%��ʾ��������������ܸ��� ��ʼֵΪ0  �Լ�
rightCount = numInstances;
%��ʾ�������ұ�������� ��ʼֵΪ������  �Լ�
%leftCount+rightCount=card(X)

%% for ����
for i=1:numInstances %i���Ǳ�����
    inst = data(i,:);%ȡ��ÿһ�е�������
    if inst(1,end) == labelStateIndex %end��ֹ������ָʾ����������������������������Ŀ��ֵɳ�����ȼ��Ļ���ִ�����²���
        targetLeft=targetLeft+1;
        targetRight=targetRight-1;
    end
    leftCount=leftCount+1;
    rightCount=rightCount-1;
    
    % move to the end of any ties 
    if i < numInstances
        
        data_ii = data(i+1,:);%��i=1ʱdata_ii�����data�еڶ��е�����
        %���������attrIndex�������������ڵ�����ֵ��Ⱦͽ�������forѭ��
        if data_ii(1,attrIndex)==inst(1,attrIndex)
            continue;
        end
    end
    
    % evaluate split �����ָ��
    
    if targetLeft >= minSupportCount%��Ŀ��ֵ���ֵĸ������ڵ�����С֧�ֶ�
        delta = (targetLeft / leftCount) - bestMerit;%��֤���Ŷ������ӵ�
        
        if delta > 0%���Ŷ����ӵ�ǰ���¼����µ����Ŷ�
            bestMerit = targetLeft / leftCount;%����������С֧���������µĵ�ǰ���Ŷ�,bestMeritӦ���Ǽ���MaxC   
            %bestSplit = inst[attrIndex];
            bestSplit = inst(1,attrIndex);
            bestSupport = targetLeft;
            bestSubsetSize = leftCount;
            % lessThan = true;
            lessThan =1;
            
            fid=fopen('Ѱ�����ŷָ��.txt','r+');
            fprintf(fid,' targetLeft >= minSupportCount & delta > 0 ����£�\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
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
                    
                    fid=fopen('Ѱ�����ŷָ��.txt','r+');
                    fprintf(fid,' targetLeft >= minSupportCount & delta=0 ����£�\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
                    fclose(fid);
                    
                end
            end
        end
        
    end
    
    if targetRight >= minSupportCount
        delta =(targetRight / rightCount) - bestMerit;
        
        if delta > 0
            bestMerit = targetRight / rightCount;%��ʾ������Ŷ�
            % bestSplit = inst[attrIndex];
            bestSplit =inst(1,attrIndex);
            bestSupport = targetRight;
            bestSubsetSize = rightCount;
            % lessThan = false;
            lessThan =0;
            
            fid=fopen('Ѱ�����ŷָ��.txt','r+');
            fprintf(fid,' targetRight >= minSupportCount & delta>0 ����£�\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
            fclose(fid);
            
        else if delta == 0
                
                if targetRight > bestSupport
                    bestMerit = targetRight / rightCount;
                    % 						bestSplit = inst[attrIndex];
                    bestSplit = inst(1,attrIndex);%��ѷָ��
                    bestSupport = targetRight;
                    bestSubsetSize = rightCount;
                    % 						lessThan = false;
                    lessThan =0;
                    
                    fid=fopen('Ѱ�����ŷָ��.txt','r+');
                    fprintf(fid,' targetLeft >= minSupportCount & delta=0 ����£�\n%d\t%f\t%f\t%f\t%f\t%f\n',attrIndex,bestMerit,bestSplit,bestSupport,bestSubsetSize,lessThan);
                    fclose(fid);
                    
                end
            end
        end
        
    end
end % �˴�����forѭ��
    delta =  bestMerit- targetValue;
    
    % Have we found a candidate split?    bestSupport > 0�Ƿ����ɾ��
    if bestSupport > 0 && delta / targetValue >= minImprovement  %�ұ����ʽ�ӱ�ʾ��С�Ľ���
        
        %             AttrStateSup ass = new AttrStateSup(attrIndex,(float)bestSplit,
        %             (int)bestSubsetSize,(int)bestSupport,lessThan);
        % ����ṹ�壬����queue
        queue_node =struct('attrIndex',attrIndex,'stateIndex',bestSplit,...
            'stateCount', bestSupport,'allCount',bestSubsetSize,'support',...
            bestSupport/bestSubsetSize,'lessThan',lessThan);
        %             pq.add(ass);
        queue= queue_push(queue,queue_node);%�洢ÿһ��ѡ��������ѷָ�㼰�����
        
        
    end
end

