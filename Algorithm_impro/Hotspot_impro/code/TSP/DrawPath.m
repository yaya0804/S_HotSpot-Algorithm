
function DrawPath(Route, citys)

%% ��·������,��·����ͼ����ʽ��ʾ����

% ����

% Route  ����·��   

% citys  ����������λ��

%������ʼ·��
figure%��citys(Route, 1)��citys�еĵ�һ�а�route���У��м�ӷֺ��Ƕ�д
plot([citys(Route, 1); citys(Route(1), 1)], [citys(Route, 2); citys(Route(1), 2)], 'o-');
grid on
%��ÿ���ص�������

for i = 1: size(citys, 1)
    text(citys(i, 1), citys(i, 2), ['   ' num2str(i)]);
end

text(citys(Route(1), 1), citys(Route(1), 2), '       ���');
text(citys(Route(end), 1), citys(Route(end), 2), '       �յ�');