function [ Str ] = string_catch( Sym )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
str1=char(Sym(1));                                                                 %change the sym into
str2=char(Sym(2));
Str=sprintf('%s%s%s',str1,';',str2);                                        %catch the two strings
end

