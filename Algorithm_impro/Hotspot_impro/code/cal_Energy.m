% ͨ������������Ŷ���Ѱ����ѷָ�� 
%% �����쳣ֵ����:jieguo_end.mat-jieguo_end.xlsx
% û�н����쳣ֵ����:jieguo_end2.mat-jieguo_end2.xlsx
function Energy=cal_Energy(minSupport, unique_labels, data)
minImprovement=0.01;%��С�Ľ���Ϊ0.01
maxBranches =2; % ����֧��
labelStateIndex =3; % ����Ŀ���е�Ŀ��״̬�±꣬4��ʾI4
%Ҫ��Ŀ������labelStateIndex�����˸�cal_Energy����Ҫ��print_opt_Tree������ߵı���
%����ȫ�ֱ���
global count1;
count1=0;
global count2;%===========�¼ӵ�======================
count2=0;%================================
global support_value;
support_value=zeros(200,1);

%% hotspot�㷨���ã��Թ��������㷨HotSpot�㷨�ĵ���
% disp('HotSpot����������������...');
[root,numInstances,minSupportCount,targetValue] = hotspot(data,unique_labels,minSupport,minImprovement,maxBranches,labelStateIndex);
% save(hotspottreefile,'root');-----------
% disp(['HotSpot�����������Ѿ��������ļ�"' hotspottreefile '"��!']);
%% ��ӡhotspot����������
% disp('HotSpot ����������������ɣ������Ǵ�ӡ������');
% disp(['������',num2str(numInstances),' ������']);
% disp('Ŀ�����ԣ�ɳ�����ȼ�');
%      disp(['Ŀ��ֵ��',unique_labels{labelStateIndex,1},' [����:', num2str(targetValue*numInstances) ,' ������ (',num2str(targetValue*100),'%)]']);
%     disp(['���ڷֶε���С������',num2str(minSupportCount),' instances( ',num2str(minSupport*100),'% ռ����)']);
% print_hsnode(root,level,unique_labels,attributes);
if count1~=0 %count1=0��ʾû���ھ򵽹�������
          Energy1=(1-sum(support_value)/count1)^2+(1-count2/(count1*numInstances))^2;
%          Energy1=0.65*(1-sum(support_value)/count1)^2+0.35*(1-count2/(count1*numInstances))^2;
      Energy=sqrt(Energy1);
  else
       Energy=1;
end