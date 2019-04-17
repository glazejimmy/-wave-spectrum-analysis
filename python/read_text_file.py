import numpy as np


def read_text_file(path):
    with open(path) as file:
        lines = file.readlines()
    time = np.zeros([len(lines)])
    signal = np.zeros([len(lines)])
    for i, x in enumerate(lines):
        x = x.replace('\n', '')
        time[i] = x.split(' ')[0]
        signal[i] = x.split(' ')[1]
    return time, signal
