import os

import matplotlib.pyplot as plt

from python.constants import DATA_FOLDER
from python.read_text_file import read_text_file
from python.wavelet_transformer.wavelet_transformer import WaveletTransformer

if __name__ == '__main__':
    _, signal = read_text_file(os.path.join(DATA_FOLDER, 'kerch_2019_baranova', 's1', 'left2.txt'))
    w_t = WaveletTransformer()
    intensity = w_t(signal)
    fig, ax = plt.subplots()
    i = ax.imshow(intensity[::-1], cmap='jet')
    fig.colorbar(i)
    plt.show()
