%function colortrainhist()
% urlread('##wenku.baidu.com/list/89','get','','GBK')
%��ɫֱ��ͼ��׼������ƥ���㷨�������㷨
%function higdangdang()
clear 
R_hist=zeros(256,1);
G_hist=zeros(256,1);
B_hist=zeros(256,1);
booksnum=0;
eigvalue=zeros(65,1);%��������
tic;
for page=1:3
    string1='http://search.dangdang.com/?key=%BA%A3%D1%F3&act=input&page_index=';
    string2=mat2str(page);
    urlstr=[string1,string2];
    [sourcefile, status] =urlread(urlstr);
if ~status
    error('��ȡ����\n')
end
%��ͷ��
% %tools_box .top .switch a
[begin_startIndex,begin_endIndex]= regexp(sourcefile,'tools_box .top .switch a');%��ϴURL
[end_startIndex,end_endIndex]= regexp(sourcefile,'component_2749882');%��ϴURL
file=sourcefile([begin_endIndex:end_startIndex]);%��ϴ���URL��file
trueurl=regexpi(file,'(?<=<img data-original=).*?(?= src=)','match');%�ַ�����������ʽ

    for i=1:size(trueurl,2)
        t=cell2mat(trueurl(i));%ת��cellΪmat��ʽ
        l=t(2:end-1);%ȥ������
        
        [I,map] = imread(l);
%         figure;
            %         imshow(I,map);
            if size(size(I))~=3%Ϊʲô�е�jpgbei IMread��ȡ��Ϊ2ά�ľ��󣿣�
                continue;
            end
    BW = I;  

sizeBW=size(BW);
        for temp1=1:sizeBW(1)
           for temp2=1:sizeBW(2) 
                hexnum=[dec2hex(BW(temp1,temp2,1)),dec2hex(BW(temp1,temp2,2)),dec2hex(BW(temp1,temp2,3))];
                decnum=hex2dec(hexnum);
                     for itr=0:64%�ж�����64��
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
