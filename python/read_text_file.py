from pathlib import Path
from typing import Tuple

import numpy as np


def read_text_file(path: Path) -> Tuple[np.ndarray, np.ndarray]:
    with open(path) as file:
        lines = file.readlines()
    time: np.ndarray = np.zeros([len(lines)])
    signal: np.ndarray = np.zeros([len(lines)])
    for i, x in enumerate(lines):
        x: str = x.replace('\n', '')
        time[i] = x.split(' ')[0]
        signal[i] = x.split(' ')[1]
    return time, signal
