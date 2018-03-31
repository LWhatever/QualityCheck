function [ hs ] = hist_scatter_plot( x1 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
        hs=figure('Name','Detail(2)','NumberTitle','off');
        subplot(1,2,1);histfit(x1,9);                                                           %histogram with a distribution fit
        title('Histogram with a distribution fit');
        xlabel('Data');ylabel('Possibility');
        y=normpdf(x1,mean(x1),std(x1));                                                %get the normal probability density of x1
        subplot(1,2,2);
        gscatter(x1,y,ones(length(x1),1));                                                %scatter plot 
        hold on;
        z=polyfit(x1,y,7);                                                                            %get a fitting function between x1 and y
        z=polyval(z,sort(x1));
        plot(sort(x1),z);title('Scatter plot with a fitting line');                     %draw the fitting line
        xlabel('Data');ylabel('Possibility');

end

