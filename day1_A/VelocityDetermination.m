function v=VelocityDetermination(z)
if z~=0
    v=0.01*exp(-abs(z))+0.08;
else
    v=0.08;
end

% clear
% sum1=0;
% sum2=0;
% tic;
% for temp=1:100%���д���
%     winer=maingame();
%     if winer==1
%        sum1=sum1+1;
%     else
%         sum2=sum2+1;
%     end
% end
% toc

