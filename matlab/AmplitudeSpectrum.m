clear all;
clc;
T = 20;
fb = T;
dt = 20; % interval 
first_mar = 2;
second_mar = 7;
folder =  'C:\Users\atugarev\Google Drive\Masters\SpectrumAnalysis\data\Kerchenskiy\';
filename = sprintf('%s%dm.txt',folder,first_mar);
A = dlmread(filename);
x = A(:,1)/60;
pData = zeros(length(x), 2);
pData(:,1) = A(:,2);
filename = sprintf('%s%dm.txt',folder,second_mar);
A = dlmread(filename);
pData(:,2) = A(:,2);
figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:2
    FftL = length(pData(:,i));
    FftS = abs(fft(pData(:,i),length(pData(:,i))));
    Fd = 1024;
    F=0:Fd/FftL:Fd/2-1/FftL;
    m = 12;
    ii = F(1):0.001:F(m);
    yy = interp1(F(1:m),FftS(1:m),ii, 'spline');
    plot(ii,yy,'Linewidth',2);
    hold on
end
H = gca;
legend({sprintf('%d mar',first_mar), sprintf('%d mar',second_mar)})
H.XLim = [0 6];
H.FontSize = 25;

grid on
hold off

