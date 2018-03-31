function [ str1,str2,str3,str4 ] = mle_ttest_printf( x1,m )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%x1 the sample data
%m the qualified data
[phat,pci]=mle(x1,'distribution','normal');                                                      %returns maximum likelihood estimates and the 95% 
                                                                                                                        %confidence intervals for the parameters
[h1,~,~,stats]= ttest(x1,m,0.05,'left');                                                            %ttest One-sample and paired-sample t-test,
                                                                                                                        %if the mean of x1 is greater than m,h1=0;
                                                                                                                        %if not,h1=1.
                                                                                                                        %stats is a structure containing the standard deviation.
str1=sprintf('the maximum likelihood estimates: %.4f',phat(1));                 %Format data into string
str2=sprintf('%s [%.4f,%.4f]','95% confidence limits:',pci(1),pci(2));
str3=sprintf('standard deviation: %.4f',stats.sd);
if h1
    str4='quality test result: Unqualified';
else
    str4='quality test result: Qualified';
end

end

