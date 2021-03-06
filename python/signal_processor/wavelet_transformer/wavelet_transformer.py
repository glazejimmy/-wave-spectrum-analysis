import functools

import numpy as np

from python.signal_processor.wavelet_transformer.utils import cgau_fb, firfb_proc


class WaveletTransformer:
    """
    WaveletTransformer is the class for computing wavelet-like transformation for the signal.

    Example of using this class:
        ```
        wt = WaveletTransformer()
        intensity = wt(signal)
        ```
    """

    def __init__(self, signal: np.ndarray, number_of_filters: int = 200, max_c_p_h: int = 6):
        """
        Constructor of the WaveletTransformer
        :param signal: array values of signal
        :param number_of_filters: number of filters (default = 200)
        :param max_c_p_h: maximum frequency in cycles per hour (default = 6)
        """
        self.signal = signal
        self.number_of_filters = number_of_filters
        self.max_c_p_h = max_c_p_h
        self.seconds = 60

    def _compute_f0(self):
        return np.linspace(0.1 / self.seconds, self.max_c_p_h / self.seconds, self.number_of_filters)

    @functools.lru_cache()
    def _compute_filter_bank(self):
        f0 = self._compute_f0()
        df = f0 * 0.25
        return cgau_fb(f0, df, 4)

    @property
    def frequency_scale_cph(self):
        return self._compute_f0() * self.seconds

    def intensity(self, alpha: float = 10 ** -2):
        filter_bank = self._compute_filter_bank()
        intensity = firfb_proc(filter_bank, self.signal)
        intensity_log = 20 * np.log(abs(intensity) + alpha)
        min_intensity_log = np.min(intensity_log)
        if min_intensity_log < 0:
            intensity_log -= min_intensity_log
        return intensity_log

    def energy(self, intensity: np.ndarray, number_of_filters: int) -> np.ndarray:
        energy = np.zeros([number_of_filters, ])
        for e_i in range(number_of_filters):
            energy[e_i] = sum(intensity[e_i])
        max_amplitude = len(self.signal) * 50
        return energy / max_amplitude
