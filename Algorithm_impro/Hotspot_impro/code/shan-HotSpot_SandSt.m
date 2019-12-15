%% hotspot算法测试脚本,以鸟害为例
% 通过计算最大置信度来寻找最佳分割点 
%% 进行异常值处理:jieguo_end.mat-jieguo_end.xlsx
% 没有进行异常值处理:jieguo_end2.mat-jieguo_end2.xlsx
% clear;
% clc;
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
%% 
tic;
inputfile ='D:\R2016a\workpace\experiment\Hotspot\code\data\testHotSpot2.xlsx';
hotspottreefile = '../tmp/hstree.mat';
labelIndex = 5; % 给定目标列是离散型数据，也就是目标属性所在的列，需要自己去定位
%TXT 小型蒸发量2、平均地表温度3、20-20累计降水量4、平均本站气压5、平均相对湿度6、日照时数7、平均气温8、平均风速9（自变量8列）
%num          1            2             3                 4              5         6         7         8
% attrsIndex_txt=[3,4];%分别表示平均地表温度和平均本站气压这两列
% attrsIndex=[2,3]; % 给定属性列都是连续型数据,就是想通过HotSpot算法分析目标属性：沙尘暴等级与某几列属性的关联关系
attrsIndex=[3,5]; 
attrsIndex_txt=[8,10];
minSupport =0.3; %最小支持度是0.04，这里怎么选择最小支持度是一个问题
minImprovement=0.01;%最小改进度为0.01
maxBranches =2; % 最大分支数
labelStateIndex =5; % 给定目标列的目标状态下标，5表示I5
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
disp(['总数：',num2str(numInstances),' 样本数']);
disp('目标属性：沙尘暴等级');
     disp(['目标值：',unique_labels{labelStateIndex,1},' [个数:', num2str(targetValue*numInstances) ,' 样本数 (',num2str(targetValue*100),'%)]']);
    disp(['用于分段的最小个数：',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% 占总数)']);
print_hsnode(root,level,unique_labels,attributes);
toc;
%minSupportCount=floor(minsupport*样本数+0.5)；%floor表示地板函数