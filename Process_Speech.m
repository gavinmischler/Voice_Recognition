close all
%% Get a recording from the user
% record_time = 4;
% y = record_sample(Fs, record_time);
% L = length(y);

names = {'Gavin','Gunj','Weird1'};
num_samples = [16, 7, 16];
mfcc_full = [];
%% Load data
% name = input('Type your name\n','s');
% num_samples = input('Number of samples to sweep through: ');
% filename = input('Type the name of the wav file to be read\n','s');
for n = 1:length(names)
    for i = 1:num_samples(n)
        filename = ['C:\Users\gavin\OneDrive\Documents\Speech Recog Project\Samples\' names{n} '-' num2str(i) '.wav'];
        mfcc = MFCC(filename);
        labels = n*ones(1,size(mfcc,2));
        mfcc_labeled = [mfcc; labels];
        mfcc_full = [mfcc_full, mfcc_labeled];
        z = mean(mfcc,2);
        figure()
        plot(mfcc)
        
    end
end

VQ = vqlbg(mfcc_full, 16); %Vector quantization centroids
m = mfcc_full';

% for i = 1:num_samples(1)
%    figure(i)
%    hold on
%    plot(VQ(:,i),'LineWidth',2)
%     
% end
