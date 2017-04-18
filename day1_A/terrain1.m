function f=terrain1(X,Y,signvalue,code)
% [X,Y] = meshgrid(-3:0.1:3)
% global zzcat_location;
% zzcat_location=[0,0];
%VelocityDetermination函数表示丁丁猫的下一步移动方向
A=[1 0;
   0 1];%特征码矩阵 
pcode=A^-1*signvalue;
signvalue2=[code(2);code(3)];
fenshen=code(1);
fcode=A^-1*signvalue2;%解密分身
X0=pcode(1);
Y0=pcode(2);
fX0=fcode(1);
fY0=fcode(2);
f=3*(1-X).^2.*exp(-(X.^2) - (Y+1).^2) ...
            - 10*(X/5 - X.^3 - Y.^5).*exp(-X.^2-Y.^2) ...
            - 1/3*exp(-(X+1).^2 - Y.^2)+ (1./exp(sqrt((X-X0).^2+(Y-Y0).^2))).^2*30+...
            fenshen*(3*(1-X).^2.*exp(-(X.^2) - (Y+1).^2) ...
            - 10*(X/5 - X.^3 - Y.^5).*exp(-X.^2-Y.^2) ...
            - 1/3*exp(-(X+1).^2 - Y.^2)+ (1./exp(sqrt((X-fX0).^2+(Y-fY0).^2))).^2*30);
 
        