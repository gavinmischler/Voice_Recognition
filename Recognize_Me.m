% Records a few seconds of your speech and then attempts to classify you
% based on the database created by Process_Speech.m
Fs = 22050;
L = 4;
names = {'Gavin','Gunj','Weird1','Avery','Luis'};
while(1)
    choice = input('Do you want to test a\n  1. recording you make now\n  2. previously-recorded sample\n');
    if choice == 1
        y = record_sample(Fs,L);
        mfcc_sample = MFCC(y,Fs);
    elseif choice == 2
        filename = input('Enter the full filepath now\n','s');
        mfcc_sample = MFCC(filename);
    end
    mfcc_sample = mfcc_sample';
    [ID,mins] = vq_classify(m, mfcc_sample);
    person = names{ID};
    disp(['You are ' person]);
    quit = input('Enter q to quit\n','s');
    if strcmp(quit,'q')
        break;
    end
end