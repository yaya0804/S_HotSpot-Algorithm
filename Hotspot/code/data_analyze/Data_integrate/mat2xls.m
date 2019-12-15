% load('Degree_dataAnalyze.mat');
% load('Degree_label.mat');
% % 将.mat文件转化为.xlsx文件，并将每一列的列名加入.xlsx文件
% xlswrite('Degree_dataAnalyze.xls',label,'sheet1','A2');
% xlswrite('Degree_dataAnalyze.xls',num,'sheet1','B2');%这里可以不要success，只是为了直观的显示是否写入成功
% attribute_field={'沙尘暴等级','年','月','日','小型蒸发量','平均地表温度','20-20累计降水量', ...
%     '平均本站气压','平均相对湿度','日照时数','平均气温','平均风速'};%这里注意外边是大括号
% xlswrite('Degree_dataAnalyze.xls',attribute_field,'sheet1','A1');
% load('Degree_dataAnalyze.mat');
% num=num(:,1:3);%取出年月日三列
% load('Degree_label.mat');%沙尘暴等级哦所在列
% load('data_scatter.mat');%离散化以后的元胞数组
% data_scatter=data_scatter(:,2:9);
% % 将.mat文件转化为.xlsx文件，并将每一列的列名加入.xlsx文件
% xlswrite('weather_dataAnalyze.xls',label,'sheet1','A2');
% xlswrite('weather_dataAnalyze.xls',num,'sheet1','B2');%这里可以不要success，只是为了直观的显示是否写入成功
% xlswrite('weather_dataAnalyze.xls',data_scatter,'sheet1','E2');
% attribute_field={'沙尘暴等级','年','月','日','小型蒸发量','平均地表温度','20-20累计降水量', ...
%     '平均本站气压','平均相对湿度','日照时数','平均气温','平均风速'};%这里注意外边是大括号
% xlswrite('weather_dataAnalyze.xls',attribute_field,'sheet1','A1');
% 


load('jieguo_end3.mat');
num(:,2)=[];
load('Degree_label.mat');%沙尘暴等级哦所在列
%% 将.mat文件转化为.xlsx文件，并将每一列的列名加入.xlsx文件
attribute_field={'沙尘暴等级','月份','小型蒸发量','20-20时累计降水量','平均相对湿度','日照时数','平均气温','平均风速'};
xlswrite('Myfile_Hotspot.xlsx',attribute_field,'sheet1','A1');
xlswrite('Myfile_Hotspot.xlsx',num,'sheet1','B2');%这里可以不要success，只是为了直观的显示是否写入成功
xlswrite('Myfile_Hotspot.xlsx',degree_label,'sheet1','A2');
