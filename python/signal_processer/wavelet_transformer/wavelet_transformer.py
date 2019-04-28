import functools

import numpy as np

from python.signal_processer.wavelet_transformer.utils import cgau_fb, firfb_proc


class WaveletTransformer:
    def __init__(self, number_of_filters=200, seconds=60, max_cp_h=6):
        self.number_of_filters = number_of_filters
        self.seconds = seconds
        self.max_cp_h = max_cp_h

    def _compute_f0(self):
        return np.linspace(0.1 / self.seconds, self.max_cp_h / self.seconds, self.number_of_filters)

    @functools.lru_cache()
    def _compute_filter_bank(self):
        f0 = self._compute_f0()
        df = f0 * 0.25
        return cgau_fb(f0, df, 4)

    @property
    def frequency_scale_cph(self):
        return self._compute_f0() * self.seconds

    def __call__(self, signal, alpha=10 ** -2):
        filter_bank = self._compute_filter_bank()
        intensity = firfb_proc(filter_bank, signal)
        intensity_log = 20 * np.log(abs(intensity) + alpha)
        min_intensity_log = np.min(intensity_log)
        if min_intensity_log < 0:
            intensity_log -= min_intensity_log
        return intensity_log
