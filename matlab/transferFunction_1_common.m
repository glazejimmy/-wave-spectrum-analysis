GoogleDrive_folder = 'D:\GoogleDrive\';
folder =  sprintf('%s%s',GoogleDrive_folder,'M_degree\SpectrumAnalysis\data\Kerchenskiy\');
filename = sprintf('%s%s',folder,'7m.txt');
A = dlmread(filename);
p1Data = A(:,2);
filename = sprintf('%s%s',folder,'8m.txt');
A = dlmread(filename);
p2Data= A(:,2);

p1Data=p1Data-mean(p1Data);
p2Data=p2Data-mean(p2Data);

dt=20;
fft_=80000;
% hzStep=1/(fft_/2);
% hzStep=1/dt/length(p2Data);
% hzStep=1/dt/length(p2Data)*2;
fd = 1/dt;
F = fd/2;
hzStep = 2*F / length(p1Data);
window=1200;
logQ=10;
chMax=8;

% hz=0:hzStep:1;
hz=0:hzStep:2*F;
ch=hz.*3600;
xAxisSize=0;
while ch(xAxisSize+1)<=chMax
    xAxisSize=xAxisSize+1;
end

chPart=ch(1:xAxisSize);

% xxx=dspdata.psd(p1Data);
% avgpower(xxx);
% p1Density=logQ*log10(pwelch(p1Data, hamming(window), window/2, fft_));
% p1Density=logQ*log10( pwelch(p1Data, rectwin(window), 0) );
p1Density = logQ*log10( periodogram(p1Data) );
% [p1Density, f1] = pwelch(p1Data, hamming(window), 0, fft_);
% p1Density = logQ*log10(p1Density);
% p1Density=logQ*log10(pwelch(p1Data));
p1DensityPart = p1Density(1:xAxisSize);

% yyy=dspdata.psd(pB2Data);
% avgpower(yyy);
% pB2Density=logQ*log10(pwelch(pB2Data, hamming(window), window/2, fft_));
% pB2Density=logQ*log10( pwelch(pB2Data, rectwin(window), 0) );
p2Density = logQ*log10( periodogram(p2Data) );
% p2Density=logQ*log10(pwelch(p2Data, hamming(window), 0, fft_));
% pB2Density=logQ*log10(pwelch(pB2Data));
p2DensityPart = p2Density(1:xAxisSize);

figure('Name', 'dst'),plot(chPart, p1DensityPart, 'Color', 'green', 'LineStyle', '--', 'LineWidth', 2);
hold on;
plot(chPart, p2DensityPart, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);
hold off;

TF1 = p1DensityPart - p2DensityPart;
TF2 = p2DensityPart - p1DensityPart;
ii = min(chPart):abs(max(chPart)-min(chPart))/(length(chPart)*100):max(chPart);
TF1_interp = spline(chPart,TF1',ii);
TF2_interp = spline(chPart,TF2',ii);
% figure('Name', 'tf'),plot(chPart, TF1, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);
% hold on 
plot(ii, TF1_interp, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);

H=gca;
grid on;
set(H,'FontSize',22,'FontName','Times');
set(H,'Ydir','normal', 'GridLineStyle', ':');
set(H, 'XLim', [0, 6]);
xlabel('f, cycles/h','FontSize',34,'FontName','Times');
ylabel('magnitude response, dB','FontSize',34,'FontName','Times');