% load('Degree_dataAnalyze.mat');
% load('Degree_label.mat');
% % ��.mat�ļ�ת��Ϊ.xlsx�ļ�������ÿһ�е���������.xlsx�ļ�
% xlswrite('Degree_dataAnalyze.xls',label,'sheet1','A2');
% xlswrite('Degree_dataAnalyze.xls',num,'sheet1','B2');%������Բ�Ҫsuccess��ֻ��Ϊ��ֱ�۵���ʾ�Ƿ�д��ɹ�
% attribute_field={'ɳ�����ȼ�','��','��','��','С��������','ƽ���ر��¶�','20-20�ۼƽ�ˮ��', ...
%     'ƽ����վ��ѹ','ƽ�����ʪ��','����ʱ��','ƽ������','ƽ������'};%����ע������Ǵ�����
% xlswrite('Degree_dataAnalyze.xls',attribute_field,'sheet1','A1');
% load('Degree_dataAnalyze.mat');
% num=num(:,1:3);%ȡ������������
% load('Degree_label.mat');%ɳ�����ȼ�Ŷ������
% load('data_scatter.mat');%��ɢ���Ժ��Ԫ������
% data_scatter=data_scatter(:,2:9);
% % ��.mat�ļ�ת��Ϊ.xlsx�ļ�������ÿһ�е���������.xlsx�ļ�
% xlswrite('weather_dataAnalyze.xls',label,'sheet1','A2');
% xlswrite('weather_dataAnalyze.xls',num,'sheet1','B2');%������Բ�Ҫsuccess��ֻ��Ϊ��ֱ�۵���ʾ�Ƿ�д��ɹ�
% xlswrite('weather_dataAnalyze.xls',data_scatter,'sheet1','E2');
% attribute_field={'ɳ�����ȼ�','��','��','��','С��������','ƽ���ر��¶�','20-20�ۼƽ�ˮ��', ...
%     'ƽ����վ��ѹ','ƽ�����ʪ��','����ʱ��','ƽ������','ƽ������'};%����ע������Ǵ�����
% xlswrite('weather_dataAnalyze.xls',attribute_field,'sheet1','A1');
% 


load('jieguo_end3.mat');
num(:,2)=[];
load('Degree_label.mat');%ɳ�����ȼ�Ŷ������
%% ��.mat�ļ�ת��Ϊ.xlsx�ļ�������ÿһ�е���������.xlsx�ļ�
attribute_field={'ɳ�����ȼ�','�·�','С��������','20-20ʱ�ۼƽ�ˮ��','ƽ�����ʪ��','����ʱ��','ƽ������','ƽ������'};
xlswrite('Myfile_Hotspot.xlsx',attribute_field,'sheet1','A1');
xlswrite('Myfile_Hotspot.xlsx',num,'sheet1','B2');%������Բ�Ҫsuccess��ֻ��Ϊ��ֱ�۵���ʾ�Ƿ�д��ɹ�
xlswrite('Myfile_Hotspot.xlsx',degree_label,'sheet1','A2');
