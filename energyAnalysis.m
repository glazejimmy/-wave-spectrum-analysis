%%%%%%%%%%%%%%%%%%%%%%%%%%%% data load %%%%%%%%%%%%%%%%%%%%%%%%%%
% filename = '../data/Буссоль/strait_all.xls';
% filename = 'C:\Users\Alexandr\Desktop\data.xls';
filename = '../data/Буссоль/circles_all.xls';
% filename = '../data/Индийский/Индийский.xls';
% signal = load(filename);
% signal = xlsread(filename, 'p1:p34960');
signal = xlsread(filename, 'b1:b34800');
% signal = xlsread(filename, 'p1:p2401');
% signal = xlsread(filename, 'o24150:o31700');
% signal = p2Data_int';
%%%%%%%%%%%%%%%%%%%%%%%%%%%% --------- %%%%%%%%%%%%%%%%%%%%%%%%%%

calcMareogramm = 1;
calcWavelet = 1;
calcPower = 1;
calcEnergy = 1;

drawMareogramm = 1;
drawWavelet = 1;
drawPower = 0;
drawEnergy = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% defines %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dt = 20;
dt = 0.47715779549155738407474072169367;
timeScale_min = dt * (0:1:length(signal)-1) / 60;
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ------- %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% mareogramm %%%%%%%%%%%%%%%%%%%%%%%%%%%
if drawMareogramm
    plot_mareogramm(timeScale_min, signal, 40, 34);
end
%%%%%%%%%%%%%%%%%%%%%%%%%% ---------- %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% power %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
windowLength = 301;
signal2 = signal .^ 2;
iPower = conv(signal2, hamming(windowLength)/sum(timeScale_min));
iPower = iPower( (windowLength-1)/2+1 : length(iPower)-(windowLength-1)/2 );
if drawPower
    plot_iPower(timeScale_min, iPower, 40, 34);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ------- %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% wavelet %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Число фильтров в банке
filterQ = 200;
% Максимальная частота
maxCpH = 8;
% Распределение частот: от 0 до N циклов в час
f0 = linspace(0.1 / 3600, maxCpH / 3600, filterQ);
% Полосы пропускания фильтров: для всех - четверть центральной частоты
df = 0.25 * f0;
% Расчёт фильтрбанка
filterBank = cgau_fb(f0, df, 4);

% frequencyScale_cph = 3600 * ((f0 / dt) / 2);
frequencyScale_cph = 3600 * f0;
intensity = firfb_proc(filterBank, signal');

if drawWavelet
    plot_wavelet(timeScale_min, frequencyScale_cph, intensity, 0.1, 40, 34);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ------- %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% energy %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% frequencyScale_period = 60 / cph;
energy = zeros(1, filterQ);
for i = 1:length(energy)
    for j = 1:length(signal)
        energy(i) = energy(i) + 20*log10( abs( intensity(i, j) + 0.1 ) ) + 20; % abs(yy(i, j))^2;
    end
end
maxAmplitude = length(signal) * 50;

if drawEnergy
    plot_energy(energy / maxAmplitude, frequencyScale_cph, 0.1, 40, 34);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ----- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%