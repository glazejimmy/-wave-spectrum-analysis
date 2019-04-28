clear all
folder =  'C:\Users\atugarev\Google Drive\M_degree\SpectrumAnalysis\data\Kerchenskiy\s_bridg\';
% folder =  'E:\GD\M_degree\SpectrumAnalysis\data\Kerchenskiy\s_bridg\';
save_folder = 'C:\Users\atugarev\Google Drive\M_degree\SpectrumAnalysis\results\Kerchenskiy\';
s = dir(sprintf('%s*.txt',folder));
files = {s.name};
axes_font_size = 20;
label_font_size = 20;
fig = openfig('C:\Users\atugarev\Google Drive\M_degree\SpectrumAnalysis\results\Kerchenskiy\template.fig');
% fig = openfig('E:\GD\M_degree\SpectrumAnalysis\results\Kerchenskiy\template.fig');
allAxesInFigure = findall(gcf,'type','axes');
for file_i = 1:length(files)

    filename = sprintf('%s%s',folder,files{file_i});
    A = dlmread(filename);
    
    signal = A(:,2);
    timeScale_min = A(:,1)/60;
  
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
    if (file_i == 2)
        H = allAxesInFigure(2);
    else
        H = allAxesInFigure(4);
    end
    imagesc(H, timeScale_min, frequencyScale_cph, intensity_log - min_intensity_log), c = colorbar(H, 'vert'), colormap(H, 'jet')
    
    c.Position = [H.Position(1)+H.Position(3)+ 0.0051, H.Position(2), 0.008, H.Position(4)];
    
    set(H, 'XLim', [min(timeScale_min), max(timeScale_min)], 'YDir', 'normal', 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
    set(H,'FontSize', axes_font_size, 'FontName', 'Times');
    if (file_i ~= 2)
        ylabel(H, 'f, cycle/h', 'FontSize', label_font_size, 'FontName','Times');
        xlabel(H, 'a)', 'FontSize', label_font_size, 'FontName', 'Times');
    else
         xlabel(H, 'c)', 'FontSize', label_font_size, 'FontName', 'Times');
    end
    set(H, 'Xtick',0:100:600,'XTickLabel',{'0', '100', '200', '300', '400', 't, min', '600'})
    if file_i == 2
        set(H, 'Ytick',0:2:8,'YTickLabel',{'', '', '', '', '', '', '', ''})
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ------- %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% energy %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    energy = zeros(1, filterQ);
    for i = 1:length(energy)
        for j = 1:length(signal)
            energy(i) = energy(i) + 20*log10( abs( intensity(i, j) + 0.1 ) ) + 20; % abs(yy(i, j))^2;
        end
    end
    maxAmplitude = length(signal) * 50;
    if (file_i == 2)
        H = allAxesInFigure(1);
    else
        H = allAxesInFigure(3);
    end
    plot(H, energy / maxAmplitude, frequencyScale_cph, 'LineWidth', 3, 'DisplayName', 'data 1', 'Color', [0 0 0]);
    set(H, 'XLim', [0 1]);
    set(H,'FontSize', axes_font_size, 'FontName', 'Times');
    if (file_i ~= 2)
        ylabel(H, 'f, cycle/h', 'FontSize', label_font_size, 'FontName','Times');
        xlabel(H, 'b)', 'FontSize', label_font_size, 'FontName', 'Times');
    else
        xlabel(H, 'd)', 'FontSize', label_font_size, 'FontName', 'Times');
    end
    ylim(H, [alpha, max(frequencyScale_cph)]);
    if file_i == 2
        set(H, 'Ytick',0:2:8,'YTickLabel',{'', '', '', '', '', '', '', ''})
    end
    set(H,'XTick',[0:0.2:1], 'YTick',[0:2:6])
    grid(H,'on')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ----- %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    clear signal signal2 
end