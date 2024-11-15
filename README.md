Ready to use toolkit for design and visualization of modulation and demodulation processes OFDM signals. Analysis BER for various conditions. Completed during a training laboratory at the University.

LAB 1 Description 
### Lab Work №1
**"Noise Immunity of OFDM Signal Reception in AWGN Channels and Fading Channels"**

#### Implementation Requirements:
1. OFDM modulator
2. OFDM demodulator
3. AWGN channel
4. Fading channel (EPA/EVA/ETU models)
5. Equalizer
6. Time guard interval (zero padding and cyclic prefix)

#### Research Objectives:
1. Analyze the noise immunity of OFDM signal reception in an AWGN channel for varying numbers of data subcarriers.
2. Evaluate the noise immunity of OFDM signal reception in a fading channel (with maximum Doppler shift of 0 Hz) using a receiver equalizer without a time guard interval, for different pilot subcarrier spacings.
3. Investigate the noise immunity of OFDM signal reception in a fading channel (with maximum Doppler shift of 0 Hz) using a receiver equalizer for various time guard intervals (zero padding and cyclic prefix).
4. Study the noise immunity of OFDM signal reception in a fading channel (with maximum Doppler shift of 0 Hz) using a receiver equalizer for different lengths of the cyclic prefix.
5. Assess the noise immunity of OFDM signal reception in a fading channel using a receiver equalizer for different values of maximum Doppler shift with a fixed cyclic prefix length.

#### Additional Instructions:
- **General Parameters**:
  - Data modulation: 16-QAM
  - Pilot modulation: 4-QAM
  - FFT size: 2048
  - OFDM symbol duration: 100 µs
  - Relative guard interval length: from 0 to 1/4

This document outlines the tasks to be implemented for simulating and analyzing OFDM signal reception in various channel conditions, focusing on noise immunity and the impact of equalization techniques.


LAB 2 Description 
### Lab Work №2
**"Time and Frequency Synchronization of OFDM Signals in AWGN Channels"**

#### Implementation Requirements:
1. Time shift
2. Frequency shift
3. Time synchronization algorithm using cyclic prefix
4. Time synchronization algorithm based on symbols with periodic repetitions (Minn's algorithm)
5. Frequency synchronization algorithm using cyclic prefix
6. Frequency synchronization algorithm based on symbols with periodic repetitions

#### Research Objectives:

**Part 1: Time Synchronization**
1. Analyze the noise immunity of OFDM signal reception for different time shift values without time synchronization.
2. Study the appearance of the autocorrelation function used in the time synchronization algorithm based on the cyclic prefix, depending on the number of symbols used for synchronization.
3. Evaluate the noise immunity of OFDM signal reception for varying numbers of symbols used in time synchronization with a cyclic prefix.
4. Assess the effect of an equalizer on the noise immunity of OFDM signal reception for different numbers of symbols used in time synchronization with a cyclic prefix.
5. Analyze the appearance of the autocorrelation function used for time synchronization based on symbols with periodic repetitions (Minn's algorithm).
6. Investigate the noise immunity of OFDM signal reception with time synchronization based on symbols with periodic repetitions (Minn's algorithm) both without and with an equalizer.

**Part 2: Frequency Synchronization**
1. Analyze the noise immunity of OFDM signal reception for different frequency shift values without frequency synchronization.
2. Evaluate the effect of an equalizer on the noise immunity of OFDM signal reception for various frequency shift values without frequency synchronization.
3. Study the noise immunity of OFDM signal reception for varying numbers of symbols used in frequency synchronization with a cyclic prefix (normalized frequency offset in the range \([-0.5, 0.5]\)).
4. Assess the impact of the cyclic prefix on the noise immunity of OFDM signal reception during frequency synchronization with a cyclic prefix.
5. Investigate the noise immunity of OFDM signal reception during frequency synchronization based on symbols with periodic repetitions at normalized frequency offsets \([-0.5, 0.5]\) and \([-2, 2]\).

#### Additional Instructions:
- **General Parameters**:
  - Data modulation: 16-QAM
  - Pilot modulation: 4-QAM
  - FFT size \(N_{\text{fft}} = 2048\)
  - Relative guard interval length: from 0 to 1/4
  - Time offset: from 0 to \(N_{\text{fft}} - 1\) samples
  - Normalized frequency offset: \(|\Delta f / \Delta f_0| < 0.5\) or \(|\Delta f / \Delta f_0| < 2\) (\(\Delta f_0\) is the subcarrier spacing)

This document outlines the tasks to be implemented and the aspects to be investigated in time and frequency synchronization of OFDM signals, including the effects of equalization and the use of cyclic prefixes.