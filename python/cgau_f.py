import numpy as np


def cgau_f(f0, df, dur) -> np.ndarray:
    '''
    Impulse response of complex gaussian filter
    :param f0: normalized central frequensy (from [0 1])
    :param df: normalized bandwidth at +- "sigma"-level (from [0 1])
    :param dur: duration in "sigmas"; for example, 2, 4 or 6
    :return: ndarray of an impulse response of complex gaussian filter
    '''
    n0 = np.ceil(dur / (2 * np.pi * df))
    t = np.linspace(-dur / 2, dur / 2, num=2 * n0 + 1)
    t = [-i ** 2 / 2 for i in t]
    g = np.exp(t) * np.exp(1j * np.pi * f0 * np.arange(-n0, n0 + 1));
    g = g / np.linalg.norm(g)
    return g
