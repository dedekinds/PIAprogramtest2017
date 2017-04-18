
clear
m=100%设置一个足够大的数表示∞
while(1)
x=30*rand(3,1);
y=30*rand(3,1);
T(1)=sqrt(x(1).^2+y(1).^2);
T(2)=sqrt(x(2).^2+y(2).^2);
T(3)=sqrt(x(3).^2+y(3).^2);%T为边长
    if (T(1)+T(2)>T(3) && T(2)+T(3)>T(1))%循环生成随机点，直到可以生成一个三角形为止，实际上用复数表示会方便一些
        break
    end   
end
z=x+y*i;%还是用复数表方便一些2333
for k=1:m
ratio=rand(1,3);%构造三边的比例，独立同分布
   aa=(z(2)+ratio(1)*z(3))/(1+ratio(1));%定比分点定理
   bb=(z(3)+ratio(2)*z(1))/(1+ratio(2));
   cc=(z(1)+ratio(3)*z(2))/(1+ratio(3));
   a(k)=0;%移动到原点进行伸缩变换保持形状
   b(k)=bb-aa;
   c(k)=cc-aa;
   t=max(abs(c(k)-a(k)),abs(b(k)-a(k)));
   b(k)=b(k)/t;
   c(k)=c(k)/t;%伸缩变换
   A=[1 real(a(k)) imag(a(k));
      1 real(b(k)) imag(b(k));
      1 real(c(k)) imag(c(k));];
   area(k)=abs(det(A));%计算面积
   z(1)=a(k);
   z(2)=b(k);
   z(3)=c(k);
end
hold on
plot(area,'ro-')






