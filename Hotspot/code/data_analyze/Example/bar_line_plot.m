function  bar_line_plot( x,bar_y,bar_legend,line_y,line_legend )
% x:表示月份
% bar_y:SS_Degree表格的某一列，比如第2列表示沙尘暴等级I1每个月发生多少次
% bar_legend：表示条形图的说明，条形图展现的是什么属性
% line_y：weather_data的某几列属性，查看这几个属性与bar_y的关系
% line_legend 表示折线的说明，每条折线表示什么意思

line_type ={'-o','-*','-+','-s','-d','-^'};

figure;

hold on ;
% 条形图
bar(x,bar_y,0.4);
% legend(bar_legend);
% 折线图
cols = size(line_y,2);
for i=1:cols
   plot(x,line_y(:,i),line_type{1,i}); 
%    legend(line_legend(i));
end
legend([bar_legend,line_legend])
hold off; 


end

