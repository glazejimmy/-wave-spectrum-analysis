function x=filter1(g,u);

%Normal filtering
%u - signal
%g - impulse response
%x=filter1(g,u);

ii=length(u);
L=length(g); 
m=floor(L/2);
y=[u(ones(1,m)) u u(ii*ones(1,m))];
y=conv(g,y);
x=y(L:L+ii-1);
   