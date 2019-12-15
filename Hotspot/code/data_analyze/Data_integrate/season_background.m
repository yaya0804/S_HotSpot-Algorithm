clc;
clear;
load('winter_background.mat');
[rows,cols]=size(winter_background);
data_scatter=cell(rows,1);
data_ssd=winter_background(:,1);
for i=1:rows
    if data_ssd(i,1)==0
       data_scatter{i,1}='I1'; 
      elseif data_ssd(i,1)==1 || data_ssd(i,1)==2
             data_scatter{i,1}='I2';
        elseif data_ssd(i,1)==3
             data_scatter{i,1}='I3';
          else
              data_scatter{i,1}='I4';
    end
end
winter_background=winter_background(:,2:7);

%% 将.mat文件转化为.xlsx文件，并将每一列的列名加入.xlsx文件
attribute_field={'沙尘暴等级','小型蒸发量','20-20时累计降水量','平均相对湿度','日照时数','平均气温','平均风速'};
xlswrite('winter_background.xlsx',attribute_field,'sheet1','A1');
xlswrite('winter_background.xlsx',winter_background,'sheet1','B2');%这里可以不要success，只是为了直观的显示是否写入成功
xlswrite('winter_background .xlsx',data_scatter,'sheet1','A2');

