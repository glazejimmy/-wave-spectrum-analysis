import numpy as np


def cgau_f(f0, df, dur) -> np.ndarray:
    """
    Impulse response of complex gaussian filter
    :param f0: normalized central frequensy (from [0 1])
    :param df: normalized bandwidth at +- "sigma"-level (from [0 1])
    :param dur: duration in "sigmas"; for example, 2, 4 or 6
    :return: ndarray of an impulse response of complex gaussian filter
    """
    n0 = np.ceil(dur / (2 * np.pi * df))
    t = np.linspace(-dur / 2, dur / 2, num=int(2 * n0 + 1))
    t = [-i ** 2 / 2 for i in t]
    g = np.exp(t) * np.exp(1j * np.pi * f0 * np.arange(-n0, n0 + 1))
    g = g / np.linalg.norm(g)
    return g


def cgau_fb(f0, df, dur) -> np.ndarray:
    '''
    CGAU_FB Complex gaussian filterbank
    :param f0: normalized central frequencies vector (from [0 1])
    :param df: normalized bandwidths vector at +- "sigma"-level (from [0 1])
    :param dur: duration in "sigmas"; for example, 2, 4 or 6
    :return:
    '''
    res = []
    for i in range(len(f0)):
        res.append(cgau_f(f0[i], df[i], dur))
    return np.array(res)


def filter1(g, u):
    '''
    Normal filtering
    :param g: impulse
    :param u: signal
    :return:
    '''
    ii = len(u)
    l = len(g)
    m = int(np.floor(l / 2))
    start = np.array([u[0] for _ in range(m)])
    end = np.array([u[-1] for _ in range(m)])
    y = np.concatenate((start, u, end))
    y = np.convolve(g, y)
    return y[l - 1:l + ii - 1]


def firfb_proc(fb, x):
    '''
    FIRFB_PROC FIR filterbank signal processing
    :param fb: FIR filterbank cell structure
    :param x: input signal (string)
    :return: matrix of output signals
    '''
    Nf = max(fb.shape)
    l = len(x)
    yy = []
    for i in range(Nf):
        g = fb[i]
        yy.append(np.array(filter1(g, x)))
    return np.array(yy)
