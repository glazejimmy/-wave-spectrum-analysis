# Tsunami Spectrum Analysis (TSA)

This project allows tsunami researchers to build energetic and wave specifications of waves.
The project contains the implementation of the impulse response of the complex Gaussian filter for building wavelet-like 
transformation and specifications built on this transform.

For building wavelet-like transformation for your signal you should create the instance of `WaveletTransformer`:
```py

from python.signal_processer.wavelet_transformer.wavelet_transformer import WaveletTransformer

w_t = WaveletTransformer()
```


