function [ ] = regress_mesh( y1,x1,x2 )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
if isempty(x2)
    b=polyfit(x1,y1,1);
    figure('Name','Simple linear regression','NumberTitle','off');                %simple linear regression
    plot(x1,y1,'o');                                                                                           %scatter plot
    lsline;                                                                                                         %draw the regression line
    str=sprintf('scatter plot with a regression line:\ny=%.3fx+%.3f',b(1),b(2));
    title(str);
    xlabel('factor one');ylabel('result');
else
b=regress(y1,[ones(9,1),x1,x2]);                                                                %multiple linear regression
figure('Name','Multiple linear regression','NumberTitle','off');
scatter3(x1,x2,y1);                                                                                       %3-D scatter plot
hold on;

%creat a grid
Length=400;
X1=min(x1):(max(x1)-min(x1))/Length:max(x1);
X2=min(x2):(max(x2)-min(x2))/Length:max(x2);
X1=ones(length(X1),1)*X1;
X2=ones(length(X2),1)*X2;

y=b(1)+b(2).*X1+b(3).*X2;                                                                          %make the result of multiple linear regression into a line
mesh(X1,X2,y);                                                                                            %draw the regression line in 3-D scatter plot
str=sprintf('3-D scatter plot with a regression line:\ny=%.3fx1+%.3fx2+%.3f',b(2),b(3),b(1));
title(str);
xlabel('factor one');ylabel('factor two');
zlabel('result');
end
end

