# Line Codes in Digital Communication
Line codes is the way of representing a digital signal using voltage or current waveform forms. They can be represented using binary signaling or multi-level signaling. Binary bits (0’s and 1’s) in A/D conversion are represented using several serial-bit signaling schemes.

## Line Codes Schemes
Almost all schemes are categorized into:
- Return-to-zero (RZ): When converting the digital signal to a positive or negative waveform period, the wave stays for a while but not for the whole bit duration because it return to zero.
- Non-return-to-zero (NRZ): the bit takes up its whole duration.

## Power Spectral Density (PSD)
Digital signals they are random data which are non-deterministic, so we can’t take its Fourier transform. So in time domain we find its auto correlation function (the correlation of the signal with itself). We then can find the power spectral density (PSD) by taking the correlation function’s Fourier transform, which is a frequency domain representation.

## Line Codes Implemented and Discussed in the Report
- Polar NRZ
- Inverted Polar NRZ
- Polar RZ
- Bipolar NRZ
- Bipolar RZ
- Manchester

## Other Line Codes Discussed in the Report
- Biphase Mark Code
- Unipolar NRZ


# Outputs
![line_codes_signals](https://github.com/user-attachments/assets/d8b85f88-a0e6-4154-a3a8-f3910b375e36)
![line_codes_psd](https://github.com/user-attachments/assets/4580286d-9d5d-4075-aade-842aac38adc3)
