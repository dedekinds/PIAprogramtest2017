% urlread('##wenku.baidu.com/list/89','get','','GBK')
%��ɫֱ��ͼ��׼������ƥ���㷨�������㷨
%function higdangdang()
clear 
R_hist=zeros(256,1);
G_hist=zeros(256,1);
B_hist=zeros(256,1);
booksnum=0;
tic;
for page=1:5
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
%��β��
% %component_2749882
[end_startIndex,end_endIndex]= regexp(sourcefile,'component_2749882');%��ϴURL
file=sourcefile([begin_endIndex:end_startIndex]);%��ϴ���URL��file
%<img src=
%<img data-original=
% [book_startIndex,book_endIndex]= regexp(file,'<img data-original=');
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
    R=BW(:,:,1);  
    [REDcounts,x] = imhist(R);  
    G=BW(:,:,2);  
    [Greencounts,y] = imhist(G);  
    B=BW(:,:,3);  
    [Bluecounts,z] = imhist(B); 
    R_hist=R_hist+REDcounts;
    G_hist=G_hist+Greencounts;
    B_hist=B_hist+Bluecounts;
    end
      clear sourcefile
booksnum=booksnum+size(trueurl,2);
end
    subplot(131);plot(R_hist(1:end-1)./booksnum);xlim([ 0, 256 ]);title('R');  
    subplot(132);plot(G_hist(1:end-1)./booksnum);xlim([ 0, 256 ]);title('G');  
    subplot(133);plot(B_hist(1:end-1)./booksnum);xlim([ 0, 256 ]);title('B');
%     subplot(131);plot(R_hist./page./i);xlim([ 0, 256 ]);title('R');  
%     subplot(132);plot(G_hist./page./i);xlim([ 0, 256 ]);title('G');  
%     subplot(133);plot(B_hist./page./i);xlim([ 0, 256 ]);title('B');
    toc
%     fsf=R_hist+G_hist+B_hist;
%     plot(fsf(1:end-1))
%     ylim([ 0, 5*10^4 ]);