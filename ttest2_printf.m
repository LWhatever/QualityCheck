function [ str9 ] = ttest2_printf( y2,y1 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
h=ttest2(y2,y1,0.05,'left');                                    %mean of y2 is greater than y1,h=0;else h=1
if h
    str9='The quality of Sample One is better.';
else
    str9='The quality of Sample Two is better.';
end

end

