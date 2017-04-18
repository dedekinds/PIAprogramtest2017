%function colorstat()
clear 
R_hist=zeros(256,1);
G_hist=zeros(256,1);
B_hist=zeros(256,1);
num=1001;
booksnum=0;
color=zeros(num,1);%统计的颜色和颜色带的size保持一致
tic;
for page=1:2
    string1='http://search.dangdang.com/?key=%BA%A3%D1%F3&act=input&page_index=';
    string2=mat2str(page);
    urlstr=[string1,string2];
    [sourcefile, status] =urlread(urlstr);
if ~status
    error('读取错误\n')
end
%开头：
% %tools_box .top .switch a
[begin_startIndex,begin_endIndex]= regexp(sourcefile,'tools_box .top .switch a');%清洗URL
%结尾：
% %component_2749882
[end_startIndex,end_endIndex]= regexp(sourcefile,'component_2749882');%清洗URL
file=sourcefile([begin_endIndex:end_startIndex]);%清洗后的URL：file
%<img src=
%<img data-original=
% [book_startIndex,book_endIndex]= regexp(file,'<img data-original=');
trueurl=regexpi(file,'(?<=<img data-original=).*?(?= src=)','match');%字符串的正则表达式

    for i=1:size(trueurl,2)
        t=cell2mat(trueurl(i));%转换cell为mat形式
        l=t(2:end-1);%去掉引号
        [I,map] = imread(l);
%         figure;
            %         imshow(I,map);
            if size(size(I))~=3%为什么有的jpgbei IMread读取后为2维的矩阵？？
                continue;
            end
    BW = I;  

            [h,s,v]=rgb2hsv(BW);
            for temp1=1:size(h,1)
               for temp2=1:size(h,2)
                        for colornum=0:num%判断在哪个颜色区域
                            if h(temp1,temp2)>=colornum./(num) && h(temp1,temp2)<(colornum+1)./(num)
                                  color(colornum+1)=color(colornum+1)+1;
                            end
                        end
               end
            end
            
    end
      clear sourcefile
      booksnum=booksnum+size(trueurl,2);
end
   subplot(211);
   plot(color(2:end)./booksnum)
    toc
    
%     clear
h_1=[0:1/(num-1):1];
h=h_1;
for j=1:20
   h=[h;h_1];
end
s=0.8.*ones(size(h));%颜色带
v=ones(size(h));
k(:,:,1)=h;
k(:,:,2)=s;
k(:,:,3)=v;
t=hsv2rgb(k);
subplot(212);
imshow(t)
