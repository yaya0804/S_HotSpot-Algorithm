function [unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt)
%% 数据预处理 ，抽取需要的数据列
% 将要处理的目标属性处理进行编码，形式如下：
%目标列编码为：
% I1 --> 1
% I2 --> 2
% I3 --> 3
% I4 --> 4
% I5 --> 5 编码完成之后将要处理的属性列和目标属性整合在一起，构成原始的数据集data

[num,txt] = xlsread(inputfile);

attributes = txt(1,[attrsIndex_txt,labelIndex]);%要处理哪几列的属性值

labels=txt(2:end,labelIndex);%取出目标值所拥有的属性，labelIndex原先就定义好了，这里是第三列表示缺陷分类这个目标属性
unique_labels= unique(labels);%将目标值的所有属性去重，这里缺陷分类只有5种情况
labels=transform(labels,unique_labels);%transform是个函数，对去重之后的目标值进行编码，比如：5表示鸟害
data =[num(:,attrsIndex),labels];%到这一步才把要处理的数据和目标属性整合在一起

disp('数据预处理完成！');
disp('目标列编码为：');
rows = size(unique_labels,1);
for i=1:rows
   disp([unique_labels{i,1} ' --> ' num2str(i)]); 
end 

end

% transform函数将目标属性进行转换
function labels=transform(labels,unique_labels_)%labels表示原始目标值所拥有的全部属性值，unique_labels_表示去重之后的属性值
    global unique_labels;%定义全部变量
    unique_labels= unique_labels_;
    labels = cellfun(@find_label_index,labels);
%     disp('a');
    
end

function labelindex = find_label_index(label)%这个label由labels确定，从第一个开始，以此类推
    global unique_labels;
    [rows]= size(unique_labels,1);
    for i=1:rows
       if strcmp(unique_labels{i,1},label)%字符串比较
           labelindex =i;
           return;
       end
    end
    disp('编码错误！');
end