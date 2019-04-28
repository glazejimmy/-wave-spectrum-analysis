function yy=firfb_proc(fb,x);

% FIRFB_PROC FIR filterbank signal processing
%
% x - input signal (string)
% yy - matrix of output signals
% fb - FIR filterbank cell structure

Nf=max(size(fb));
L=length(x); y=zeros(Nf,L);
for n=1:Nf,
   g=fb{n};
   yy(n,:)=filter1(g,x);
end