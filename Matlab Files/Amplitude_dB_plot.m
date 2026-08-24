clc;
clear;
close all;
    
% BASIC PARAMETERS
      

T = 20e-9;                  % Repetition period [s]
D = 0.50;                   % Duty cycle
A = 1;                      % Pulse amplitude

f0 = 1/T;                   % Repetition frequency = 50 MHz

% Total pulse-duration parameter
tau = D*T;

% Rise and fall times
Tr = 2.0e-9;                % Rise time
Tf = 2.0e-9;                % Fall time

    
% CHECK PARAMETERS
      

if Tr <= 0 || Tf <= 0
    error('Tr and Tf must be greater than zero.');
end

if Tr + Tf > tau
    error('Tr + Tf must be smaller than tau.');
end

     
% TIME SAMPLING
      

Fs = 20e9;
Nperiod = 200;

Tobs = Nperiod*T;

dt = 1/Fs;

t = 0:dt:Tobs-dt;

N = length(t);

df = Fs/N;
     
% GENERATE TRAPEZOIDAL WAVEFORM
      

tm = mod(t,T);

x = zeros(size(t));

% Rise
idx_rise = (tm >= 0) & (tm < Tr);

x(idx_rise) = ...
    A*tm(idx_rise)/Tr;

% Falling edge start
t_fall_start = ...
    tau + (Tr-Tf)/2;

% Flat top
idx_flat = (tm >= Tr) & ...
           (tm < t_fall_start);

x(idx_flat) = A;

% Falling edge end
t_fall_end = ...
    tau + (Tr+Tf)/2;

% Fall
idx_fall = (tm >= t_fall_start) & ...
           (tm < t_fall_end);

x(idx_fall) = ...
    A*(1 - ...
    (tm(idx_fall)-t_fall_start)/Tf);

      
% FFT
      

X = fft(x)/N;

   
% HARMONICS
      

nmax = 200;

n = 1:nmax;

% Actual harmonic frequencies
f_harmonic = n*f0;

% FFT bins
fft_bin = round(f_harmonic/df) + 1;

% FFT coefficients
C_fft = abs(X(fft_bin));
   
% NORMALIZE TO FUNDAMENTAL
      

C1 = C_fft(1);

C_normalized = C_fft/C1;

%      
% CONVERT TO dB
      

C_dB = 20*log10(C_normalized);

%      
% BREAK FREQUENCIES
      

fb1 = 1/Tr;
fb2 = 1/tau;

% Put them in increasing order
fb = sort([fb1 fb2]);

fprintf('\n============================================\n');
fprintf('BREAK FREQUENCIES\n');
fprintf('============================================\n');

fprintf('f0       = %.3f MHz\n',f0/1e6);
fprintf('1/Tr     = %.3f MHz\n',fb1/1e6);
fprintf('1/tau    = %.3f MHz\n',fb2/1e6);

fprintf('============================================\n');

C1 = C_fft(1);

C_dB = 20*log10(C_fft/C1);

      

fb1 = 1/tau;
fb2 = 1/Tr;

% Make sure they are ordered
fb_low  = min(fb1,fb2);
fb_high = max(fb1,fb2);
      

% Dense frequency axis ONLY for displaying the envelope
f_dense = logspace( ...
    log10(f0), ...
    log10(max(f_harmonic)), ...
    5000);

% n corresponding to arbitrary continuous frequency
n_dense = f_dense/f0;


Cn_dense = ...
    2*A*tau/T .* ...
    abs(sin(n_dense*pi*Tr/T) ./ ...
        (n_dense*pi*Tr/T)) .* ...
    abs(sin(n_dense*pi*tau/T) ./ ...
        (n_dense*pi*tau/T));

% Normalize to fundamental
C1_analytical = ...
    2*A*tau/T .* ...
    abs(sin(pi*Tr/T)/(pi*Tr/T)) .* ...
    abs(sin(pi*tau/T)/(pi*tau/T));

Cn_dense_norm = Cn_dense/C1_analytical;

% Convert to dB
Cn_dense_dB = 20*log10(Cn_dense_norm);
   
% PLOT FFT + CONTINUOUS ANALYTICAL ENVELOPE
      

figure;

% FFT discrete harmonic points


semilogx( ...
    f_harmonic/1e6, ...
    C_dB, ...
    'o', ...
    'MarkerSize',4, ...
    'LineWidth',1.2);

hold on;


% Continuous analytical spectrum


semilogx( ...
    f_dense/1e6, ...
    Cn_dense_dB, ...
    'LineWidth',1.5);

%      
% BREAKPOINTS
      

xline( ...
    fb_low/1e6, ...
    '--', ...
    'LineWidth',1.5);

xline( ...
    fb_high/1e6, ...
    '--', ...
    'LineWidth',1.5);


% ASYMPTOTIC SLOPE LINES

% 0 dB/decade


f1 = logspace( ...
    log10(f0), ...
    log10(fb_low), ...
    500);

y1 = zeros(size(f1));

semilogx( ...
    f1/1e6, ...
    y1, ...
    '--', ...
    'LineWidth',1.2);


% -20 dB/decade


f2 = logspace( ...
    log10(fb_low), ...
    log10(fb_high), ...
    500);

y2 = -20*log10(f2/fb_low);

semilogx( ...
    f2/1e6, ...
    y2, ...
    '--', ...
    'LineWidth',1.2);

% -40 dB/decade


f3 = logspace( ...
    log10(fb_high), ...
    log10(max(f_harmonic)), ...
    500);

y_at_fb2 = ...
    -20*log10(fb_high/fb_low);

y3 = ...
    y_at_fb2 ...
    -40*log10(f3/fb_high);

semilogx( ...
    f3/1e6, ...
    y3, ...
    '--', ...
    'LineWidth',1.2);

   
% LABELS
      

xlabel('Frequency (MHz)');
ylabel('Normalized Magnitude (dB)');

title('Trapezoidal Pulse Spectrum');

grid on;
grid minor;

legend( ...
    'FFT harmonics', ...
    'Analytical spectrum', ...
    '1/\tau', ...
    '1/T_r', ...
    '0 dB/decade', ...
    '-20 dB/decade', ...
    '-40 dB/decade', ...
    'Location','southwest');
  
% LIMITS
      
xlim([f0/1e6 max(f_harmonic)/1e6]);

ylim([-100 5]);

% BREAKPOINT LABELS
     
yl = ylim;

text( ...
    fb_low/1e6, ...
    yl(2)-5, ...
    sprintf('1/\\tau = %.0f MHz',fb_low/1e6), ...
    'HorizontalAlignment','center');

text( ...
    fb_high/1e6, ...
    yl(2)-12, ...
    sprintf('1/T_r = %.0f MHz',fb_high/1e6), ...
    'HorizontalAlignment','center');

 
% SLOPE LABELS
      

text( ...
    sqrt(f0*fb_low)/1e6, ...
    -3, ...
    '0 dB/decade', ...
    'HorizontalAlignment','center');

text( ...
    sqrt(fb_low*fb_high)/1e6, ...
    -12, ...
    '-20 dB/decade', ...
    'HorizontalAlignment','center');

text( ...
    sqrt(fb_high*max(f_harmonic))/1e6, ...
    -50, ...
    '-40 dB/decade', ...
    'HorizontalAlignment','center');