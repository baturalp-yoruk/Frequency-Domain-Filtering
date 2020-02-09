clc;
clear all;

photo = imread('Hubble-Massive-Panorama.png'); % Read the image
grayphototemp = rgb2gray(photo);
grayphoto = imbinarize(photo); % The binary version of photo
timedomain = []; % Initialize the timedomain array
for j=1:1024
    temp = zeros(900,1); % For every colomn
    for i=900:-1:1
        if(grayphoto(i,j)==1)
            amp= fix(i/90)+1; % Amplitude 
            temp(i) = amp*exp(-1i*2*pi*i); % Assign the value " amp * e^(j*2*pi*i) "
        end
    end
    temp2 = ifft(temp,900); % Inverse Fourier Transform
    timedomain = [timedomain ; temp2] ; % Append them all to have 1024 seconds
end

filename = 'space_sound.wav'; % Create a new wav file
audiowrite(filename,timedomain,900); % Write it to file
[y,Fs] = audioread(filename); % Read the file
sound(y,2000); % Play the sound file
