# Portable EMI/EMC Meter

A portable, low-cost EMI/EMC measurement system developed for sensing and characterizing high-frequency electromagnetic emissions from electronic and digital switching systems.

## Spectral Analysis of a Practical Digital Clock

Modern digital systems use clock and switching signals with finite rise and fall
times. These non-ideal transitions introduce higher-order harmonics that can
extend far beyond the fundamental clock frequency.

For a periodic waveform with repetition period \(T\),

\[
f_n = nf_0 = \frac{n}{T}.
\]

Therefore, even a relatively low-frequency clock can generate significant
high-frequency spectral components when its transitions are sufficiently fast.

### Trapezoidal Clock Model

As a practical model, we consider a trapezoidal clock waveform with rise time
\(T_r\), fall time \(T_f\), duty cycle \(D\), and repetition period \(T\).

For the symmetric case \(T_r=T_f\), the magnitude of the Fourier coefficients
is given by

\[
|C_n|=
\frac{2A\tau}{T}
\left|
\frac{\sin(n\pi T_r/T)}
{n\pi T_r/T}
\right|
\left|
\frac{\sin(n\pi\tau/T)}
{n\pi\tau/T}
\right|,
\qquad n\neq0.
\]

The corresponding harmonic frequencies are

\[
f_n=nf_0=\frac{n}{T}.
\]

For the simulations below, a 50 MHz clock was considered, corresponding to

\[
T=20~\mathrm{ns}.
\]

### Effect of Rise/Fall-Time Asymmetry and Duty Cycle

The harmonic spectrum was first evaluated for three representative cases:

1. \(T_r=2~\mathrm{ns}\), \(T_f=3~\mathrm{ns}\), duty cycle = 50%.
2. \(T_r=T_f=2~\mathrm{ns}\), duty cycle = 50%.
3. \(T_r=T_f=2~\mathrm{ns}\), duty cycle = 48%.

These cases illustrate the sensitivity of the harmonic spectrum to transition
symmetry and duty cycle.

<!-- IMAGE: Three FFT spectra comparing rise/fall asymmetry and duty cycle -->

<p align="center">
  <img src="Figs/EvenHarmonicsSupression.png"
       width="100%"
       alt="FFT spectra for different rise/fall times and duty cycles">
</p>

**Figure:** FFT spectra of the 50 MHz trapezoidal clock for different rise/fall
times and duty cycles.

### Suppression of Even Harmonics at 50% Duty Cycle

The symmetric 50% duty-cycle case exhibits an important property.

For

\[
D=50\%,
\]

we have

\[
\tau=\frac{T}{2}.
\]

The corresponding term in the Fourier coefficient becomes

\[
\left|
\frac{\sin(n\pi/2)}
{n\pi/2}
\right|.
\]

For even \(n\),

\[
n=2,4,6,\ldots,
\]

and therefore

\[
\sin\left(\frac{n\pi}{2}\right)=0.
\]

Consequently,

\[
\boxed{C_{2k}=0}.
\]

Thus, for an ideal symmetric 50% duty-cycle waveform, the even harmonics
are suppressed. This cancellation is lost when the duty cycle deviates from
50% or when the waveform becomes asymmetric.

The numerical FFT results reproduce this behavior, providing a direct
numerical verification of the analytical Fourier-series expression.

### Spectral Envelope

The analytical expression also provides insight into the frequency-dependent
decay of the harmonic spectrum.

Using

\[
f=\frac{n}{T},
\]

the two sinc arguments can be written as

\[
n\pi\frac{T_r}{T}=\pi fT_r
\]

and

\[
n\pi\frac{\tau}{T}=\pi f\tau.
\]

The characteristic break frequencies are therefore approximately

\[
f_{b1}=\frac{1}{\tau}
\]

and

\[
f_{b2}=\frac{1}{T_r}.
\]

For

\[
\tau=10~\mathrm{ns},
\qquad
T_r=2~\mathrm{ns},
\]

these correspond to

\[
f_{b1}=100~\mathrm{MHz}
\]

and

\[
f_{b2}=500~\mathrm{MHz}.
\]

Below the first characteristic frequency, the spectrum is approximately
constant, corresponding to

\[
0~\mathrm{dB/decade}.
\]

After the first breakpoint, one sinc term dominates the asymptotic behavior,
giving approximately

\[
-20~\mathrm{dB/decade}.
\]

Beyond the second breakpoint, both sinc terms contribute and the asymptotic
decay becomes approximately

\[
-40~\mathrm{dB/decade}.
\]

The analytical spectrum and the discrete FFT harmonics are shown below.

<!-- IMAGE: Analytical spectrum + FFT harmonics + asymptotic slopes -->

<p align="center">
  <img src="Figs/Gain_dB plot.png"
       width="90%"
       alt="Analytical trapezoidal pulse spectrum and FFT harmonics">
</p>

**Figure:** Normalized spectrum of the 50 MHz trapezoidal clock. The discrete
points represent the FFT coefficients at the harmonic frequencies, while the
continuous curve represents the analytical spectrum. The dashed lines show
the asymptotic 0, -20, and -40 dB/decade regions and the corresponding
characteristic frequencies.

The agreement between the FFT harmonics and the analytical spectrum verifies
the numerical implementation and provides the spectral basis for the
experimental EMI/EMC measurements described below.

## Why This Matters for EMI/EMC

The above analysis demonstrates that the electromagnetic emissions generated
by a digital system cannot be characterized solely by its fundamental clock
frequency.

A 50 MHz clock with nanosecond-scale transitions can contain substantial
spectral components hundreds of MHz above the fundamental and, depending on
the transition time, potentially into the GHz range.

These high-frequency components can couple through PCB traces, power and
ground networks, cables, connectors, and parasitic capacitances and
inductances. Consequently, the electromagnetic environment around a digital
system can contain significant energy at frequencies far above the nominal
clock frequency.

This motivates the development of a portable measurement system capable of
detecting and characterizing these emissions.
