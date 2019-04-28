clear all;
GoogleDrive_folder = 'D:\GoogleDrive\';
folder =  sprintf('%s%s',GoogleDrive_folder,'M_degree\SpectrumAnalysis\data\Kerchenskiy\');
save_folder = sprintf('%s%s',GoogleDrive_folder,'M_degree\SpectrumAnalysis\results\Kerchenskiy\fullSet\');
s = dir(sprintf('%s*.txt',folder));
files = {s.name};
fig = openfig(sprintf('%s%s',GoogleDrive_folder,'M_degree\SpectrumAnalysis\scripts\figures\energy_analisys.fig'));
allAxesInFigure = findall(gcf,'type','axes');
colorbr_limits = [0 60.862872638972050];
label_font_size = 24;
axes_font_size = 22;
for file_i = 1:length(files)
    %%%%%%%%%%%%%%%%%%%%%%%%%%% mareogramm %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    filename = sprintf('%s%s',folder,files{file_i});
    A = dlmread(filename);
    
    signal = A(:,2);
    timeScale_min = A(:,1)/60;
    H = allAxesInFigure(3); 
    plot(H, timeScale_min, signal, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);

    set(H, 'Xlim', [0 max(timeScale_min)], 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
    set(H,'FontSize', axes_font_size, 'FontName', 'Times');
    ylabel(H, 'amplitude, m', 'FontSize', label_font_size, 'FontName', 'Times');
    set(H, 'Xtick',0:100:max(timeScale_min),'XTickLabel',{'0', '100', '200', '300', '400', 't, min', '600'})
    %%%%%%%%%%%%%%%%%%%%%%%%%%% wavelet %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    filterQ = 200;
    maxCpH = 6;
    m = 60;
    f0 = linspace(0.1 / m, maxCpH / m, filterQ);
    df = 0.25 * f0;
    filterBank = cgau_fb(f0, df, 4);
    
    frequencyScale_cph = m * f0;
    intensity = firfb_proc(filterBank, signal');
    alpha = 0.01;
    intensity_log = 20 * log10( abs(intensity)+alpha );
    min_intensity_log = 0;
    if (min(min(intensity_log))<0)
        min_intensity_log = min(min(intensity_log));
    end
    H = allAxesInFigure(4);

    imagesc(H, timeScale_min, frequencyScale_cph, intensity_log - min_intensity_log);
   
    set(H, 'XLim', [min(timeScale_min), max(timeScale_min)], 'YDir', 'normal', 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
    set(H,'FontSize', axes_font_size, 'FontName', 'Times');
    ylabel(H, 'f, cycle/h', 'FontSize', label_font_size, 'FontName', 'Times');
    set(H, 'Xtick',0:100:max(timeScale_min),'XTickLabel',{'0', '100', '200', '300', '400', 't, min', '600'})
    H.CLim =[0 60.862872638972050];
    c = colorbar(H, 'vert'); colormap(H, 'jet');
    c.Position = [H.Position(1)+H.Position(3)+ 0.0051, H.Position(2), 0.008, H.Position(4)];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%% energy %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    energy = zeros(1, filterQ);
    for i = 1:length(energy)
        for j = 1:length(signal)
            energy(i) = energy(i) + 20*log10( abs( intensity(i, j) + 0.1 ) ) + 20; % abs(yy(i, j))^2;
        end
    end
    H = allAxesInFigure(2);
    maxAmplitude = length(signal) * 50;
    plot(H, energy / maxAmplitude, frequencyScale_cph, 'LineWidth', 2, 'DisplayName', 'data 1', 'Color', [0 0 0]);
    set(H, 'XLim', [0 1]);
    set(H,'FontSize', axes_font_size, 'FontName', 'Times');
    ylabel(H, 'f, cycle/h', 'FontSize', label_font_size, 'FontName','Times');
    ylim(H, [alpha, max(frequencyScale_cph)]);
    set(H, 'YAxisLocation', 'right');
    set(H,'XTick',[0:0.2:1],'XTickLabel',{'0', '0.2', 'normalized' 'energy' 'spectrum', '1'}) 
    set(H,'YTick',[0:2:6])
    grid(H,'on')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% power %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    H = allAxesInFigure(1);
    
    windowLength = 301;
    signal2 = signal .^ 2;
    iPower = conv(signal2, hamming(windowLength)/sum(timeScale_min));
    iPower = iPower( (windowLength-1)/2+1 : length(iPower)-(windowLength-1)/2 );
    plot(H,timeScale_min, iPower, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);
    set(H, 'Xlim', [0 max(timeScale_min)], 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
    set(H,'FontSize', axes_font_size, 'FontName', 'Times');
    ylabel(H, 'amplitude, m^2', 'FontSize', label_font_size, 'FontName', 'Times');
    set(H, 'YAxisLocation', 'right');
    set(H, 'Xtick',0:100:max(timeScale_min),'XTickLabel',{'0', '100', '200', '300', '400', 't, min', '600'})
   
    clear signal signal2 
    print('-dtiff','-r300',sprintf('%s%s.tiff',save_folder, files{file_i}(1:length(files{file_i})-4)));
%     close
end