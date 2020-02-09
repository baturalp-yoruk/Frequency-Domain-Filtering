clc;
clear all;

[y,Fs] = audioread("PinkPanther30.wav");
cutoffs = [0, 1000, 2000, 3000, 4000]; % cutoff frequencies
results = zeros(1,5); % initialize the results array
results(1) = numel(findpeaks(y)); % the one with no cutoff

for i = 2:numel(results)
    myfilter = designfilt('lowpassiir','FilterOrder',8, 'PassbandFrequency',cutoffs(i), ...
    'PassbandRipple',0.2,'SampleRate',22050); %filter with cutoff frequencies
    temp = filter(myfilter, y); % filtered data
    results(i) = numel(findpeaks(temp)); % assign the result
end

figure;
plot(cutoffs,results); %plot cutoff frequencies versus results