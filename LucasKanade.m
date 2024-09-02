function [u, v] = LucasKanade(im1gray, im2gray, windowSize, threshold)

    
    kernel = [-1 1; -1 1];
    Ix = conv2(im1gray, kernel, 'same');
    Iy = conv2(im1gray, kernel', 'same');
    It = conv2(im1gray, windowSize, 'same') - conv2(im2gray, windowSize, 'same');

    
    Ix2 = Ix .* Ix;
    Iy2 = Iy .* Iy;
    Ixy = Ix .* Iy;
    Ixt = Ix .* It;
    Iyt = Iy .* It;


    filter = fspecial("gaussian",windowSize);
    A11 = conv2(Ix2, filter, 'same');
    A12 = conv2(Ixy, filter, 'same');
    A21 = conv2(Ixy, filter, 'same');
    A22 = conv2(Iy2, filter, 'same');
    b1 = -conv2(Ixt, filter, 'same');
    b2 = -conv2(Iyt, filter, 'same');



    
    for i = windowSize + 1:size(im1gray,1)-windowSize
        for j = windowSize + 1:size(im1gray,2)-windowSize
            A_window = [A11(i,j), A12(i,j); A21(i,j), A22(i,j)]; 
            b_window = [b1(i,j); b2(i,j)];
            eig_vals = eig(A_window);
            if min(eig_vals) < threshold
                u(i,j) = 0;
                v(i,j) = 0;
            else
                nu = -inv(A_window) * b_window;
                u(i,j) = nu(1);
                v(i,j) = nu(2);
            end

        end
    end
end