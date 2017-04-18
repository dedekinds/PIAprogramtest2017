function direction=mdzz_cat(player1,player2,cat)
% distan1=sqrt(sum((player1-cat).^2));
% distan2=sqrt(sum((player2-cat).^2));
r=1.5;
v1=2.5.*(cat(:,[1:2])-player1);
v2=2.5.*(cat(:,[1:2])-player2);
direction=[1-2*rand(1),1-2*rand(1)];
catv=VelocityDetermination(cat(3));
   catv=catv*1.2;%Ï÷ÈõÃ¨µÄËÙ¶È
   xcat=cat(1)+catv.*direction(1)./norm(direction);
   ycat=cat(2)+catv.*direction(2)./norm(direction);
   
if sqrt(sum((player1(:,[1:2])-[xcat,ycat]).^2))<r
    direction=direction+v1;    
end
if sqrt(sum((player2(:,[1:2])-[xcat,ycat]).^2))<r
    direction=direction+v1;    
end


% clear
%  player1=[-1,0];player2=[1,0]
% 
% 
% [X,Y]=meshgrid(-3:0.1:3);
% f1=(1./exp(sqrt((X-player1(1)).^2+(Y-player1(2)).^2))).^2*30;
% f2=(1./exp(sqrt((X-player2(1)).^2+(Y-player1(2)).^2))).^2*30;
% f=f1+f2;
% surf(X,Y,f)
% figure
% surf(X,Y,f1)
% figure
% surf(X,Y,f2)

