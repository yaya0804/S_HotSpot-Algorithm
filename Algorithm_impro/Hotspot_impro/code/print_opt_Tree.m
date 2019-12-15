function print_opt_Tree(minSupport, unique_labels, data,attributes)
hotspottreefile = '../tmp/hstree.mat';
minImprovement=0.01;%��С�Ľ���Ϊ0.01
maxBranches =2; % ����֧��
labelStateIndex =4; % ����Ŀ���е�Ŀ��״̬�±꣬5��ʾI5
level =0; % ��ӡroot�ڵ�����Ϊ0

%% hotspot�㷨���ã��Թ��������㷨HotSpot�㷨�ĵ���
% disp('HotSpot����������������...');
[root,numInstances,minSupportCount,targetValue] = hotspot(data,unique_labels,minSupport,minImprovement,maxBranches,labelStateIndex);
save(hotspottreefile,'root');
disp(['HotSpot�����������Ѿ��������ļ�"' hotspottreefile '"��!']);
%% ��ӡhotspot����������
disp('HotSpot ����������������ɣ������Ǵ�ӡ������');
disp(['������',num2str(numInstances),' ������']);
disp('Ŀ�����ԣ�ɳ�����ȼ�');
     disp(['Ŀ��ֵ��',unique_labels{labelStateIndex,1},' [����:', num2str(targetValue*numInstances) ,' ������ (',num2str(targetValue*100),'%)]']);
    disp(['���ڷֶε���С������',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% ռ����)']);
    
%% Ӣ�İ汾

% disp(['Total��',num2str(numInstances),' instances']);
% disp('Target attribute: sandstorm grade');
%      disp(['Target value��',unique_labels{labelStateIndex,1},' [Number:', num2str(targetValue*numInstances) ,' instances (',num2str(targetValue*100),'%)]']);
%     disp(['minS��',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% of total)']);

print_hsnode(root,level,unique_labels,attributes);
