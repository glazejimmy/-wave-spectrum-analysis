
import numpy as np

from filter1 import filter1


def firfb_proc(fb, x):
    '''
    FIRFB_PROC FIR filterbank signal processing
    :param fb: FIR filterbank cell structure
    :param x: input signal (string)
    :return: matrix of output signals
    '''
    Nf = max(fb.shape)
    l = len(x)
    zetos = np.zeros([Nf, l])
    yy = []
    for i in range(Nf):
        g = fb[i]
        yy.append(np.array(filter1(g, x)))
    return np.array(yy)
