inputVideo = 'video1 (1).avi';
outVideo = 'video_stab.avi';


 ret = videoStabilization(inputVideo,outVideo);

 if ret == 1
     disp('Video was stabilized successfuly.');
 else
     disp('Error during video stabilization.');
 end