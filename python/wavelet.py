import os

import matplotlib.pyplot as plt

from python.constants import DATA_FOLDER
from python.read_text_file import read_text_file
from python.signal_processer.plot.wavelet import plot_wavelet
from python.signal_processer.wavelet_transformer.wavelet_transformer import WaveletTransformer

if __name__ == '__main__':
    time, signal = read_text_file(os.path.join(DATA_FOLDER, 'kerch_2019_baranova', 's1', 'right1.txt'))
    w_t = WaveletTransformer()
    frequency_scale_cph = w_t.frequency_scale_cph

    intensity = w_t(signal)
    fig = plot_wavelet(intensity[::-1],
                       min_t=time[0] / 60, max_t=time[-1],
                       min_f=frequency_scale_cph[0], max_f=frequency_scale_cph[-1])

    plt.savefig(os.path.join(DATA_FOLDER, 'kerch_2019_baranova', 's1', 'right1.png'))
