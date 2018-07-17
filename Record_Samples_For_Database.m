% Records a bunch of ~3.5 second samples and stores them in the database
name = input('Type your name\n', 's');
rec_num = input('How many samples of your voice exist already? Input a number\n');
count = 1;
Fs = 22050;
L = 4;
while(1)
    recObj = audiorecorder(Fs,16,1);
    disp('Wait for the prompt to start speaking');
    pause(2)
    disp('Start speaking now');
    record(recObj);
    pause(L);
    disp('End of recording');
    stop(recObj);
    y = getaudiodata(recObj);
    len = length(y);
    new_start = floor(len/7);
    y = y(new_start:end);
    filename = [name '-' num2str(rec_num+count) '.wav'];
    audiowrite(filename, y, Fs);
    pause(1);
    quit = input('Enter q to quit\n','s');
    if (strcmp('q',quit))
        break;
    end
    count = count+1;
end

