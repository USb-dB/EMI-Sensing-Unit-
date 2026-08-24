clc;
clear;
close all;

  
% BASIC PARAMETERS
    

T = 20e-9;                  % Repetition period
D = 0.45;                   % Duty cycle
A = 1;                      % Amplitude

f0 = 1/T;                   % 50 MHz

% tau = nominal pulse duration parameter
tau = D*T;

% Rise and fall times
Tr = 2.0e-9;
Tf = 2.0e-9;

  
% TIME SAMPLING
    

Fs = 20e9;                  % Sampling frequency
Nperiod = 200;              % Number of periods

dt = 1/Fs;

t = 0:dt:Nperiod*T-dt;

  
% GENERATE YOUR TRAPEZOIDAL WAVEFORM
    

tm = mod(t,T);

x = zeros(size(t));

      
% RISE
      

idx = (tm >= 0) & (tm < Tr);

x(idx) = A*tm(idx)/Tr;

      
% FLAT TOP
      

t_fall_start = tau + (Tr-Tf)/2;

idx = (tm >= Tr) & ...
      (tm < t_fall_start);

x(idx) = A;

      
% FALL
      

t_fall_end = tau + (Tr+Tf)/2;

idx = (tm >= t_fall_start) & ...
      (tm < t_fall_end);

x(idx) = A * ...
    (1 - (tm(idx)-t_fall_start)/Tf);

  
% TIME DOMAIN
    

figure;

plot(t*1e9,x,'LineWidth',1.5);

xlabel('Time (ns)');
ylabel('Amplitude');

title('Trapezoidal Pulse');

grid on;

xlim([0 20]);

  
% FFT
    

N = length(x);

X = fft(x)/N;

df = Fs/N;

  
% HARMONICS
    

nmax = 30;

n = 0:nmax;

f_h = n*f0;

fft_bin = round(f_h/df) + 1;

C_fft = abs(X(fft_bin));

  
% ODD / EVEN HARMONICS
    

odd = mod(n,2)==1;
even = mod(n,2)==0;

% Remove DC
even(1) = false;

  
% PLOT
    

figure;
hold on;

stem(f_h(odd)/1e6,...
     C_fft(odd),...
     'filled',...
     'LineWidth',1.5);

stem(f_h(even)/1e6,...
     C_fft(even),...
     'LineWidth',1.5);

xlabel('Frequency (MHz)');
ylabel('|C_n|');

title('FFT Spectrum — Odd and Even Harmonics');

legend('Odd harmonics','Even harmonics');

grid on;

xlim([0 1500]);

  
% PRINT
    

fprintf('\n========================================\n');
fprintf('Parameters\n');
fprintf('========================================\n');

fprintf('T       = %.3f ns\n',T*1e9);
fprintf('f0      = %.3f MHz\n',f0/1e6);
fprintf('D       = %.2f\n',D);
fprintf('tau     = %.3f ns\n',tau*1e9);
fprintf('Tr      = %.3f ns\n',Tr*1e9);
fprintf('Tf      = %.3f ns\n',Tf*1e9);

fprintf('\nFalling edge:\n');
fprintf('t_start = %.3f ns\n',t_fall_start*1e9);
fprintf('t_end   = %.3f ns\n',t_fall_end*1e9);

fprintf('========================================\n');