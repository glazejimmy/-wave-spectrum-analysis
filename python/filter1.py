import numpy as np


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
