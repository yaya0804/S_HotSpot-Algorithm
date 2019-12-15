% 通过计算最大置信度来寻找最佳分割点 
%% 进行异常值处理:jieguo_end.mat-jieguo_end.xlsx
% 没有进行异常值处理:jieguo_end2.mat-jieguo_end2.xlsx
function Energy=cal_Energy(minSupport, unique_labels, data)
minImprovement=0.01;%最小改进度为0.01
maxBranches =2; % 最大分支数
labelStateIndex =3; % 给定目标列的目标状态下标，4表示I4
%要改目标属性labelStateIndex，除了改cal_Energy，还要改print_opt_Tree函数里边的变量
%定义全局变量
global count1;
count1=0;
global count2;%===========新加的======================
count2=0;%================================
global support_value;
support_value=zeros(200,1);

%% hotspot算法调用，对关联规则算法HotSpot算法的调用
% disp('HotSpot关联规则树构建中...');
[root,numInstances,minSupportCount,targetValue] = hotspot(data,unique_labels,minSupport,minImprovement,maxBranches,labelStateIndex);
% save(hotspottreefile,'root');-----------
% disp(['HotSpot关联规则树已经保存在文件"' hotspottreefile '"中!']);
%% 打印hotspot关联规则树
% disp('HotSpot 关联规则树构建完成，下面是打印的树：');
% disp(['总数：',num2str(numInstances),' 样本数']);
% disp('目标属性：沙尘暴等级');
%      disp(['目标值：',unique_labels{labelStateIndex,1},' [个数:', num2str(targetValue*numInstances) ,' 样本数 (',num2str(targetValue*100),'%)]']);
%     disp(['用于分段的最小个数：',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% 占总数)']);
% print_hsnode(root,level,unique_labels,attributes);
if count1~=0 %count1=0表示没有挖掘到关联区间
          Energy1=(1-sum(support_value)/count1)^2+(1-count2/(count1*numInstances))^2;
%          Energy1=0.65*(1-sum(support_value)/count1)^2+0.35*(1-count2/(count1*numInstances))^2;
      Energy=sqrt(Energy1);
  else
       Energy=1;
end