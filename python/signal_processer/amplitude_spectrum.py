import numpy as np


def compute_amplitude(signal):
    ps = np.abs(np.fft.fft(signal)) ** 2
    time_step = 1 / 30
    frequencies = np.fft.fftfreq(signal.size, time_step)
    idx = np.argsort(frequencies)
    return frequencies[idx], ps[idx]
