%%------system data-------
    %Fs=100; % what should it be? my time interval is 0.1 but it doesn't work too
    %t=0:299;
    %x=data; % its my signal value
    %%------------------------
    wname = 'morse';
    coefs = cwt(signal,wname);
    freq = scal2frq(x, wname,1/100);
    surf(x,freq,abs(coefs)); shading('interp');
    xlabel('Time'); ylabel('Frequency');
    figure;
    wscalogram('image',coefs,'scales',freq,'ydata',x);
    hold on
    figure;
    plot(freq,coefs)