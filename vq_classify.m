function [speakerID,mins] = vq_classify(mfcc, mfcc_sample)
% vq_classify compares the Mel Frequency Cepstrum Coefficients for a sample
% of speech to the coefficients in the database and outputs the id of the
% speaker who is closest to that sample

% Inputs:
%   m: the database, as an 21 x N matrix of labeled vertical mfcc
%   vectors
%   mfcc_sample: the 20 x W vector of mfcc coefficients for the speech
%   sample
% Output:
%   speakerID: the label (21st element of the row vector) of the row
%   vector in the database that is closest to the input mfcc_sample
mins = [];
for s = 1:length(mfcc_sample)
    min_dist = norm(mfcc(1:end-1,1)-mfcc_sample(:,s));
    min_idx = 1;
    for i = 2:size(mfcc,2)
        dist = norm(mfcc(1:end-1,i)-mfcc_sample(:,s));
        if (dist < min_dist)
            min_dist = dist;
            min_idx = i;
        end
        
    end
    mins(s) = mfcc(21,min_idx);
end

speakerID = mode(mins);

end