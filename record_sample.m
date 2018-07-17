function y = record_sample(Fs, L)
%   Inputs:
%     Fs: sampling frequency
%     L:  length of recording in seconds
%   Outputs: 
%     y:  recording as a column vector of doubles

recObj = audiorecorder(Fs,16,1);
disp('Wait for the prompt to start speaking\n');
pause(2)
disp('Start speaking now');
record(recObj);
pause(L);
disp('End of recording\n');
stop(recObj);
y = getaudiodata(recObj);
len = length(y);
new_start = floor(len/7);
y = y(new_start:end);

end

