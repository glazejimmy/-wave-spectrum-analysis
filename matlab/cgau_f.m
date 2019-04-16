function g = cgau_f(f0,df,dur);
% CGAU_F Impulse response of complex gaussian filter
% 
% f0 - normalized central frequensy (from [0 1])
% df - normalized bandwidth at +- "sigma"-level (from [0 1])
% dur - duration in "sigmas"; for example, 2, 4 or 6

n0=ceil(dur/(2*pi*df));
t=linspace(-dur/2,dur/2,2*n0+1);
g=exp(-t.^2/2).*exp(i*pi*f0*[-n0:n0]);
g=g/norm(g);