function plot_wavelet(timeScale, frequencyScale, intensity, alpha, label_font_size, axes_font_size)

%%% scaleogramm based on FIR filterbank outputs %%%
% x - input signal (string)
% z - matrix of output signals
% timeScale - time scale cutoff
% dt - sampling interval, s.
% alpha - regularization value
%%% ------------------------------------------- %%%

% belive this %
% figure,imagesc(timeScale, frequencyScale, 20 * log10( abs(intensity)+alpha ) + 20), colorbar('vert'),
%%%%%%%%%%
figure,imagesc(timeScale, frequencyScale, 20 * log10( abs(intensity)+alpha )), colorbar('vert'),

H=gca;
set(H, 'XLim', [min(timeScale), max(timeScale)], 'YDir', 'normal', 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', ':', 'YScale', 'linear');
set(H,'FontSize', axes_font_size, 'FontName', 'Times');
xlabel('t, min', 'FontSize', label_font_size, 'FontName', 'Times');
ylabel('f, cycle/h', 'FontSize', label_font_size, 'FontName','Times');