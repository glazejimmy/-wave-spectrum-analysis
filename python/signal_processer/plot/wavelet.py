import matplotlib.pyplot as plt


def plot_wavelet(intensity, min_t=0, max_t=1, min_f=0, max_f=1):
    fig, ax = plt.subplots()
    i = ax.imshow(intensity,
                  extent=[min_t, max_t, min_f, max_f],
                  aspect=20,
                  cmap='jet')
    fig.colorbar(i, fraction=0.019, pad=0.04)
    ax.set_ylabel('f, cycle/h')
    ax.set_xlabel('t, min')
    return fig
