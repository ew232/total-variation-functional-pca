
clear; clc;

cd('F:\Dropbox\mathimaging\final project\experiments');

%% generate images - http://www.mathworks.com/help/images/examples/creating-a-gallery-of-transformed-images.html
I = checkerboard(15,2); % make checkboard
N = 15;
for i = 1:N
    
    I_sine = sinusoid_image( I, normrnd(5,1), normrnd(5,1) );
    I_sine = imnoise(I_sine,'gaussian', 0, 0.12);
    imwrite(I_sine, strcat(num2str(i), '.png'));
    
    I_pin = pincushion_image( I, normrnd(-.0005,0.00001) );
    I_pin = imnoise(I_pin,'gaussian', 0, 0.12);
    imwrite(I_pin, strcat(num2str(i+N), '.png'));
    
    I_pin_sine = pincushion_image( sinusoid_image(I, normrnd(5,1), normrnd(5,1)), normrnd(-.0005,0.00001) );
    I_pin_sine = imnoise(I_pin_sine,'gaussian', 0, 0.12);
    imwrite(I_pin_sine, strcat(num2str(i+(2*N)), '.png'));
    
    I_sine_pin = sinusoid_image( pincushion_image(I, normrnd(-.0005,0.00001)), normrnd(5,1), normrnd(5,1) );
    I_sine_pin = imnoise(I_sine_pin,'gaussian', 0, 0.12);
    imwrite(I_sine_pin, strcat(num2str(i+(3*N)), '.png'));
    
    % imwrite(imnoise(I,'gaussian', 0, 0.3), strcat(num2str(i+(3*N)), '.png'));

end


