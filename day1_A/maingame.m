function [winer,eatplayer1,eatplayer2]=maingame()
   persistent player1_main
   persistent player2_main
   persistent zzcat_main
   persistent zzcatfenshen
      player1_main=[-3,-3];player2_main=[3,-3];zzcat_main=[0,0];zzcatfenshen=[0,1];%加上z坐标才行
      [X,Y]=meshgrid(-3:0.1:3);
      fenshen=0;%标记是否分身
      fenshentime=0;%分身存在回合数
      times=20;%规定分身回合数
      eatplayer1=0;
      eatplayer2=0;
     k=1;%表示当前回合数  
     A=[1 0;
       0 1];%特征码矩阵 
      r=0.3;%表示捕捉半径
     signvalue=A*zzcat_main(:,[1:2])';%加密zzcat特征码
     signvalue2=A*zzcatfenshen(:,[1:2])';
     
            code=[fenshen;signvalue2];%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
   player1_main(3)=terrain1(player1_main(1),player1_main(2),signvalue,code);
   player2_main(3)=terrain1(player2_main(1),player2_main(2),signvalue,code);
   zzcat_main(3)=terrain1(zzcat_main(1),zzcat_main(2),signvalue,code);
   zzcatfenshen(3)=terrain1(zzcatfenshen(1),zzcatfenshen(2),signvalue2,[1;signvalue2]);
while(1)

   f=terrain1(X,Y,signvalue,code);%地形             !!!!!!地形遮蔽
   surf(X,Y,f)%输出画面
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
   
   
   %更新猫的坐标——————————————————
   catdirection=mdzz_cat(player1_main(:,[1:2]),player2_main(:,[1:2]),zzcat_main) ;
   catv=VelocityDetermination(zzcat_main(3));
   catv=catv*1.2;%削弱猫的速度?增强
   xcat=zzcat_main(1)+catv.*catdirection(1)./norm(catdirection);
   ycat=zzcat_main(2)+catv.*catdirection(2)./norm(catdirection);
   if xcat>=-3 && xcat<=3&& ycat>=-3 && ycat<=3%防止出界
    zzcat_main(1)=xcat;
    zzcat_main(2)=ycat;
   end
   if xcat<-3 || xcat>3|| ycat<-3 || ycat>3
       random1=rand(1);%技能发动
      if random1<0.1
          zzcat_main(1)=-3+6*rand(1);
          zzcat_main(2)=-3+6*rand(1);%设置闪现1/3的概率发动技能
      elseif random1<0.3
                       zzcat_main(1)=0;
                       zzcat_main(2)=0; %发动分身技能
                       fenshen=1;
                       code(1)=1;
      elseif random1<1   
          catdirection=-catdirection;
          zzcat_main(1)=zzcat_main(1)+0.01.*catdirection(1)./norm(catdirection);%防止陷入无限按墙导致的维度不匹配
          zzcat_main(2)=zzcat_main(2)+0.01.*catdirection(2)./norm(catdirection);
      end
   end
    signvalue=A*zzcat_main(:,[1:2])';
    zzcat_main(3)=terrain1(zzcat_main(1),zzcat_main(2),signvalue,code);
    %更新猫的坐标—————————————————— 
    
%     %更新分身的坐标——————————————————
   fcatdirection=mdzz_cat(player1_main(:,[1:2]),player2_main(:,[1:2]),zzcatfenshen) ;
   fcatv=VelocityDetermination(zzcatfenshen(3));
   fcatv=fcatv*1.2;
   fxcat=zzcatfenshen(1)+fcatv.*fcatdirection(1)./norm(fcatdirection);
   fycat=zzcatfenshen(2)+fcatv.*fcatdirection(2)./norm(fcatdirection);
   
   if xcat>=-3 && xcat<=3&& ycat>=-3 && ycat<=3%防止出界
    zzcatfenshen(1)=fxcat;
    zzcatfenshen(2)=fycat;
   end
   if fxcat<-3 || fxcat>3|| fycat<-3 || fycat>3
       random1=rand(1);%技能发动
      if random1<0.1
          zzcatfenshen(1)=-3+6*rand(1);
          zzcatfenshen(2)=-3+6*rand(1);%设置闪现1/3的概率发动技能
      else 
          fcatdirection=-fcatdirection;
          zzcatfenshen(1)=zzcatfenshen(1)+fcatdirection(1)./norm(fcatdirection);%防止陷入无限按墙导致的维度不匹配
          zzcatfenshen(2)=zzcatfenshen(2)+fcatdirection(2)./norm(fcatdirection);
      end
   end
     signvalue2=A*zzcatfenshen(:,[1:2])';
     code(2)=signvalue2(1);
     code(3)=signvalue2(2);
    zzcatfenshen(3)=terrain1(zzcatfenshen(1),zzcatfenshen(2),signvalue2,[1;signvalue2]);
%     %更新分身的坐标——————————————————   
    
 
    
    
    %加入放置左右的判断
    %加入先手判断
    
    
    %更新player1的坐标——————————
    play1direction=AI1(player1_main(:,[1:2]),player2_main(:,[1:2]),signvalue,k,code);
    %direction=AI1(player1_location,player2_location,signvalue,k)
    play1v=VelocityDetermination(player1_main(3));
    xplay1=player1_main(1)+play1v.*play1direction(1)./norm(play1direction);
    yplay1=player1_main(2)+play1v.*play1direction(2)./norm(play1direction);
    %___判断吃掉对方
    if sqrt(sum(([xplay1,yplay1]-player2_main(:,[1:2])).^2))<r
       player2_main(:,[1:2])=[3,-3];
       eatplayer1=eatplayer1+1;
    end
    %——————
    if xplay1>=-3 && xplay1<=3&& yplay1>=-3 && yplay1<=3%防止出界
    player1_main(1)=xplay1;
    player1_main(2)=yplay1;%更新玩家1的坐标
   end
    player1_main(3)=terrain1(player1_main(1),player1_main(2),signvalue,code);
    %更新player1的坐标—————————— 
   
    
    %更新player2的坐标——————————
    play2direction=AI2(player2_main(:,[1:2]),player1_main(:,[1:2]),signvalue,k,code);
    %direction=AI1(player1_location,player2_location,signvalue,k)
    play2v=VelocityDetermination(player2_main(3));
    xplay2=player2_main(1)+play2v.*play2direction(1)./norm(play1direction);
    yplay2=player2_main(2)+play1v.*play2direction(2)./norm(play1direction);
     %___判断吃掉对方
    if sqrt(sum(([xplay2,yplay2]-player1_main(:,[1:2])).^2))<r
       player1_main(:,[1:2])=[-3,-3];
        eatplayer2=eatplayer2+1;
    end
    %——————
    if xplay2>=-3 && xplay2<=3&& yplay2>=-3 && yplay2<=3%防止出界
    player2_main(1)=xplay2;
    player2_main(2)=yplay2;%更新玩家2的坐标
   end
    player2_main(3)=terrain1(player2_main(1),player2_main(2),signvalue,code);
    %更新player2的坐标——————————
    
    
   %对墙体的判断不可以越界
   k=k+1;%回合数
  if sqrt(sum((player1_main(:,[1:2])-zzcat_main(:,[1:2])).^2))<r
      winer=1;
   f=terrain1(X,Y,signvalue,code);%地形
      surf(X,Y,f)%输出画面
        colormap(cool)
          view(0,90)
   hold on
       plot3(zzcat_main(1),zzcat_main(2),zzcat_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
       plot3(player1_main(1),player1_main(2),player1_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','k')
       plot3(player2_main(1),player2_main(2),player2_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','w')%保持捕捉前一秒的状态
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
   f=terrain1(X,Y,signvalue,code);%地形;
      surf(X,Y,f)%输出画面
        colormap(cool)
           view(0,90)
   hold on
       plot3(zzcat_main(1),zzcat_main(2),zzcat_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','r')
       plot3(player1_main(1),player1_main(2),player1_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','k')
       plot3(player2_main(1),player2_main(2),player2_main(3),'Marker','o','Markersize',10,'MarkerFaceColor','w')%保持捕捉前一秒的状
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

    
    
    
    
