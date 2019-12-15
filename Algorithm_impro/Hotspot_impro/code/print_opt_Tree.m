function print_opt_Tree(minSupport, unique_labels, data,attributes)
hotspottreefile = '../tmp/hstree.mat';
minImprovement=0.01;%最小改进度为0.01
maxBranches =2; % 最大分支数
labelStateIndex =4; % 给定目标列的目标状态下标，5表示I5
level =0; % 打印root节点设置为0

%% hotspot算法调用，对关联规则算法HotSpot算法的调用
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
    
%% 英文版本

% disp(['Total：',num2str(numInstances),' instances']);
% disp('Target attribute: sandstorm grade');
%      disp(['Target value：',unique_labels{labelStateIndex,1},' [Number:', num2str(targetValue*numInstances) ,' instances (',num2str(targetValue*100),'%)]']);
%     disp(['minS：',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% of total)']);

print_hsnode(root,level,unique_labels,attributes);
