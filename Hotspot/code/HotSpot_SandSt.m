%% hotspot算法测试脚本,以鸟害为例
% 通过计算最大置信度来寻找最佳分割点 
%% 
% 没有进行异常值处理:jieguo_end2.mat-jieguo_end2.xlsx
clear;
clc;
%% jieguo_end是jieguo_handle文件夹处理出来的数据，进行了异常值处理，jieguo_end2是jieguo_handle2文件夹处理出来的数据，没有进行异常值处理，（因为发生沙尘暴的数据都是异常天气）
% load('jieguo_end2.mat');
% load('Degree_label.mat');
% % 将.mat文件转化为.xlsx文件，并将每一列的列名加入.xlsx文件
% xlswrite('jieguo_end2.xlsx',label,'sheet1','A2');
% xlswrite('jieguo_end2.xlsx',num(:,2:end),'sheet1','B2');%这里可以不要success，只是为了直观的显示是否写入成功
% attribute_field={'沙尘暴等级','小型蒸发量','平均地表温度','20-20累计降水量', ...
%     '平均本站气压','平均相对湿度','日照时数','平均气温','平均风速'};%这里注意外边是大括号
% xlswrite('jieguo_end2.xlsx',attribute_field,'sheet1','A1');
%%inputfile = '../code/jieguo_end.xlsx'; %hotspotdata.xls----------
%% {'月份','小型蒸发量','20-20时累计降水量','平均相对湿度','日照时数','平均气温','平均风速'}
tic;
% inputfile ='D:\R2016a\workpace\experiment\Hotspot\code\data\hotspotdata.xls';
% hotspottreefile = '../tmp/hstree.mat';
% labelIndex = 3;
% attrsIndex_txt=[8,10];%
% attrsIndex=[3,5]; % 
% minSupport =0.2;
% minImprovement=0.01;
% maxBranches =2; % 最大分支数
% labelStateIndex =5; % 给定目标列的目标状态下标，4表示I4
% level =0; % 打印root节点设置为0
%% 
inputfile ='..\code\data\winequality-white.xlsx';
hotspottreefile = '../tmp/hstree.mat';
labelIndex = 1; % 给定目标列是离散型数据，也就是目标属性所在的列，需要自己去定位
%TXT 月份2、小型蒸发量3、20-20累计降水量4、平均相对湿度5、日照时数6、平均气温7、平均风速8（自变量8列）
%num  1           2            3                4          5         6         7         
% attrsIndex_txt=[2,3,4,5,6,7,8];%分别表示平均地表温度和20-20累计降水量这两列
% attrsIndex=[1,2,3,4,5,6,7]; % 给定属性列都是连续型数据,就是想通过HotSpot算法分析目标属性：沙尘暴等级与某几列属性的关联关系
attrsIndex_txt=[2,3,4,5,6,7,8,9,10,11,12];%以季节性数据集为挖掘背景时
attrsIndex=[1,2,3,4,5,6,7,8,9,10,11]; % 

minSupport =0.3; %最小支持度是0.04，这里怎么选择最小支持度是一个问题

minImprovement=0.01;%最小改进度为0.01
maxBranches =2; % 最大分支数
labelStateIndex =4; % 给定目标列的目标状态下标，4表示I4
level =0; % 打印root节点设置为0

%% 数据预处理---将原始目标属性列转化为对应的编码
[unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt);


%% hotspot算法调用，下边的代码是对关联规则算法HotSpot算法的调用
% disp('HotSpot关联规则树构建中...');
[root,numInstances,minSupportCount,targetValue] = hotspot(data,unique_labels,minSupport,minImprovement,maxBranches,labelStateIndex);
save(hotspottreefile,'root');
disp(['HotSpot关联规则树已经保存在文件"' hotspottreefile '"中!']);
%% 打印hotspot关联规则树
disp('HotSpot 关联规则树构建完成，下面是打印的树：');

% disp(['总数：',num2str(numInstances),' 样本数']);
% disp('目标属性：沙尘暴等级');
%      disp(['目标值：',unique_labels{labelStateIndex,1},' [个数:', num2str(targetValue*numInstances) ,' 样本数 (',num2str(targetValue*100),'%)]']);
%     disp(['用于分段的最小个数：',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% 占总数)']);
% print_hsnode(root,level,unique_labels,attributes);

%%英文版本

disp(['Total：',num2str(numInstances),' instances']);
disp('Target attribute: sandstorm grade');
     disp(['Target value：',unique_labels{labelStateIndex,1},' [Number:', num2str(targetValue*numInstances) ,' instances (',num2str(targetValue*100),'%)]']);
    disp(['minS：',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% of total)']);
print_hsnode(root,level,unique_labels,attributes);

toc;
%minSupportCount=floor(minsupport*样本数+0.5)；%floor表示地板函数