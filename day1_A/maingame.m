function [winer,eatplayer1,eatplayer2]=maingame()
   persistent player1_main
   persistent player2_main
   persistent zzcat_main
   persistent zzcatfenshen
      player1_main=[-3,-3];player2_main=[3,-3];zzcat_main=[0,0];zzcatfenshen=[0,1];%����z�������
      [X,Y]=meshgrid(-3:0.1:3);
      fenshen=0;%����Ƿ����
      fenshentime=0;%������ڻغ���
      times=20;%�涨����غ���
      eatplayer1=0;
      eatplayer2=0;
     k=1;%��ʾ��ǰ�غ���  
     A=[1 0;
       0 1];%��������� 
      r=0.3;%��ʾ��׽�뾶
     signvalue=A*zzcat_main(:,[1:2])';%����zzcat������
     signvalue2=A*zzcatfenshen(:,[1:2])';
     
            code=[fenshen;signvalue2];%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
   player1_main(3)=terrain1(player1_main(1),player1_main(2),signvalue,code);
   player2_main(3)=terrain1(player2_main(1),player2_main(2),signvalue,code);
   zzcat_main(3)=terrain1(zzcat_main(1),zzcat_main(2),signvalue,code);
   zzcatfenshen(3)=terrain1(zzcatfenshen(1),zzcatfenshen(2),signvalue2,[1;signvalue2]);
while(1)

   f=terrain1(X,Y,signvalue,code);%����             !!!!!!�����ڱ�
   surf(X,Y,f)%�������
   colormap(cool)
 view(0,90)
   hold on
       plot3(zzcat_main(1),zzcat_main(2),zzcat_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
       plot3(player1_main(1),player1_main(2),player1_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','k')
       plot3(player2_main(1),player2_main(2),player2_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','w')
         if fenshen==1
              plot3(zzcatfenshen(1),zzcatfenshen(2),zzcatfenshen(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
              fenshentime=fenshentime+1;
              if fenshentime==times
                  fenshen=0;
                  code(1)=fenshen;
                  fenshentime=0;
              end
         end
   hold off
   pause(0.05)
   
   
   %����è�����ꡪ����������������������������������
   catdirection=mdzz_cat(player1_main(:,[1:2]),player2_main(:,[1:2]),zzcat_main) ;
   catv=VelocityDetermination(zzcat_main(3));
   catv=catv*1.2;%����è���ٶ�?��ǿ
   xcat=zzcat_main(1)+catv.*catdirection(1)./norm(catdirection);
   ycat=zzcat_main(2)+catv.*catdirection(2)./norm(catdirection);
   if xcat>=-3 && xcat<=3&& ycat>=-3 && ycat<=3%��ֹ����
    zzcat_main(1)=xcat;
    zzcat_main(2)=ycat;
   end
   if xcat<-3 || xcat>3|| ycat<-3 || ycat>3
       random1=rand(1);%���ܷ���
      if random1<0.1
          zzcat_main(1)=-3+6*rand(1);
          zzcat_main(2)=-3+6*rand(1);%��������1/3�ĸ��ʷ�������
      elseif random1<0.3
                       zzcat_main(1)=0;
                       zzcat_main(2)=0; %����������
                       fenshen=1;
                       code(1)=1;
      elseif random1<1   
          catdirection=-catdirection;
          zzcat_main(1)=zzcat_main(1)+0.01.*catdirection(1)./norm(catdirection);%��ֹ�������ް�ǽ���µ�ά�Ȳ�ƥ��
          zzcat_main(2)=zzcat_main(2)+0.01.*catdirection(2)./norm(catdirection);
      end
   end
    signvalue=A*zzcat_main(:,[1:2])';
    zzcat_main(3)=terrain1(zzcat_main(1),zzcat_main(2),signvalue,code);
    %����è�����ꡪ���������������������������������� 
    
%     %���·�������ꡪ����������������������������������
   fcatdirection=mdzz_cat(player1_main(:,[1:2]),player2_main(:,[1:2]),zzcatfenshen) ;
   fcatv=VelocityDetermination(zzcatfenshen(3));
   fcatv=fcatv*1.2;
   fxcat=zzcatfenshen(1)+fcatv.*fcatdirection(1)./norm(fcatdirection);
   fycat=zzcatfenshen(2)+fcatv.*fcatdirection(2)./norm(fcatdirection);
   
   if xcat>=-3 && xcat<=3&& ycat>=-3 && ycat<=3%��ֹ����
    zzcatfenshen(1)=fxcat;
    zzcatfenshen(2)=fycat;
   end
   if fxcat<-3 || fxcat>3|| fycat<-3 || fycat>3
       random1=rand(1);%���ܷ���
      if random1<0.1
          zzcatfenshen(1)=-3+6*rand(1);
          zzcatfenshen(2)=-3+6*rand(1);%��������1/3�ĸ��ʷ�������
      else 
          fcatdirection=-fcatdirection;
          zzcatfenshen(1)=zzcatfenshen(1)+fcatdirection(1)./norm(fcatdirection);%��ֹ�������ް�ǽ���µ�ά�Ȳ�ƥ��
          zzcatfenshen(2)=zzcatfenshen(2)+fcatdirection(2)./norm(fcatdirection);
      end
   end
     signvalue2=A*zzcatfenshen(:,[1:2])';
     code(2)=signvalue2(1);
     code(3)=signvalue2(2);
    zzcatfenshen(3)=terrain1(zzcatfenshen(1),zzcatfenshen(2),signvalue2,[1;signvalue2]);
%     %���·�������ꡪ����������������������������������   
    
 
    
    
    %����������ҵ��ж�
    %���������ж�
    
    
    %����player1�����ꡪ������������������
    play1direction=AI1(player1_main(:,[1:2]),player2_main(:,[1:2]),signvalue,k,code);
    %direction=AI1(player1_location,player2_location,signvalue,k)
    play1v=VelocityDetermination(player1_main(3));
    xplay1=player1_main(1)+play1v.*play1direction(1)./norm(play1direction);
    yplay1=player1_main(2)+play1v.*play1direction(2)./norm(play1direction);
    %___�жϳԵ��Է�
    if sqrt(sum(([xplay1,yplay1]-player2_main(:,[1:2])).^2))<r
       player2_main(:,[1:2])=[3,-3];
       eatplayer1=eatplayer1+1;
    end
    %������������
    if xplay1>=-3 && xplay1<=3&& yplay1>=-3 && yplay1<=3%��ֹ����
    player1_main(1)=xplay1;
    player1_main(2)=yplay1;%�������1������
   end
    player1_main(3)=terrain1(player1_main(1),player1_main(2),signvalue,code);
    %����player1�����ꡪ������������������ 
   
    
    %����player2�����ꡪ������������������
    play2direction=AI2(player2_main(:,[1:2]),player1_main(:,[1:2]),signvalue,k,code);
    %direction=AI1(player1_location,player2_location,signvalue,k)
    play2v=VelocityDetermination(player2_main(3));
    xplay2=player2_main(1)+play2v.*play2direction(1)./norm(play1direction);
    yplay2=player2_main(2)+play1v.*play2direction(2)./norm(play1direction);
     %___�жϳԵ��Է�
    if sqrt(sum(([xplay2,yplay2]-player1_main(:,[1:2])).^2))<r
       player1_main(:,[1:2])=[-3,-3];
        eatplayer2=eatplayer2+1;
    end
    %������������
    if xplay2>=-3 && xplay2<=3&& yplay2>=-3 && yplay2<=3%��ֹ����
    player2_main(1)=xplay2;
    player2_main(2)=yplay2;%�������2������
   end
    player2_main(3)=terrain1(player2_main(1),player2_main(2),signvalue,code);
    %����player2�����ꡪ������������������
    
    
   %��ǽ����жϲ�����Խ��
   k=k+1;%�غ���
  if sqrt(sum((player1_main(:,[1:2])-zzcat_main(:,[1:2])).^2))<r
      winer=1;
   f=terrain1(X,Y,signvalue,code);%����
      surf(X,Y,f)%�������
        colormap(cool)
          view(0,90)
   hold on
       plot3(zzcat_main(1),zzcat_main(2),zzcat_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
       plot3(player1_main(1),player1_main(2),player1_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','k')
       plot3(player2_main(1),player2_main(2),player2_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','w')%���ֲ�׽ǰһ���״̬
       if fenshen==1
              plot3(zzcatfenshen(1),zzcatfenshen(2),zzcatfenshen(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
              fenshentime=fenshentime+1;
              if fenshentime==times
                  fenshen=0;
                  code(1)=fenshen;
              end
         end
      
   hold off
      break
  end

  
   if  sqrt(sum((player2_main(:,[1:2])-zzcat_main(:,[1:2])).^2))<r  
      winer=2;     
   f=terrain1(X,Y,signvalue,code);%����;
      surf(X,Y,f)%�������
        colormap(cool)
           view(0,90)
   hold on
       plot3(zzcat_main(1),zzcat_main(2),zzcat_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
       plot3(player1_main(1),player1_main(2),player1_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','k')
       plot3(player2_main(1),player2_main(2),player2_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','w')%���ֲ�׽ǰһ���״
       if fenshen==1
              plot3(zzcatfenshen(1),zzcatfenshen(2),zzcatfenshen(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
              fenshentime=fenshentime+1;
              if fenshentime==times
                  fenshen=0;
                  code(1)=fenshen;
              end
         end
   hold off
     break
 end
           


end

% sum1=0;
% sum2=0;
% for temp=1:100
%     winer=maingame();
%     if winer==1
%        sum1=sum1+1;
%     else
%         sum2=sum2+1
%     end
% end

    
    
    
    
