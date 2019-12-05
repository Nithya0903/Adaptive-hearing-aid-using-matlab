function [d,noise] = adding_noise(signal);

 N = length(signal);
 noise = 0.1.*randn(N,1);
 nfilt = fir1(11,0.4);                                % Eleventh order lowpass filter
 fnoise = filter(nfilt,1,noise);
 d = signal + fnoise;

 
figure;
title('Adding_noise');
subplot(2,1,1);
plot(1:N,signal(1:N));
xlabel('Time');
ylabel('Amplitude');
title('Clean Signal');

subplot(2,1,2);
plot(1:N,d(1:N));
xlabel('Time');
ylabel('Amplitude');
title('signal with white noise');


