%% hotspot�㷨���Խű�,����Ϊ��
% ͨ������������Ŷ���Ѱ����ѷָ�� 
%% �����쳣ֵ����:jieguo_end.mat-jieguo_end.xlsx
% û�н����쳣ֵ����:jieguo_end2.mat-jieguo_end2.xlsx
% clear;
% clc;
%% jieguo_end��jieguo_handle�ļ��д�����������ݣ��������쳣ֵ����jieguo_end2��jieguo_handle2�ļ��д�����������ݣ�û�н����쳣ֵ��������Ϊ����ɳ���������ݶ����쳣������
% load('jieguo_end2.mat');
% load('Degree_label.mat');
% % ��.mat�ļ�ת��Ϊ.xlsx�ļ�������ÿһ�е���������.xlsx�ļ�
% xlswrite('jieguo_end2.xlsx',label,'sheet1','A2');
% xlswrite('jieguo_end2.xlsx',num(:,2:end),'sheet1','B2');%������Բ�Ҫsuccess��ֻ��Ϊ��ֱ�۵���ʾ�Ƿ�д��ɹ�
% attribute_field={'ɳ�����ȼ�','С��������','ƽ���ر��¶�','20-20�ۼƽ�ˮ��', ...
%     'ƽ����վ��ѹ','ƽ�����ʪ��','����ʱ��','ƽ������','ƽ������'};%����ע������Ǵ�����
% xlswrite('jieguo_end2.xlsx',attribute_field,'sheet1','A1');
%%inputfile = '../code/jieguo_end.xlsx'; %hotspotdata.xls----------
%% 
tic;
inputfile ='D:\R2016a\workpace\experiment\Hotspot\code\data\testHotSpot2.xlsx';
hotspottreefile = '../tmp/hstree.mat';
labelIndex = 5; % ����Ŀ��������ɢ�����ݣ�Ҳ����Ŀ���������ڵ��У���Ҫ�Լ�ȥ��λ
%TXT С��������2��ƽ���ر��¶�3��20-20�ۼƽ�ˮ��4��ƽ����վ��ѹ5��ƽ�����ʪ��6������ʱ��7��ƽ������8��ƽ������9���Ա���8�У�
%num          1            2             3                 4              5         6         7         8
% attrsIndex_txt=[3,4];%�ֱ��ʾƽ���ر��¶Ⱥ�ƽ����վ��ѹ������
% attrsIndex=[2,3]; % ���������ж�������������,������ͨ��HotSpot�㷨����Ŀ�����ԣ�ɳ�����ȼ���ĳ�������ԵĹ�����ϵ
attrsIndex=[3,5]; 
attrsIndex_txt=[8,10];
minSupport =0.3; %��С֧�ֶ���0.04��������ôѡ����С֧�ֶ���һ������
minImprovement=0.01;%��С�Ľ���Ϊ0.01
maxBranches =2; % ����֧��
labelStateIndex =5; % ����Ŀ���е�Ŀ��״̬�±꣬5��ʾI5
level =0; % ��ӡroot�ڵ�����Ϊ0

%% ����Ԥ����---��ԭʼĿ��������ת��Ϊ��Ӧ�ı���
[unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt);


%% hotspot�㷨���ã��±ߵĴ����ǶԹ��������㷨HotSpot�㷨�ĵ���
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
print_hsnode(root,level,unique_labels,attributes);
toc;
%minSupportCount=floor(minsupport*������+0.5)��%floor��ʾ�ذ庯��