function y = frequencyfilter(x,g,fs);

L = length(x);
x_length = length(x);
n = nextpow2(x_length);
N = 2^n;
T = 1/fs;
X = fft(x,N);
gain = zeros(N,1);
range=[0,500,1000,2000,3000,4000,6000,8000,10000];

k=0;
firsts = (g(2)-g(1))/(range(2)-range(1));
while(k/N <= 0.05/2)
   gain(k+1) =firsts*k/N +g(1); 
  gain(N-k) = gain(k+1);
   k=k+1;
end;


seconds=(g(3)-g(2))/(range(3)-range(2));    
while(k/N <=0.1/2)
   gain(k+1) =seconds*k/N +g(2);
   gain(N-k) = gain(k+1);
   k=k+1;
end;

thirds=(g(4)-g(3))/(range(4)-range(3));    
while(k/N <= 0.2/2)
   gain(k+1) =thirds*k/N +g(3);
   gain(N-k) = gain(k+1);
   k=k+1;
end;

fourths=(g(5)-g(4))/(range(5)-range(4));    
while(k /N<= 0.3/2)
   gain(k+1) =fourths*k/N +g(4);
   gain(N-k) = gain(k+1);
   k=k+1;
end;

fifths=(g(6)-g(5))/(range(6)-range(5));    
while(k /N<= 0.4/2)
   gain(k+1) =fifths*k/N +g(5);
   gain(N-k) = gain(k+1);
   k=k+1;
end;

sixths=(g(7)-g(6))/(range(7)-range(6));    
while(k/N <= 0.6/2)
   gain(k+1) =sixths*k/N +g(6);
   gain(N-k) = gain(k+1);
   k=k+1;
end;

sevenths=(g(8)-g(7))/(range(8)-range(7));    
while(k/N <= .8/2)
   gain(k+1) =sevenths*k/N+g(7);
   gain(N-k) = gain(k+1);
   k=k+1;
end;

eigths=(g(9)-g(8))/(range(9)-range(8));    
while(k/N <= 0.5)
   gain(k+1) =eigths*k+g(8);
   gain(N-k) = gain(k+1);
   k=k+1;
end;


Y = X+gain;
y = real(ifft(Y,N));
y = y(1:x_length);

figure;
plot(range,g)
title('Frequency Shaper Transfer Function');
xlabel('Frequency (Hertz)');
ylabel('Gain');

end
