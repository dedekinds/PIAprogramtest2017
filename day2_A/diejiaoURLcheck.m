 function diejiaoURLcheck()
%%
%��ȡȫ����busServiceId
% <option value="1N">1N</option>
% <option value="2">2</option>
clear
tempbusID=[];
fidin=fopen('busid.txt');                               % ��busid.txt�ļ�                                
while ~feof(fidin)                                      % �ж��Ƿ�Ϊ�ļ�ĩβ               
    tline=fgetl(fidin);                                 % ���ļ�����   
       tempbusID=[tempbusID,tline];
end
fclose(fidin);
busServiceId=regexpi(tempbusID,'(?<=<option value=").*?(?=">)','match');

bussize=size(busServiceId);%BUS�ĸ���
for numid=1:bussize(2)
    %��ȡĳ��bus�ж��ٸ�direction
      stringbusid1='https://www.mytransport.sg/content/mytransport/home/commuting/busservices/jcr:content/par/mtp_generic_tab/mtp_generic_tab7/bus_arrival_time.getDirections?busServiceId=';
      stringbusid2=cell2mat(busServiceId(numid));
      stringbusid=[stringbusid1,stringbusid2];
           [directionfile, status] =urlread(stringbusid);
            if ~status
                error('��ȡ����\n')
            end
%                                          [{"direction":"1","description":"From Marina Ctr Ter to Blk 798"}]
          direc=regexpi(directionfile,'(?<=direction":").*?(?=","description)','match');
            sizedirec=size(direc);%�����ж��ٸ�����
                             for numdirec=1:sizedirec(2)
                                 Tempid=cell2mat(busServiceId(numid));
                                 Tempdirec=cell2mat(direc(numdirec));
                                 address1='C:\Users\ASUS\Desktop\2017PIA���������ˮ��\diejiao_problem';
                                 address=[address1,'\',Tempid,'_',Tempdirec,'.txt'];
                                    fp = fopen(address,'wt');
                                           string1='https://www.mytransport.sg/content/mytransport/home/commuting/busservices/jcr:content/par/mtp_generic_tab/mtp_generic_tab7/bus_arrival_time.getRoutes?busServiceId=';
                                            string2=cell2mat(busServiceId(numid));
                                            string3=cell2mat(direc(numdirec));
                                            urlstr=[string1,string2,'&direction=',string3];%��ȷ��BUSID�ͷ���֮����busstop
                                            [sourcefile, status] =urlread(urlstr);
                                    busStopId=regexpi(sourcefile,'(?<=busStopId":").*?(?=","busStopDescription")','match');
                                    busStopDescription=regexpi(sourcefile,'(?<="busStopDescription":").*?(?="})','match');
                                     temp=size(busStopId);
                                    %��ͷ�����
                                    fprintf(fp, '%s\n', string2);% busServiceId
                                    fprintf(fp, '%s\n', string3);%direction
                                    for i=1:temp(2)
                                        tempstr=([cell2mat(busStopId(i)),',',cell2mat(busStopDescription(i))]);  
                                        fprintf(fp, '%s\n', tempstr);
                                        clear tempstr
                                    end                                
                                 
                                    fclose(fp);
                             end
%���direc������
clear direc
clear Tempid
clear Tempdirec
clear address
end

%%
%  fp = fopen('C:\Users\ASUS\Desktop\2017PIA���������ˮ��\diejiao_problem','wt')
% % https://www.mytransport.sg/content/mytransport/home/commuting/busservices/jcr:content/par/mtp_generic_tab/mtp_generic_tab7/bus_arrival_time.getDirections?busServiceId=3
% % https://www.mytransport.sg/content/mytransport/home/commuting/busservices/jcr:content/par/mtp_generic_tab/mtp_generic_tab7/bus_arrival_time.getRoutes?busServiceId=3&direction=1
% string1='https://www.mytransport.sg/content/mytransport/home/commuting/busservices/jcr:content/par/mtp_generic_tab/mtp_generic_tab7/bus_arrival_time.getRoutes?busServiceId=';
% % busServiceId=3&direction=1    
% %  busServiceId=3
% %  direction=1
%     string2=mat2str(busServiceId);
%     string3=mat2str(direction);
%     urlstr=[string1,string2,'&direction=',string3];
%     [sourcefile, status] =urlread(urlstr);
% if ~status
%     error('��ȡ����\n')
% end
% % busStopId
% % busStopDescription
% % {"busStopId":"75009","busStopDescription":"Tampines Int"}
% busStopId=regexpi(sourcefile,'(?<=busStopId":").*?(?=","busStopDescription")','match');
% busStopDescription=regexpi(sourcefile,'(?<="busStopDescription":").*?(?="})','match');
% % printfMatrix=[busServiceId;direction];
% 
% temp=size(busStopId);
% %��ͷ�����
% fprintf(fp, '%s\n', string2);% busServiceId
% fprintf(fp, '%s\n', string3);%direction
% for i=1:temp(2)
%     tempstr=([cell2mat(busStopId(i)),',',cell2mat(busStopDescription(i))]);  
%     fprintf(fp, '%s\n', tempstr);
%     clear tempstr
% end
% % printfMatrix(1)=busServiceId;
% % printfMatrix(2)=direction;
% % printfMatrix
% 
% fclose(fp);
% 
