%%%%%%%%%%%%%%%%%%%%%%%%%%%% data load %%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
folder =  'C:\Users\atugarev\Google Drive\M_degree\SpectrumAnalysis\data\Kerchenskiy\h_1\';
save_folder = 'C:\Users\atugarev\Google Drive\M_degree\SpectrumAnalysis\results\Kerchenskiy\';
% old_folder = cd(dir);
s = dir(sprintf('%s*.txt',folder));
files = {s.name};

% name_mar = {'Glazovka.txt', 'Ilyich.txt', 'LeftBridge7.txt', 'LeftBridge8.txt', 'PanagiaCape.txt', 'RightBridge.txt', 'TuzlaLake.txt', 'Zavetnoye.txt'};
% number_mar = [11, 15, 7, 8, 23, 20, 22, 2];
% name_num_map = containers.Map(name_mar, number_mar);

drawMareogramm = 0;
drawWavelet = 1;
drawPower = 0;
drawEnergy = 0;

for file_i = 1:length(files)

    filename = sprintf('%s%s',folder,files{file_i});
    A = dlmread(filename);
    
    signal = A(:,2);
    timeScale_min = A(:,1)/60;
    
    if drawMareogramm
        plot_mareogramm(timeScale_min, signal, 40, 34);
        print('-dtiff','-r300',sprintf('%s%s_mareogram.tiff',save_folder, files{file_i}(1:length(files{file_i})-4)));
        close
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%% ---------- %%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% power %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    windowLength = 301;
    signal2 = signal .^ 2;
    iPower = conv(signal2, hamming(windowLength)/sum(timeScale_min));
    iPower = iPower( (windowLength-1)/2+1 : length(iPower)-(windowLength-1)/2 );
    if drawPower
        plot_iPower(timeScale_min, iPower, 40, 34);
        print('-dtiff','-r300',sprintf('%s%s_power.tiff',save_folder, files{file_i}(1:length(files{file_i})-4)));
        close
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ------- %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%% wavelet %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Число фильтров в банке
    filterQ = 200;
    % Максимальная частота
    maxCpH = 8;
    m = 3660;
    % Распределение частот: от 0 до N циклов в час
    f0 = linspace(0.1 / m, maxCpH / m, filterQ);
    % Полосы пропускания фильтров: для всех - четверть центральной частоты
    df = 0.25 * f0;
    % Расчёт фильтрбанка
    filterBank = cgau_fb(f0, df, 4);
    
    % frequencyScale_cph = 3600 * ((f0 / dt) / 2);
    frequencyScale_cph = m * f0;
    intensity = firfb_proc(filterBank, signal');
    if drawWavelet
        plot_wavelet(timeScale_min, frequencyScale_cph, intensity, 0.01, 40, 34);
        print('-dtiff','-r300',sprintf('%s%s_wavelet.tiff',save_folder, files{file_i}(1:length(files{file_i})-4)));
        close
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
        print('-dtiff','-r300',sprintf('%s%s_energy.tiff',save_folder, files{file_i}(1:length(files{file_i})-4)));
        close
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ----- %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    clear signal signal2 
end