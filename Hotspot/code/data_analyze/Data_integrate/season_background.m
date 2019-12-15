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

%% ��.mat�ļ�ת��Ϊ.xlsx�ļ�������ÿһ�е���������.xlsx�ļ�
attribute_field={'ɳ�����ȼ�','С��������','20-20ʱ�ۼƽ�ˮ��','ƽ�����ʪ��','����ʱ��','ƽ������','ƽ������'};
xlswrite('winter_background.xlsx',attribute_field,'sheet1','A1');
xlswrite('winter_background.xlsx',winter_background,'sheet1','B2');%������Բ�Ҫsuccess��ֻ��Ϊ��ֱ�۵���ʾ�Ƿ�д��ɹ�
xlswrite('winter_background .xlsx',data_scatter,'sheet1','A2');

