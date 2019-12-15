%% 数据探索代码
clear;
% 参数初始化
weatherfile = '../data_analyze/weather_data.xls'; % 天气数据
degreefile = '../data_analyze/SS_Degree.xls' ; % 缺陷数据

%%  读取数据
[weather_num,weather_txt] = xlsread(weatherfile);
[degree_num,degree_txt] = xlsread(degreefile);
x= weather_num(:,1);

%% 自定义函数，先画条形图，然后画折线图
cols = size(degree_num,2);
for i=2:cols
    % 第i缺陷，无旱	轻旱	中旱
    bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[29,30,31,32])...
        ,weather_txt(1,[29,30,31,32]));

%     % 第i缺陷，重旱	特旱	寒冷区
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[5,6,7])...
%         ,weather_txt(1,[5,6,7]));
     
%     % 第i缺陷，标准区	温暖区	热害区
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[8,9,10])...
%         ,weather_txt(1,[8,9,10]));
%     
%     % 第i缺陷，无雨	小雨	中雨
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[11,12,13])...
%         ,weather_txt(1,[11,12,13]));
%    
%     % 第i缺陷，中雨	特别低	一般低
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[14,15,16])...
%         ,weather_txt(1,[14,15,16]));
%      
%     % 第i缺陷，极干	干燥	舒适
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[17,18,19])...
%         ,weather_txt(1,[17,18,19]));
% 
%     % 第i缺陷，湿润	超短	标准
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[20,21,22])...
%         ,weather_txt(1,[20,21,22]));
%      
%     % 第i缺陷，很长	超长	寒冷
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[23,24,25])...
%         ,weather_txt(1,[23,24,25]));
%     
%     % 第i缺陷，温凉	暖热	暑热
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[26,27,28])...
%         ,weather_txt(1,[26,27,28]));
%    
%     % 第i缺陷，轻风	和风	强风	疾风
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[29,30,31,32])...
%         ,weather_txt(1,[29,30,31,32]));
end
 
disp('数据探索分析完成！');