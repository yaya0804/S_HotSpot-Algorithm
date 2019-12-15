function  bar_line_plot( x,bar_y,bar_legend,line_y,line_legend )
% x:��ʾ�·�
% bar_y:SS_Degree����ĳһ�У������2�б�ʾɳ�����ȼ�I1ÿ���·������ٴ�
% bar_legend����ʾ����ͼ��˵��������ͼչ�ֵ���ʲô����
% line_y��weather_data��ĳ�������ԣ��鿴�⼸��������bar_y�Ĺ�ϵ
% line_legend ��ʾ���ߵ�˵����ÿ�����߱�ʾʲô��˼

line_type ={'-o','-*','-+','-s','-d','-^'};

figure;

hold on ;
% ����ͼ
bar(x,bar_y,0.4);
% legend(bar_legend);
% ����ͼ
cols = size(line_y,2);
for i=1:cols
   plot(x,line_y(:,i),line_type{1,i}); 
%    legend(line_legend(i));
end
legend([bar_legend,line_legend])
hold off; 


end

