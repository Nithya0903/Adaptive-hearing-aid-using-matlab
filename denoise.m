function o_denoise = denoise(input,noise)

L=length(input);
%RLS
M      = 32;                 
delta  = 0.1;                
P0     = (1/delta)*eye(M,M);
rlsfilt = dsp.RLSFilter(M,'InitialInverseCovariance',P0);
for k = 1:10
[y,o_denoise]  = step(rlsfilt,noise,input);
end

figure;
title('denoise');
subplot(3,1,1);
plot(1:L,input(1:L));
xlabel('Time');
ylabel('Amplitude');
title('Signal with White noise');


subplot(3,1,2);
plot(1:L,noise(1:L));
xlabel('Time');
ylabel('Amplitude');
title(' White noise');

subplot(3,1,3);
plot(0:L-1,o_denoise(1:L));
xlabel('Time');
ylabel('Amplitude');
title('Output of the adaptive RLS filter');


end
