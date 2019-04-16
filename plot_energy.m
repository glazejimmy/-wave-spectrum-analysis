function plot_energy(X, Y, alpha, label_font_size, axes_font_size)

fig = figure();
axes1 = axes('Parent', fig,...
    'YAxisLocation', 'right',...
    'FontSize', axes_font_size,...
    'FontName', 'Times',...
    'XGrid', 'on', 'YGrid', 'on');
%     'XTickLabel', {'0','1'},...
%     'XTick', [0 1],...

xlim(axes1,[0 1]);
xlabel('normalized energy spectrum', 'FontSize', label_font_size, 'FontName', 'Times');
ylim(axes1,[alpha, 8]);
ylabel('f, cycle/h', 'FontSize', label_font_size, 'FontName','Times');

box(axes1, 'on');
hold(axes1, 'all');

plot(X, Y, 'LineWidth', 3, 'DisplayName', 'data 1', 'Color', [0 0 0]);

