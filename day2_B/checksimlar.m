%function checksimlar()
clear
load eigvalue
t=eigvalue(2:end-1);
% load wer
% t=wer(2:end-1);
eigvalue1=zeros(65,1);
for times=1:8%8张图片
    string1=mat2str(times);
    string2='.jpg';
    str=[string1,string2];
 [I,map] = imread(str);
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
                                eigvalue1(itr+1)=eigvalue1(itr+1)+1;
                         end
                     end
           end
        end
        p=eigvalue1(2:end-1);
similar(times)=sum(t.*p)./norm(t)./norm(p);
eigvalue1=zeros(65,1);
end