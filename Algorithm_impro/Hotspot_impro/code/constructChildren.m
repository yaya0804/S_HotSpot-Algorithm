function curr_children = constructChildren(data,targetValue,splitValues,tests,...
    minSupportCount,minImprovement,maxBranches,labelStateIndex )
%% �������ӽڵ�
% ����ֵ��
% children�� ���ӽڵ�
% queue ��ʼ��
queue =[];%����������ź��ӽڵ�
[~,cols] = size(data);

%% ɸѡ�����ܵ������м��뵽queue��
for i=1:cols-1  % ���һ�в�����ɸѡ
    queue=evaluateAttr(queue,data,i,targetValue,minSupportCount,minImprovement,labelStateIndex);
end
 global count1;
 global count2;%=================================
 global support_value;

 if ~isempty(queue)
   for jj=1:size(queue,2)
     support_value(count1+jj,1)=queue(jj).support;
     count2=count2+queue(jj).allCount;%=====================
   end
 else
    curr_children=[];
    return;
 end
count1=size(queue,2)+count1;%count1�����ۼ�ͳ��ÿһ�εĺ��ӽڵ㡣
%   index_noSupport=find(support_value==0);
%   support_value(find(support_value==0),:)=[];
%   count2=size(support_value,1); %count1+count2;count2������ֹ�洢�µ�֧�ֶȵ�ʱ��ԭ�ȵĸ�������ʹ��洢�ڿ���λ��
%   save support_count count1;
% if isempty(queue)
%     curr_children=[];
%     return;
% end
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
    newSplitValues(1,child.attrIndex)=child.stateIndex+1;%attrIndex��ʾ�������������2����ʾ����ָ�����ڵڶ���
    if child.lessThan ==1 % '<=' 
        newTests(1,child.attrIndex) =1; 
    else  % '>'
        newTests(1,child.attrIndex) =3;
    end
    if ~m_rules_containkey(newSplitValues,newTests) % 0��ʾ���ڣ���Ҫ���
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
    else % ���ܵĹ��򣬲����Ѿ����
%         disp('');
    end
end

%% ���ÿ�����ӽڵ㣬����������ĺ��ӽڵ�
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
    else%��lessThan=0ʱ��targetright����ѷָ�㣬ȡ������ѷָ���Ǹ�ֵ��ߵ�����
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