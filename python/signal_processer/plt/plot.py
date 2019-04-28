def plot_mareogramm(time, signal, ax):
    plot(time, signal, ax)
    ax.set_ylabel('amplitude, m')
    ax.set_xlabel('t, min')


def plot_wavelet(intensity, time, frequency_scale_cph, ax):
    i = ax.imshow(intensity,
                  extent=[min(time), max(time),
                          min(frequency_scale_cph), max(frequency_scale_cph)],
                  aspect='auto',
                  cmap='jet')
    ax.figure.colorbar(i, ax=ax, fraction=0.019, pad=0.04)
    ax.set_ylabel('f, cycle/h')
    ax.set_xlabel('t, min')


def plot_energy(frequency_scale_cph, energy, ax):
    plot(energy, frequency_scale_cph, ax)
    ax.set_ylabel('f, cycle/h')
    ax.set_xlabel('normalized energy spectrum')
    ax.tick_params(axis='y', which='both', labelleft=False, labelright=True)
    ax.yaxis.set_label_position('right')


def plot_power(frequency_scale_cph, power, ax):
    plot(frequency_scale_cph, power, ax)
    ax.set_ylabel('amplitude, m^2', )
    ax.set_xlabel('t, min')
    ax.tick_params(axis='y', which='both', labelleft=False, labelright=True)
    ax.yaxis.set_label_position('right')
    ax.ticklabel_format(style='sci', axis='y', scilimits=(0, 0))


def plot(x, y, ax):
    ax.plot(x, y)
    one_percent_value = (max(y) - min(y)) / 100
    ax.axis([min(x), max(x),
             min(y) - one_percent_value, max(y) + one_percent_value])
    ax.grid(True)


def set_size(w, h, ax):
    """ w, h: width, height in inches """
    l = ax.figure.subplotpars.left
    r = ax.figure.subplotpars.right
    t = ax.figure.subplotpars.top
    b = ax.figure.subplotpars.bottom
    figw = float(w) / (r - l)
    figh = float(h) / (t - b)
    ax.figure.set_size_inches(figw, figh)
