function coeffs = MFCC(varargin)
% Calculates the Mel Frequency Cepstrum Coefficients (K = 20) of an audio recording
%     Inputs: 
%         1 Input: filepath: the path to a .wav file
%         2 Inputs: y, Fs: allows the creation of coeffs from just one
%         recording sample
%     Outputs:
%         coeffs: mel frequency cepstrum coefficients as an 20 by W matrix,
%             where W is the number of frames taken from the signal

%% Load data
if length(varargin) == 1
    [y,Fs] = audioread(varargin{1});
elseif length(varargin) == 2
    y = varargin{1};
    Fs = varargin{2};
end

%% Pre-Emphasis filter
% This emphasizes the higher frequencies using a first order filter
% of the form y(t) = x(t) - a*x(t-1)
% a = 0.97;
% B = [1 -a];
% y = filter(B,1,y);

%% Frame Blocking
N = floor(Fs*.03); % N is number of samples in 50 milliseconds
%freq = [32 64 128 256 512 1024 2048];
%[~, idx] = min(abs(freq-N)); 
%N = freq(idx); % Set N to be the nearest power of two 
M = floor(N/3); % M controls how much overlap there is between frames
frames = enframe(y,N,M);
h_window = hamming(N); % Calculate hamming window for size N

%% Windowing
FT = fft(frames.*h_window); % Apply the window to the frame and transform it
%
L2 = size(FT,1);
% for_plot = abs(FT(1:L2/2+1, 60)).^2;
% f2 = Fs*(0:(L2/2))/L2;
% figure()
% stem(f2, for_plot);
% xlabel('Hz')
% ylabel('Fourier transform')
%
N1 = 1 + floor(N/2);
mel = melfb(20,N,Fs);
FT1 = mel * abs(FT(1:N1,:)).^2;
coeffs = dct(FT1);

end

