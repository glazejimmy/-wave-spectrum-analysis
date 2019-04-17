function fb=cgau_fb(f0, df, dur);
% CGAU_FB Complex gaussian filterbank
% 
% f0 - normalized central frequensies vector (from [0 1])
% df - normalized bandwidths vector at +- "sigma"-level (from [0 1])
% dur - duration in "sigmas"; for example, 2, 4 or 6

Nf=length(f0); % Number of filters
fb=cell(1, Nf);
for n=1:Nf
   fb{n}=cgau_f(f0(n), df(n), dur);
end