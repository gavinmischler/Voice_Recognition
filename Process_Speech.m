function [VQ] = Process_Speech(num_samples, centroids_per)
%   Process_Speech
%       This function processes all of the speech samples in the directory
%       and outputs the Vector Quantization codebook VQ
%   Inputs:
%       num_samples: a vector the same length as the names cell matrix
%       indicating how many of the samples in the database should be used
%       for the training/creation of the VQ codebook. For example, if there
%       are 5 names and each person has 20 samples in the directory, but
%       only half should be used for training, then 
%       num_samples = [10 10 10 10 10]. The function will use the first 10
%       from each person this way.
%       centroids_per: the number of centroids to be calculated for each
%       subject in the database
%   Outputs:
%       VQ: a 20 x (centroids_per*length(names)) array where each column
%       contains a 20 x 1 centroid vector

close all
names = {'Gavin','Gunj','Weird1','Avery','Luis'};
mfcc_full = [];
VQ = [];

%% Load data
% name = input('Type your name\n','s');
% num_samples = input('Number of samples to sweep through: ');
% filename = input('Type the name of the wav file to be read\n','s');
for n = 1:length(names)
    for i = 1:num_samples(n)
        filename = ['C:\Users\gavin\Documents\Voice_Recognition\Samples\' names{n} '-' num2str(i) '.wav'];
        mfcc = MFCC(filename);
        labels = n*ones(1,size(mfcc,2));
        mfcc_labeled = [mfcc; labels];
        mfcc_full = [mfcc_full, mfcc_labeled];
        z = mean(mfcc,2);
%         figure()
%         plot(mfcc)
    end
    
    VQ = [VQ, vqlbg(mfcc_full(1:end-1,:),centroids_per)];
end

%VQ = vqlbg(mfcc_full, 10); %Vector quantization centroids
m = mfcc_full';

% for i = 1:num_samples(1)
%    figure(i)
%    hold on
%    plot(VQ(:,i),'LineWidth',2)
%     
% end
end
