%% ����̽������
clear;
% ������ʼ��
weatherfile = '../data_analyze/weather_data.xls'; % ��������
degreefile = '../data_analyze/SS_Degree.xls' ; % ȱ������

%%  ��ȡ����
[weather_num,weather_txt] = xlsread(weatherfile);
[degree_num,degree_txt] = xlsread(degreefile);
x= weather_num(:,1);

%% �Զ��庯�����Ȼ�����ͼ��Ȼ������ͼ
cols = size(degree_num,2);
for i=2:cols
    % ��iȱ�ݣ��޺�	�ẵ	�к�
    bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[29,30,31,32])...
        ,weather_txt(1,[29,30,31,32]));

%     % ��iȱ�ݣ��غ�	�غ�	������
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[5,6,7])...
%         ,weather_txt(1,[5,6,7]));
     
%     % ��iȱ�ݣ���׼��	��ů��	�Ⱥ���
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[8,9,10])...
%         ,weather_txt(1,[8,9,10]));
%     
%     % ��iȱ�ݣ�����	С��	����
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[11,12,13])...
%         ,weather_txt(1,[11,12,13]));
%    
%     % ��iȱ�ݣ�����	�ر��	һ���
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[14,15,16])...
%         ,weather_txt(1,[14,15,16]));
%      
%     % ��iȱ�ݣ�����	����	����
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[17,18,19])...
%         ,weather_txt(1,[17,18,19]));
% 
%     % ��iȱ�ݣ�ʪ��	����	��׼
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[20,21,22])...
%         ,weather_txt(1,[20,21,22]));
%      
%     % ��iȱ�ݣ��ܳ�	����	����
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[23,24,25])...
%         ,weather_txt(1,[23,24,25]));
%     
%     % ��iȱ�ݣ�����	ů��	����
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[26,27,28])...
%         ,weather_txt(1,[26,27,28]));
%    
%     % ��iȱ�ݣ����	�ͷ�	ǿ��	����
%     bar_line_plot(x,degree_num(:,i),degree_txt{1,i},weather_num(:,[29,30,31,32])...
%         ,weather_txt(1,[29,30,31,32]));
end
 
disp('����̽��������ɣ�');