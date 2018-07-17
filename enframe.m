function frames = enframe(y, N, M)
%   Inputs:
%     y: the signal as a column vector
%     N: the length of each frame in samples
%     M: the overlap of each frame in samples
%   Outputs:
%     frames: a matrix where each column is a frame of y

if (M > N)
    disp('Error: specified frame overlap is greater than frame size')
    frames = [];
    return;
end

start_pt = 1;
end_pt = N;
frames = [];
len = length(y);

while (end_pt < len)
    frames(:,end+1) = y(start_pt:end_pt);
    start_pt = end_pt-M;
    end_pt = start_pt+N-1;  
    
end


end

