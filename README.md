This is a try to create an algorithm for video stabilization. The code doesn't work. 


LucasKanade function • The function takes two images as arguments, window size and threshold, and returns vectors u and v. • The output of the convolutional layer is the same size as its output entrance, achieved by adding padding to the input. • Convolution is used to calculate Ix, Iy, and It, using image 1 for the first two and the difference of the two images for It. • System components are calculated for each pixel to estimate optical flow vectors, using gradients of the first frame, the difference between the two frames, and their products. • The filtered products are used to calculate the elements of the matrix A and the vector b. • The process iterates over all pixels in the image, except for a border equal to the window size. • For each pixel (i,j), a 2x2 matrix A_window and a vector b_window are calculated by averaging over a local window centered at (i,j). • The eigenvalues of A_window are calculated to check if the array is invertible. If the smallest eigenvalue is less than the limit, the optical flow for that pixel is set to zero. • The optical flow for pixel (i,j) is calculated as nu = -inv(A_window) * b_window.


videoStabilization
• The function reads and writes a video, counting the frames of the input and output video.
• It initializes motion vector arrays and loops through each frame of the input video.
• The function uses Lucas-Kanade for optical flow calculation.
• Motion vectors u and v are sampled to reduce computation time.
• The code downsamples the motion vectors to reduce the number of elements needed during the image warping step.
• The imresize() function resizes the u and v arrays to the same dimensions as the original input video.
• The final arrays contain the total motion vectors used to stabilize the video during step image distortion.
• The meshgrid() function creates a grid of X and Y coordinates for interpolation during the image warping step.
• The X_deci and Y_deci variables are created by extracting each step element of the X and Y arrays.
• The loop iterates over the three color channels of "frame1" and performs steps like interpolating pixels, defining the coordinate grid, and interpolating values.
• Cubic interpolation type for smoother pixel values.
• Outvideo argument in writeVideo.
• Uint8(warped) determines image data for output video.
• "uint8" converts image data into 8-bit integer format.
• Video is closed.


videostabCall
• Sets input and output video names.
• Calls function for stabilization.
• Loop checks if ret is 1 (correct video stabilization) or 0 (error message).
