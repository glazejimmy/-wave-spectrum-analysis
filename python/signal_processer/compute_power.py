import numpy as np


def compute_power(time_scale_min, signal, covolve=True):
    signal2 = np.square(signal)
    if not covolve:
        return signal2
    window_length = len(signal)
    power = np.convolve(signal2, np.hamming(window_length) / sum(time_scale_min))
    return power[int((window_length - 1) / 2): int(len(power) - (window_length - 1) / 2)]
