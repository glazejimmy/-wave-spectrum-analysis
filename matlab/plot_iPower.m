function plot_iPower(X, Y, label_font_size, axes_font_size)

figure('units','normalized','outerposition',[0 0 1 1]);
plot(X, Y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);

H=gca;
set(H, 'XLim', [0, max(X)], 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':');
set(H, 'FontSize', axes_font_size, 'FontName', 'Times');
xlabel('t, min', 'FontSize', 40, 'FontName', 'Times');
ylabel('amplitude, m^2', 'FontSize', label_font_size, 'FontName', 'Times');