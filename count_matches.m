function [] = count_matches(mins, names)
%count_matches counts the number of occurances of each person matched out
%of the vector of mins, which are the idx of the names cell matrix that each
%frame matched closest to

num_matches = zeros(1,length(names));

for i = 1:length(mins)
    num_matches(mins(i)) = num_matches(mins(i)) + 1;
end

total = sum(num_matches);


for i = 1:length(num_matches)
    percent = 100*num_matches(i)/total;
   txt = sprintf('%s: %.02f%%', names{i}, percent);
   disp(txt);
end


end

