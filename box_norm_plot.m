function [ hs ] = box_norm_plot( x1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 hs=figure('Name','Detail(1)','NumberTitle','off');
 subplot(1,2,1);boxplot(x1,'notch','on');title('Box plot');
 subplot(1,2,2);normplot(x1);

end

