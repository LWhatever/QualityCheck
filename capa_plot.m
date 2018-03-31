function [ ] = capa_plot( x1,m )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
figure('Name','Detail(3)','NumberTitle','off');
p=capaplot(x1,[m,inf]);
title(sprintf('%s%f','The possibility of reaching to standard is ',p));
xlabel('Data');ylabel('Possibility');

end

