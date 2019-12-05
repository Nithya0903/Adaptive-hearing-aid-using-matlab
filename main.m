close all;
clear all;

[x,fs] = audioread('clean signal.wav');

[d,noise]=adding_noise(x);
z=audioplayer(d,fs);
playblocking(z);

y = denoise(d,noise);
%z=audioplayer(y,fs);
%playblocking(z);

xf = frequencyfilter(y,[2,2,8,6,11,14,7,2,2],fs);
%z=audioplayer(xf,fs);
%playblocking(z);

xp=powerCompress(xf,90,fs);

z=audioplayer(xp,fs);
playblocking(z);

x = x(1:10000);
y = y(1:10000);
for i=1:10000
    pp(i)= x(i) - y(i);
end
%Calculating SNR in db
output_rms=rms(x);
noise_rms=rms(pp);
snr_output=(output_rms*output_rms)/(noise_rms*noise_rms);
snr_db=20*log10(snr_output);
display(snr_db);
xp = xp(1:1000);
%Mean square error of the filtered output
mean=immse(xp(1:1000),x(1:1000));
display(mean);



 
