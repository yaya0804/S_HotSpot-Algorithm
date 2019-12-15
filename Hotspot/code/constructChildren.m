function [ curr_children ] = constructChildren( data,targetValue,splitValues,tests,...
    minSupportCount,minImprovement,maxBranches,labelStateIndex )
%% �������ӽڵ�
% ���ֵ��
% children�� ���ӽڵ�
% queue ��ʼ��
% ���������
% data��656*7
% targetValue��0.2668
% splitValues��tests ����1*7������
% minSupportCount����С֧�ֶ���
% minImprovement����С�Ľ���
% maxBranches������֧��
% labelStateIndex��3

queue =[];%��ʼ������
[~,cols] = size(data);%���data������cols=7
%% ɸѡ�����ܵ������У�������Ŀ�������� �����뵽queue��
for i=1:cols-1  % ���һ�в�����ɸѡ
    % evaluateAttr���۵�i�����Ե�ĳ��ֵ�Ƿ���Ǳ��������У�����ֵ��queue
    queue=evaluateAttr(queue,data,i,targetValue,minSupportCount,minImprovement,labelStateIndex);
end

if isempty(queue)%isempty(x) xΪ�շ���1��x�ǿշ���0
    curr_children=[];
    return;
end
%% ���children ������Ӧ�û��ȫ����������maxBranches
cols = size(queue,2);
queue = queue_sort(queue,cols,'descend');%��������

%% ���children�е�ÿ��child����ȫ�ֹ���
children = [];
splitValues_list =[];
tests_list =[];
cols=size(queue,2);

for i=1:cols
    child = queue(1,i);
    newSplitValues = splitValues;
    newTests = tests;
    newSplitValues(1,child.attrIndex)=child.stateIndex+1;%����ѷָ���һ��attrIndex��ʾ�������������2����ʾ����ָ�����ڵڶ���
    if child.lessThan ==1 % '<=' 
        newTests(1,child.attrIndex) =1; 
    else  % '>'
        newTests(1,child.attrIndex) =3;
    end
    if ~m_rules_containkey(newSplitValues,newTests) % 0��ʾ���ڣ���Ҫ����
       % �ж��Ƿ�children��size�ѵ�maxBranches
       children_size = size(children,2);
       if children_size==maxBranches%���Ĵ�С�����������֧������ѭ��
           break; % �˳�forѭ��
       end
       node = struct('splitAttributeIndex',child.attrIndex,'stateIndex',child.stateIndex,...
         'stateCount',child.stateCount,'allCount',child.allCount,'support',child.support,...
         'lessThan',child.lessThan,'children',[]);
        children=[children,node];
        splitValues_list =[splitValues_list;newSplitValues];
        tests_list =[tests_list;newTests];
    else % ���ܵĹ��򣬲����Ѿ�����
%         disp('');
    end
end

%% ���ÿ�����ӽڵ㣬�����������ĺ��ӽڵ�
% children_size ֻ��С�ڻ����maxBranches
children_size = size(children,2);
curr_children=children;
for i=1:children_size
   child = children(1,i);
   
%    disp_children(children,i,splitValues_list(i,:));
   
   subData = getSubData(data,child);
   child.children=constructChildren(subData,child.support,splitValues_list(i,:),tests_list(i,:),minSupportCount,...
       minImprovement,maxBranches,labelStateIndex);
   curr_children(1,i)= child;  % д��
%    curr_child_i=curr_child_i+1;
end


end

function subData = getSubData(data,child)
%% ��ȡ�Ӽ�
    if child.lessThan % ��lessThan=1ִ�����в�������ʾbestMerit=target/leftCount
        subData = data(data(:,child.splitAttributeIndex)<=child.stateIndex,:);%child.splitAttributeIndex��ʾȡ�ڶ��е��Ӽ�����ֵС����ѷָ��
    else%��lessThan=0ʱ��ȡ������ѷָ���Ǹ�ֵ��ߵ�����
        subData = data(data(:,child.splitAttributeIndex)>child.stateIndex,:);%child.splitAttributeIndexȡ���ָ�����ڵ���
    end
end


% function disp_children(children,i,splitValues)
% %% ��������
% global unique_labels_  attributes_;
% disp('��ʼ--------------***********');
% cols =size(children,2);
% for j=1:cols
%    child = children(1,j);
%    if j==i
%        disp([node_2_string(child,unique_labels_,attributes_) '(��ǰ�ڵ�)']);
%        disp(splitValues);
%    else
%     disp(node_2_string(child,unique_labels_,attributes_));   
%    end
%     
% end
%    
%    disp('***************---------����');
% end