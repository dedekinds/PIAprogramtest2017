function findchaer
%%
%�ڶ���
tic;
clear
[I1,map]=imread('w1.png');
[I2,map]=imread('w2.png');
% I1=imresize(I,[size(I2,1),size(I2,2)]);
I1a=I1(:,:,1);%��һ��ά�ȳ�����׼
I2a=I2(:,:,1);
%ȡһ��ƥ���
x=[20:100];
y=[20:100];
vet=[];%�洢λ��
tag=I1a(x,y);%ismember(A,B)�ж�B�����Ƿ���A����
   for i=1:size(I2a,1)-size(tag,1)+1
       for j=1:size(I2a,2)-size(tag,2)+1
           tag2=I2a(i+[0:size(tag,1)-1],j+[0:size(tag,2)-1]);
%              if (sum(sum(tag-tag2))<50000)
%                  vet=[i,j];
%              end
             maxvalue(i,j)=sum(sum(tag-tag2));%У׼
       end
   end
% i=20;
% j=20;
[vet(1),vet(2)]=find(maxvalue==min(min(maxvalue)));
   for m=1:size(I1,1)
      for n=1:size(I1,2)
         newI2(m,n)=I2(m-20+vet(1),n-20+vet(2)) ;
      end
   end
image=I1(:,:,1)-newI2;%�����������ֹ���Ϊ����0���
tt=graythresh(image);
image1=im2bw(image,tt);

image=newI2-I1(:,:,1);
tt=graythresh(image);
image2=im2bw(image,tt);
%____
imshow(image1+image2);
toc

   
%%
%��һ�� 
clear
[I1,map]=imread('e1.jpg');
[I2,map]=imread('e2.jpg');
image=I2-I1;
tt=graythresh(image);
image1=im2bw(image,tt);             
%___����imshow���Զ��ж�Ϊ0����
image=I1-I2;
tt=graythresh(image);
image2=im2bw(image,tt);
%____
imshow(image1+image2)

