function ret = videoStabilization(inputVideo,outVideo)


invideo = VideoReader(inputVideo);

if ~isvalid(invideo)
        ret = 0;
        return;
end


outvideo = VideoWriter(outVideo);

if ~isvalid(outvideo)
    ret = 0;
    return;
end

fps = invideo.FrameRate;
outvideo.FrameRate = fps;
open(outvideo);

step = 3;


u_tot = zeros(invideo.Height, invideo.Width, 'single');
v_tot = zeros(invideo.Height, invideo.Width, 'single');


for i = 1:fps-1
    
    
    frame1 = read(invideo, i);
    frame2 = read(invideo, i+1);
    
    
    frame1 = imresize(frame1, 0.5);
    frame2 = imresize(frame2, 0.5);

    frame1=im2double(rgb2gray(frame1));
    frame2=im2double(rgb2gray(frame2));
    
    
    [u, v] = LucasKanade(frame1, frame2, 3, 1);
    
    
    u_deci = u(1:step:end, 1:step:end);
    v_deci = v(1:step:end, 1:step:end);
    
    
    u_tot = u_tot + imresize(u, [invideo.Height invideo.Width]);
    v_tot = v_tot + imresize(v, [invideo.Height invideo.Width]);
    
    
    [m, n] = size(frame1(:,:,1));
    [X,Y] = meshgrid(1:n, 1:m);
    X_deci = X(1:step:end, 1:step:end);
    Y_deci = Y(1:step:end, 1:step:end);
    
    
    warped = zeros(size(frame1), 'single');
    for c = 1:3
        warped(:,:,c) = interp2(X, Y, single(frame1(:,:,c)), X_deci+u_deci, Y_deci+v_deci, 'cubic');
    end
    
    
    writeVideo(outvideo, uint8(warped));
    
end


close(outvideo);

end
