function [speakerID,mins] = vq_classify2(VQ, mfcc_sample, centroids_per, names_len)
% vq_classify compares the Mel Frequency Cepstrum Coefficients for a sample
% of speech to the coefficients in the database and outputs the id of the
% speaker who is closest to that sample

% Inputs:
%   VQ: the vq codebook containing 4 centroids for each name
%   mfcc_sample: the W x 20 vector of mfcc coefficients for the speech
%   sample
%   centroids_per: the number of centroids originally computed for each
%   person in the database
%   names_len: the number of people in the database
% Output:
%   speakerID: the label (21st element of the row vector) of the row
%   vector in the database that is closest to the input mfcc_sample
mins = [];
% Create the centroid step function which will be used to translate the
% indeces from the codewords into the indeces of a person in the database
centroid_steps = zeros(1,centroids_per*names_len);
for i = 1:names_len
    centroid_steps(centroids_per*(i-1)+1:centroids_per*(i-1)+centroids_per) = i*ones(1,centroids_per);
end

vqenc = dsp.VectorQuantizerEncoder(...
    'Codebook', VQ, ...
    'CodewordOutputPort', true, ...
    'QuantizationErrorOutputPort', true);

idx = step(vqenc,mfcc_sample);

for i = 1:length(idx)
    if idx(i) ~= 0
        mins(end+1) = centroid_steps(idx(i));
    end
end

speakerID = mode(mins);

end