function direction=AI1(player1_location,player2_location,signvalue,k,code)
%f为地形函数
%player1_location为自己的位置
%player2_location为对方的位置
%AI1_location表示自己当前的位置
%k表示当前的回合数
%signvalue表示ZZ猫的位置加密
%player1_location=player1_main
%
X_self=player1_location(1);
Y_self=player1_location(2);
%     if k==1
%         AI1_loaction=[-3,-3]; 
%     else
%         AI1_loaction=[3,-3];  
%     end
[X,Y] = meshgrid(-3:0.1:3);
persistent f_before
persistent f_after
% persistent time%计算当前是第几次调用本函数
if k==1
f_before=zeros(61);
f_after=zeros(61);%初始化
end
f_after=terrain1(X,Y,signvalue,code);%获取地形函数
    if f_before.*f_after==zeros(61)%第一回合按兵不动
         direction=[1,0];
    else
        deta=f_before-f_after;
        [a,b]=find(deta==min(min(deta)));
        X0=-3+b*0.1;
        Y0=-3+a*0.1;
        if sum(player2_location-player1_location).^2>sum([X0,Y0]-player1_location).^2
             direction=[X0,Y0]-[X_self,Y_self];
        else
            direction=player2_location-player1_location;
        end
    end
f_before=f_after;
%用静态变量persistent
%最后输出方向即可



