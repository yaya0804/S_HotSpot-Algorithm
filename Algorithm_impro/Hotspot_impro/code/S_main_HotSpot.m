%% ��ջ�������
clear;
clc;
tic;
%%
% inputfile ='D:\R2016a\workpace\experiment\Hotspot\code\data\hotspotdata.xls';
% % hotspottreefile = '../tmp/hstree.mat';
% labelIndex = 3;
% attrsIndex_txt=6;%[8,10];%
% attrsIndex=1;%[3,5]; % 
% % level =0; % ��ӡroot�ڵ�����Ϊ0
 %% ��ʼ������
inputfile ='..\code\data\winequality-white.xlsx';
% hotspottreefile = '../tmp/hstree.mat';%
labelIndex = 1; % ����Ŀ��������ɢ�����ݣ�Ҳ����Ŀ���������ڵ��У���Ҫ�Լ�ȥ��λ
%TXT �·�2��С��������3��20-20�ۼƽ�ˮ��4��ƽ�����ʪ��5������ʱ��6��ƽ������7��ƽ������8���Ա���8�У�
%num  1           2            3                4          5         6         7       
attrsIndex_txt=[2,3,4,5,6,7,8,9,10,11,12];%�ֱ��ʾƽ���ر��¶Ⱥ�20-20�ۼƽ�ˮ��������
attrsIndex=[1,2,3,4,5,6,7,8,9,10,11]; % ���������ж�������������,������ͨ��HotSpot�㷨����Ŀ�����ԣ�ɳ�����ȼ���ĳ�������ԵĹ�����ϵ

% attrsIndex_txt=[2,3,4,5,6,7];%�Լ��������ݼ�Ϊ�ھ򱳾�ʱ
% attrsIndex=[1,2,3,4,5,6]; % 

%% Ҫ��Ŀ������labelStateIndex�����˸�cal_Energy����Ҫ��print_opt_Tree������ߵı���

% attrsIndex_txt=[3,4];%�ֱ��ʾƽ���ر��¶Ⱥ�ƽ����վ��ѹ������
% attrsIndex=[2,3]; % ���������ж�������������,������ͨ��HotSpot�㷨����Ŀ�����ԣ�ɳ�����ȼ���ĳ�������ԵĹ�����ϵ
%% ����Ԥ����---��ԭʼĿ��������ӵ�е�ֵת��Ϊ��Ӧ�ı���
[unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt);

%%�¶Ȳ���
T0 = 1e20;      % ��ʼ�¶�10��20�η�����������
Tf = 1e-30;     % ��ֹ�¶�10��-30�η�����������
% T0 = 1e10;    
% Tf = 1e-10;
%L = 2;       % ���¶��µĵ���������Ҳ������ѭ��������Lk,������Ծ��Ƿ�ʱ���㷨 
q = 0.9;        % �������ʣ���������
Time = ceil(double(solve([num2str(T0) '*(0.9)^x = ', num2str(Tf)])));       % ��������Ĵ��� T0 * (0.9)^x = Tf
%solve������Ҫ���������������̵Ľ�������߾�ȷ��
 count = 0;                                                                  % ��ʼ��������=����
 rem_E_Support = zeros(Time, 2);  %��һ��������¼ÿ��ÿ�ε������̵���С֧�ֶȣ��ڶ���������¼֧�ֶȶ�Ӧ����������ֵ                                                     % Ŀ��ֵ�����ʼ��
%% V. %�������һ����ʼ֧�ֶ�
minSupport=0.001;%��С֧�ֶ���0-1�ڵȿ��ܵ�ȡ������ʾ0.1%
% minSupport=rand(1,1);%��С֧�ֶ���0-1�ڵȿ��ܵ�ȡ��
 %% VI. �����Ż�
while T0 > Tf
     count = count + 1;  % ���µ�������
    % 1. �����½�
     new_minSupport = NewAnswer(Time,count);%�������ԭʼ·��������λ��
    % 2. Metropolis�����ж��Ƿ�����½�
    [minSupport,E] = Metropolis(minSupport, new_minSupport, T0, unique_labels, data);                                    % Metropolis �����㷨
% 3.1��¼ÿ�ε���������Ž⣬
    % �±ߴ����ʾ�����µ���������ֵ֮��dC = E2 -E1����0��������һ�����ʱ����ܣ���ʱ��ֻ����֧�ֶ���Ϊ��ǰ�⣬�����ܸ�����ֵ��
    %��Ϊ������ֵ��Ҫ����һ�е�E���бȽϣ�ֻ��С����һ�����Ž�ű���¼�������Լ�¼��һ�������Ž⣬����rem_E_Support����
    %����ʾ֧�ֶ���֮��Ӧ������ֵ�����ǵ�������֧�ֶ�ʱ����������ֵ��
%     if E==1 %E==1��ʾû���ھ򵽹�������
%         break;
%     else
%         if count == 1 || E < rem_E_Support(count-1,2)                                       % �����ǰ�¶��µľ���С���ϸ��¶ȵľ��룬��¼��ǰ����
%             rem_E_Support(count,2) = E;                                                     
%         else
%             rem_E_Support(count,2) = rem_E_Support(count-1,2);                                          
%         end
%             rem_E_Support(count,1) = minSupport; 
%     end
% 3.2.��¼ÿ�ε����Ľ�,rem_E_Support���յĽ����ߵ�֧�ֶȺ�����ֵ��û�б䣬��ʾE2����E1,����exp(-dC/T)����̫�ͣ����ᱻ���ܣ�ʹ��һֱ��������ǰ���Ž⡣
    if E==1 %E==1��ʾû���ھ򵽹�������
        break;
    else
      rem_E_Support(count,1) = minSupport;    
      rem_E_Support(count,2) = E;          
    end
% 5.��q�����ʽ��£��¶ȸ��º���--ָ������
    T0 = q * T0;        
end 
 rem_E_Support(rem_E_Support(:,1)==0,:) = [];
 min_E=min(rem_E_Support(:,2));
 opt_Support=rem_E_Support(rem_E_Support(:,2)==min_E,1);%��Ϊ��һ�д�ŵ�����С֧�ֶ�
 disp(['����֧�ֶ�����Ϊ��',num2str(min(opt_Support)*100), '% - ',num2str(max(opt_Support)*100),'% ']);
 opt_Support=opt_Support(1,1);
 disp('����HotSpot�������������£�');
 print_opt_Tree(opt_Support, unique_labels, data,attributes);
 toc;