function direction=AI1(player1_location,player2_location,signvalue,k,code)
%fΪ���κ���
%player1_locationΪ�Լ���λ��
%player2_locationΪ�Է���λ��
%AI1_location��ʾ�Լ���ǰ��λ��
%k��ʾ��ǰ�Ļغ���
%signvalue��ʾZZè��λ�ü���
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
% persistent time%���㵱ǰ�ǵڼ��ε��ñ�����
if k==1
f_before=zeros(61);
f_after=zeros(61);%��ʼ��
end
f_after=terrain1(X,Y,signvalue,code);%��ȡ���κ���
    if f_before.*f_after==zeros(61)%��һ�غϰ�������
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
%�þ�̬����persistent
%���������򼴿�



