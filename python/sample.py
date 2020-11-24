import glob
import os

import matplotlib.pyplot as plt
import numpy as np

from python.constants import DATA_FOLDER
from python.read_text_file import read_text_file
from python.signal_processor import compute_energy, compute_power
from python.signal_processor.plt import plot_wavelet, plot_mareogramm, plot_energy
from python.signal_processor.plt.plot import plot_power, set_size

from python.signal_processor.wavelet_transformer.wavelet_transformer import WaveletTransformer

if __name__ == '__main__':

    for filename in DATA_FOLDER.glob('**/*.txt'):
        time, signal = read_text_file(filename)
        w_t = WaveletTransformer(signal)

        intensity: np.ndarray = w_t.intensity()
        energy = compute_energy(signal, intensity, w_t.number_of_filters)
        power = compute_power(w_t.frequency_scale_cph, signal)

        fig, ax = plt.subplots(nrows=2, ncols=2)
        plot_mareogramm(time, signal, ax[0][0])
        plot_power(time, power, ax[0][1])
        plot_wavelet(intensity[::-1], time, w_t.frequency_scale_cph, ax[1][0])
        plot_energy(w_t.frequency_scale_cph, energy, ax[1][1])
        set_size(7, 3, ax[0][1])
        plt.savefig(os.path.splitext(filename)[0] + '.png')
        plt.show()
