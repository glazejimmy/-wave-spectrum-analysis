function plot_mareogramm(X, Y, label_font_size, axes_font_size)

figure,plot(X, Y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);

H=gca;
set(H, 'Xlim', [0 max(X)], 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
set(H,'FontSize', axes_font_size, 'FontName', 'Times');
xlabel('t, min', 'FontSize', label_font_size, 'FontName', 'Times');
ylabel('amplitude, m', 'FontSize', label_font_size, 'FontName', 'Times');