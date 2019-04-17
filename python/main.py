import numpy as np
import matplotlib.pyplot as plt

import read_text_file
from cgau_fb import cgau_fb
from firfb_proc import firfb_proc

if __name__ == '__main__':
    time, signal = read_text_file.read_text_file('C:\Developer\SpectrumAnalysis\data\kerch_2019_baranova\s1\\right1.txt')
    seconds = 3600
    filterQ = 200
    maxCpH = 8
    f0 = np.linspace(0.1 / seconds, maxCpH / seconds, filterQ)
    df = 0.25 * f0
    filterBank = cgau_fb(f0, df, 4)
    frequencyScale_cph = seconds * f0
    intensity = firfb_proc(filterBank, signal)
    plt.imshow(intensity)
