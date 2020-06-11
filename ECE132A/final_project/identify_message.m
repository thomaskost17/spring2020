%% identify_message
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 6/4/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [indicies, messages] = identify_message(data)

m = mean(abs(data));
s = std(abs(data));
threshold = abs(data)>(m+s);
threshold = conv(threshold,ones(100,1))==100;
d_threshold = circshift(threshold,1);
x = d_threshold ~= threshold;
index =find(x);

indicies =reshape(index, 2,length(index)/2)';
indicies(:,1)= indicies(:,1)-400;
indicies(:,2)= indicies(:,2)+400;
messages = size(indicies,1);
end