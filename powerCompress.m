function y = powerCompress(input, Psat,Fs);

x=input;
x_length = length(x);
len=Fs*0.1;
iter=floor(length(x)/len);
Plow=0.008;
 
for rg=0:1:iter;
 start=rg*len+1;
 en= rg*len+len;
 if rg*len+len>length(x)
 en=length(x);
end
clear signal X  X_pow Y_pow Y y z X_phase;
signal=x(start:en);
n = nextpow2(len);
N = 2^n;
X = fft(signal,N);
X_phase=angle(X);                  
X_pow = abs(X)/N;
Y_pow = X_pow;
Y=zeros(N,1);
for k=0:N/2
   if Y_pow(k+1)>Psat          
      Y_pow(k+1)=Psat;
      Y_pow(N-k)=Psat;
   end;
   Y(k+1) = Y_pow(k+1)*(cos(X_phase(k+1))+i*sin(X_phase(k+1)));
	Y(N-k) = Y_pow(N-k)*(cos(X_phase(N-k))+i*sin(X_phase(N-k)));
end;

y = real(ifft(Y,N));

z = y(1:en-start+1);

sig_out(start:en)=z;

end;

y = sig_out*2000;

figure
subplot(211)
xlabel('time');
ylabel('amplitude')
plot(x)
ylim([-2 2]);
title('input of power compress filter')

subplot(212)
xlabel('time');
ylabel('amplitude')
plot(y)
title('output of power compress filter')
ylim([-1 1]);