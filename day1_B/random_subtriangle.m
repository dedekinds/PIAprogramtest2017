%2016-12-21
%��ˮ��day1_2 Random subtriangle of triangle
%�ο�����MALTAB)
%By dede
%zhongzhanhuang@foxmail.com
%����ѧԭ���Լ���˵���ע���ں��Լ�Bվֱ������Ϣ
clear
m=100%����һ���㹻�������ʾ��
while(1)
x=30*rand(3,1);
y=30*rand(3,1);
T(1)=sqrt(x(1).^2+y(1).^2);
T(2)=sqrt(x(2).^2+y(2).^2);
T(3)=sqrt(x(3).^2+y(3).^2);%TΪ�߳�
    if (T(1)+T(2)>T(3) && T(2)+T(3)>T(1))%ѭ����������㣬ֱ����������һ��������Ϊֹ��ʵ�����ø�����ʾ�᷽��һЩ
        break
    end   
end
z=x+y*i;%�����ø�������һЩ2333
for k=1:m
ratio=rand(1,3);%�������ߵı���������ͬ�ֲ�
   aa=(z(2)+ratio(1)*z(3))/(1+ratio(1));%���ȷֵ㶨��
   bb=(z(3)+ratio(2)*z(1))/(1+ratio(2));
   cc=(z(1)+ratio(3)*z(2))/(1+ratio(3));
   a(k)=0;%�ƶ���ԭ����������任������״
   b(k)=bb-aa;
   c(k)=cc-aa;
   t=max(abs(c(k)-a(k)),abs(b(k)-a(k)));
   b(k)=b(k)/t;
   c(k)=c(k)/t;%�����任
   A=[1 real(a(k)) imag(a(k));
      1 real(b(k)) imag(b(k));
      1 real(c(k)) imag(c(k));];
   area(k)=abs(det(A));%�������
   z(1)=a(k);
   z(2)=b(k);
   z(3)=c(k);
end
hold on
plot(area,'ro-')






