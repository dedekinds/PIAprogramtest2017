 function diejiaoURLcheck2()
%%
%获取全部的busServiceId
% <option value="1N">1N</option>
% <option value="2">2</option>
clear
tempbusID=[];
fidin=fopen('busid.txt');                               % 打开busid.txt文件                                
while ~feof(fidin)                                      % 判断是否为文件末尾               
    tline=fgetl(fidin);                                 % 从文件读行   
       tempbusID=[tempbusID,tline];
end
fclose(fidin);
busServiceId=regexpi(tempbusID,'(?<=<option value=").*?(?=">)','match');

bussize=size(busServiceId);%BUS的个数
 

        address1='C:\Users\ASUS\Desktop\2017PIA程序设计试水赛\官方程序\day2_A';
       address=[address1,'\','diejiaokekeda','.txt'];
        fp = fopen(address,'wt');
for numid=1:bussize(2)
    %获取某个bus有多少个direction
      stringbusid1='https://www.mytransport.sg/content/mytransport/home/commuting/busservices/jcr:content/par/mtp_generic_tab/mtp_generic_tab7/bus_arrival_time.getDirections?busServiceId=';
      stringbusid2=cell2mat(busServiceId(numid));
      stringbusid=[stringbusid1,stringbusid2];
           [directionfile, status] =urlread(stringbusid);
            if ~status
                error('读取错误\n')
            end
%                                          [{"direction":"1","description":"From Marina Ctr Ter to Blk 798"}]
          direc=regexpi(directionfile,'(?<=direction":").*?(?=","description)','match');
            sizedirec=size(direc);%计算有多少个方向
                             for numdirec=1:sizedirec(2)
%                                  Tempid=cell2mat(busServiceId(numid));
%                                  Tempdirec=cell2mat(direc(numdirec));
                                
                                           string1='https://www.mytransport.sg/content/mytransport/home/commuting/busservices/jcr:content/par/mtp_generic_tab/mtp_generic_tab7/bus_arrival_time.getRoutes?busServiceId=';
                                            string2=cell2mat(busServiceId(numid));
                                            string3=cell2mat(direc(numdirec));
                                            urlstr=[string1,string2,'&direction=',string3];%在确定BUSID和方向之后找busstop
                                            [sourcefile, status] =urlread(urlstr);
                                    busStopId=regexpi(sourcefile,'(?<=busStopId":").*?(?=","busStopDescription")','match');
                                    busStopDescription=regexpi(sourcefile,'(?<="busStopDescription":").*?(?="})','match');
                                     temp=size(busStopId);
                                    %开头的输出
                                    fprintf(fp, '%s\n', string2);% busServiceId
                                    fprintf(fp, '%s\n', string3);%direction
                                    for i=1:temp(2)
                                        tempstr=([cell2mat(busStopId(i)),',',cell2mat(busStopDescription(i))]);  
                                        fprintf(fp, '%s\n', tempstr);
                                        clear tempstr
                                    end                                
                                 
                                    
                             end
%清除direc结束后
clear direc
clear Tempid
clear Tempdirec
clear address
end
fclose(fp);

