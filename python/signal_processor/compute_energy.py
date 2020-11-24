import numpy as np


def compute_energy(signal, intensity, number_of_filters):
    energy = np.zeros([number_of_filters, ])
    for e_i in range(number_of_filters):
        for s_i in range(number_of_filters):
            energy[e_i] += intensity[e_i][s_i]
    max_amplitude = len(signal) * 50
    return energy / max_amplitude
