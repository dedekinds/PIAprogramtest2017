%function colortrainhist()
% urlread('##wenku.baidu.com/list/89','get','','GBK')
%颜色直方图，准备进行匹配算法？搜索算法
%function higdangdang()
clear 
R_hist=zeros(256,1);
G_hist=zeros(256,1);
B_hist=zeros(256,1);
booksnum=0;
eigvalue=zeros(65,1);%特征向量
tic;
for page=1:3
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
[end_startIndex,end_endIndex]= regexp(sourcefile,'component_2749882');%清洗URL
file=sourcefile([begin_endIndex:end_startIndex]);%清洗后的URL：file
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

sizeBW=size(BW);
        for temp1=1:sizeBW(1)
           for temp2=1:sizeBW(2) 
                hexnum=[dec2hex(BW(temp1,temp2,1)),dec2hex(BW(temp1,temp2,2)),dec2hex(BW(temp1,temp2,3))];
                decnum=hex2dec(hexnum);
                     for itr=0:64%判断区间64分
                         if decnum>=16777215.*itr/64 && decnum< 16777215.*(itr+1)/64
                                eigvalue(itr+1)=eigvalue(itr+1)+1;
                         end
                     end
           end
        end
    
    end
      clear sourcefile
booksnum=booksnum+size(trueurl,2);
end
%     subplot(131);plot(R_hist(1:end-1)./booksnum);xlim([ 0, 256 ]);title('R');  
%     subplot(132);plot(G_hist(1:end-1)./booksnum);xlim([ 0, 256 ]);title('G');  
%     subplot(133);plot(B_hist(1:end-1)./booksnum);xlim([ 0, 256 ]);title('B');
   plot(eigvalue(2:end-1)./booksnum)
    toc
