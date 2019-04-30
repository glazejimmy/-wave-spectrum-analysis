import glob
import os

import matplotlib.pyplot as plt

from python.constants import DATA_FOLDER
from python.read_text_file import read_text_file
from python.signal_processer import compute_energy, compute_power
from python.signal_processer.amplitude_spectrum import compute_amplitude
from python.signal_processer.plt import plot_wavelet, plot_mareogramm, plot_energy
from python.signal_processer.plt.plot import plot_power, set_size

from python.signal_processer.wavelet_transformer.wavelet_transformer import WaveletTransformer

if __name__ == '__main__':
    current_data_folder = os.path.join(DATA_FOLDER, 'kerch_2019_baranova')
    for filename in glob.iglob('{}/**/*.txt'.format(current_data_folder), recursive=True):
        time, signal = read_text_file(filename)
        w_t = WaveletTransformer()
        frequency_scale_cph = w_t.frequency_scale_cph

        # intensity = w_t(signal)

        # fig, ax = plt.subplots(nrows=2, ncols=2)

        # energy = compute_energy(signal, intensity, w_t.number_of_filters)
        # power = compute_power(time / 60, signal)
        # plot_mareogramm(time, signal, ax[0][0])
        # plot_power(time, power, ax[0][1])
        # plot_wavelet(intensity[::-1], time, frequency_scale_cph, ax[1][0])
        # plot_energy(frequency_scale_cph, energy, ax[1][1])
        # set_size(7, 3, ax[0][1])
        # plt.savefig(os.path.splitext(filename)[0] + '.png')
        # plt.show()
        a_s = compute_amplitude(signal)

        plt.plot(a_s[0], a_s[1])
        plt.show()
