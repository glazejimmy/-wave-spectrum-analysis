strait_points='../data/Крузенштерн/strait_all.xls';
circle_points='../data/Крузенштерн/circles_all.xls';

pInData = xlsread(circle_points, 'p1:p34960');
pOut1Data = xlsread(circle_points, 'q1:q34960');
pOut2Data = xlsread(circle_points, 's1:s34960');
pOut3Data = xlsread(circle_points, 'u1:u34960');

pInData = pInData - mean(pInData);
pOut1Data = pOut1Data - mean(pOut1Data);
pOut2Data = pOut2Data - mean(pOut2Data);
pOut3Data = pOut3Data - mean(pOut3Data);

dt = 0.5;
fft_ = 80000;
% hzStep=1/(fft_/2);
% hzStep=1/dt/length(p2Data);
% hzStep=1/dt/length(p2Data)*2;
fd = 1/dt;
F = fd/2;
hzStep = 2*F / length(pInData);
window = 1200;
logQ = 10;
chMax = 8;

% hz=0:hzStep:1;
hz = 0:hzStep:2*F;
ch = hz.*3600;
xAxisSize = 0;
while ch(xAxisSize+1) <= chMax
    xAxisSize = xAxisSize+1;
end

chPart = ch(1:xAxisSize);

pInDensity = logQ*log10( periodogram(pInData) );
pInDensityPart = pInDensity(1:xAxisSize);

pOut1Density = logQ*log10( periodogram(pOut1Data) );
pOut1DensityPart = pOut1Density(1:xAxisSize);

pOut2Density = logQ*log10( periodogram(pOut2Data) );
pOut2DensityPart = pOut2Density(1:xAxisSize);

pOut3Density = logQ*log10( periodogram(pOut3Data) );
pOut3DensityPart = pOut3Density(1:xAxisSize);

% figure('Name', 'dst'),plot(chPart, pInDensityPart, 'Color', 'green', 'LineStyle', '--', 'LineWidth', 2);
% hold on;
% plot(chPart, pOut1DensityPart, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);
% plot(chPart, pOut2DensityPart, 'Color', 'yellow', 'LineStyle', '--', 'LineWidth', 2);
% plot(chPart, pOut3DensityPart, 'Color', 'blue', 'LineStyle', '--', 'LineWidth', 2);
% hold off;

TF1 = pOut1DensityPart - pInDensityPart;
TF2 = pOut2DensityPart - pInDensityPart;
TF3 = pOut3DensityPart - pInDensityPart;

figure('Name', 'tf'),plot(chPart, TF1, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);
hold on;
plot(chPart, TF2, 'Color', 'black', 'LineStyle', ':', 'LineWidth', 2);
plot(chPart, TF3, 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
hold off;

H=gca;
grid on;
set(H,'FontSize',22,'FontName','Times');
set(H,'Ydir','normal', 'GridLineStyle', ':');
xlabel('f, cycles/h','FontSize',34,'FontName','Times');
ylabel('intensity, dB','FontSize',34,'FontName','Times');