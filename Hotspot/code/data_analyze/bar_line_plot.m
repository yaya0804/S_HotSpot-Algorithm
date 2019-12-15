function  bar_line_plot( x,bar_y,bar_legend,line_y,line_legend )
% hold on 和hold off，是相对使用的
% 前者的意思是：在当前图的轴（坐标系）中画了一幅图，再画另一幅图时，原来的图还在，与新图共存，都看得到
% 后者表达的是：在当前图的轴（坐标系）中画了一幅图，此时，状态是hold off,则再画另一幅图时，原来的图就看不到了，在轴上绘制的是新图，原图被替换了
% x:表示月份
% bar_y:SS_Degree表格的某一列，比如第2列表示沙尘暴等级I1每个月发生多少次
% bar_legend：表示条形图的说明，条形图展现的是什么属性
% line_y：weather_data的某几列属性，查看这几个属性与bar_y的关系
% line_legend 表示折线的说明，每条折线表示什么意思

line_type ={'-o','-*','-+','-s','-d','-^'};
%标明不同的折线类型，防止混淆
figure;

hold on ;
% bar表示绘制条形图
bar(x,bar_y,0.4);
% legend(bar_legend);
% plot表示绘制折线图
cols = size(line_y,2);
for i=1:cols
   plot(x,line_y(:,i),line_type{1,i}); 
%    legend(line_legend(i));
end
legend([bar_legend,line_legend])
hold off; 


end

