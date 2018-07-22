% Records a few seconds of your speech and then attempts to classify you
% based on the database created by Process_Speech.m
Fs = 22050;
L = 4;
names = {'Gavin','Gunj','Weird1','Avery','Luis'};
num_samples = [13, 6, 13, 9, 8];
centroids_per = 8;
mins = [];

VQ = Process_Speech(num_samples, centroids_per);

while(1)
    choice = input('Do you want to test a\n  1. recording you make now\n  2. previously-recorded sample\n Or:\n  3. Quit\n');
    if choice == 3
        break;
    end
    if choice == 1
        y = record_sample(Fs,L);
        mfcc_sample = MFCC(y,Fs);
    elseif choice == 2
        filename = input('Enter the full filepath now\n','s');
        mfcc_sample = MFCC(filename);
    end
    [ID,mins] = vq_classify2(VQ, mfcc_sample, centroids_per, length(names));
    count_matches(mins,names);    
    person = names{ID};
    disp(['You are ' person newline]);
end