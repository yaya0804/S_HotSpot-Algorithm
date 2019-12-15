clc;
clear;
x=1:0.01:2;
y=sin(10*pi*x)./x;
figure;
plot(x,y,'linewidth',1.5);
ylim([-1.5,1.5]);
xlabel('X');
ylabel('Y');
title('y=sin(10*pi*x)./x');
hold on;

[maxVal,maxIndex]=max(y);%maxVal���ֵ,maxIndex���ֵ����
plot(x(maxIndex), maxVal, 'r*','linewidth',2)
text(x(maxIndex), maxVal, {[' X: ' num2str(x(maxIndex))];[' Y: ' num2str(maxVal)]})  %num2str������������ת��Ϊ�ַ�������
hold on
 
%%
% 2. ��ǳ���Сֵ��
[minVal,minIndex] = min(y);
plot(x(minIndex), minVal, 'ks','linewidth',2)
text(x(minIndex), minVal, {[' X: ' num2str(x(minIndex))];[' Y: ' num2str(minVal)]})