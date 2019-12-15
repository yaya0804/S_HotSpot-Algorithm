function [unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt)
%% ����Ԥ���� ����ȡ��Ҫ��������
% ��Ҫ�����Ŀ�����Դ�����б��룬��ʽ���£�
%Ŀ���б���Ϊ��
% I1 --> 1
% I2 --> 2
% I3 --> 3
% I4 --> 4
% I5 --> 5 �������֮��Ҫ����������к�Ŀ������������һ�𣬹���ԭʼ�����ݼ�data

[num,txt] = xlsread(inputfile);

attributes = txt(1,[attrsIndex_txt,labelIndex]);%Ҫ�����ļ��е�����ֵ

labels=txt(2:end,labelIndex);%ȡ��Ŀ��ֵ��ӵ�е����ԣ�labelIndexԭ�ȾͶ�����ˣ������ǵ����б�ʾȱ�ݷ������Ŀ������
unique_labels= unique(labels);%��Ŀ��ֵ����������ȥ�أ�����ȱ�ݷ���ֻ��5�����
labels=transform(labels,unique_labels);%transform�Ǹ���������ȥ��֮���Ŀ��ֵ���б��룬���磺5��ʾ��
data =[num(:,attrsIndex),labels];%����һ���Ű�Ҫ��������ݺ�Ŀ������������һ��

disp('����Ԥ������ɣ�');
disp('Ŀ���б���Ϊ��');
rows = size(unique_labels,1);
for i=1:rows
   disp([unique_labels{i,1} ' --> ' num2str(i)]); 
end 

end

% transform������Ŀ�����Խ���ת��
function labels=transform(labels,unique_labels_)%labels��ʾԭʼĿ��ֵ��ӵ�е�ȫ������ֵ��unique_labels_��ʾȥ��֮�������ֵ
    global unique_labels;%����ȫ������
    unique_labels= unique_labels_;
    labels = cellfun(@find_label_index,labels);
%     disp('a');
    
end

function labelindex = find_label_index(label)%���label��labelsȷ�����ӵ�һ����ʼ���Դ�����
    global unique_labels;
    [rows]= size(unique_labels,1);
    for i=1:rows
       if strcmp(unique_labels{i,1},label)%�ַ����Ƚ�
           labelindex =i;
           return;
       end
    end
    disp('�������');
end