clc; clear; close all;

%% 1. Load and play custom MP3 input
[x, fs] = audioread('clean_tone.wav');  % Replace with your actual filename

% Convert stereo to mono if needed
if size(x, 2) == 2
    x = mean(x, 2);
end

disp('Playing original input...');
sound(x, fs); 
pause(length(x)/fs + 1);  % Wait until playback finishes
figure; plot(x); title('Original Input Signal');

%% 2. Add white Gaussian noise (simulate real environment)
disp('Adding white Gaussian noise...');
y = awgn(x, 40, 'measured');  % 40 dB SNR
sound(y, fs); 
pause(length(y)/fs + 1);
figure; plot(y); title('Noisy Signal');

%% 3. Noise reduction using Low-Pass Filter
disp('Applying Low-Pass Filter...');
hlpf = fdesign.lowpass('Fp,Fst,Ap,Ast', 3000, 3500, 0.5, 50, fs);
D = design(hlpf);
freqz(D);
x_d = filter(D, y);  % Filtered signal
sound(x_d, fs);
pause(length(x_d)/fs + 1);
figure; plot(x_d); title('Denoised Signal');

%% 4. Frequency Shaping (Boost Speech Frequencies)
disp('Applying Frequency Shaping...');
f1 = fdesign.bandpass(...
    'Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
    2000,3000,4000,5000,60,2,60, fs);
hd = design(f1, 'equiripple');
freqz(hd);
y_f = filter(hd, x_d);
y_f = y_f * 100;  % Boost amplitude
sound(y_f, fs);
pause(length(y_f)/fs + 1);

%% 5. Amplitude Compression via FFT
disp('Applying Amplitude Compression...');
N = length(y_f);
Y = fft(y_f);
phase = angle(Y);
mag = abs(Y) / N;
threshold = 1000;

for i = 1:(N/2)
    if mag(i) > threshold
        mag(i) = threshold;
        mag(N-i+1) = threshold;
    end
    Y(i) = mag(i) * exp(1j * phase(i));
    Y(N-i+1) = conj(Y(i));
end

out_final = real(ifft(Y)) * 10000;  % Scale up
sound(out_final, fs); 
pause(length(out_final)/fs + 1);

%% 6. Visualize Spectrograms
figure;
subplot(2,1,1);
specgram(y, 1024, fs); 
title('Noisy Input Spectrogram');

subplot(2,1,2);
specgram(out_final, 1024, fs); 
title('Processed Output Spectrogram');
