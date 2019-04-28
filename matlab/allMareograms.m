clear all
GoogleDrive_folder = 'D:\GoogleDrive\';
folder =  'M_degree\SpectrumAnalysis\data\Kerchenskiy\';
mariograms = ['2m', 'c', 'e', 'o'];
j = 0;
figure
time = xlsread(sprintf('%s\\V2\\19012007_212827.xls', folder), 'a1:a2401')/(60);
for i=1:length(mariograms)
    sprintf('%s1:%s2401',mariograms(i),mariograms(i))
    first =  xlsread(sprintf('%s\\V2\\19012007_212827.xls', folder), sprintf('%s1:%s2401',mariograms(i),mariograms(i)));
    subplot(4,2,i+j);
    plot(time, first, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 1);

    H=gca;
    set(H, 'Xlim', [0 max(time)], 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
    set(H,'FontSize', 10, 'FontName', 'Times');
    xlabel('t, min', 'FontSize', 10, 'FontName', 'Times');
    ylabel('amplitude, m', 'FontSize', 10, 'FontName', 'Times');
    
    second =  xlsread(sprintf('%s\\V3\\22012007_165211.xls', folder), sprintf('%s1:%s2401',mariograms(i),mariograms(i)));
    subplot(4,2,i+j+1);
    plot(time, second, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 1);

    H=gca;
    set(H, 'Xlim', [0 max(time)], 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
    set(H,'FontSize', 10, 'FontName', 'Times');
    xlabel('t, min', 'FontSize', 10, 'FontName', 'Times');
    ylabel('amplitude, m', 'FontSize', 10, 'FontName', 'Times');
    j = j+1;
end

