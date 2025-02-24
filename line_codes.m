digital_data = randi([0 1], 1, 21); % Generate a row vector of random 0s and 1s
disp(digital_data);
%digital_data = [0 1 1 0 1 1 0 0 0 1 1 0 1 1 1 0 1 0 1 0 0];

% Define parameters
l = length(digital_data);
fs = 100;  % Sampling frequency (100 bits per sec)
bit_duration = 1;  % Duration of each bit
t = 0 : 1/fs : l * bit_duration - 1/fs;  % Time vector

signals_figure = figure; 
psd_figure = figure;

%-------------------------------------------------------------------------------------------
%----------------------------------------POLAR NRZ----------------------------------------
%-------------------------------------------------------------------------------------------
% Initialize waveform
waveform = zeros(1, length(t));

% Polar NRZ signal
for n = 1:l
    start_i = (n-1) * fs + 1;  % Start index for this bit
    end_i = n * fs;            % End index for this bit
    
    if digital_data(n) == 1
        waveform(start_i:end_i) = 1;  % +V for bit '1'
    else
        waveform(start_i:end_i) = -1; % -V for bit '0'
    end
end

% Plot the Polar NRZ waveform
%figure;
figure(signals_figure);
subplot(6,1,1);
% subplot(2,1,1);
stairs(t, waveform, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Polar NRZ Encoding: ', mat2str(digital_data)]);
ylim([-1.5 1.5]); % Set y-axis limits
grid on;

% Compute PSD
[psd_values, f] = pwelch(waveform, hamming(256), [], [], fs, 'centered');

% PSD Plot
figure(psd_figure);
subplot(6,1,1);
% subplot(2,1,2);
plot(f, psd_values, 'r', 'LineWidth', 1);
xlabel('Frequency');
ylabel('PSD');
title('Polar NRZ PSD');
grid on;

%-------------------------------------------------------------------------------------------
%----------------------------------------INVERTED POLAR NRZ----------------------------------------
%-------------------------------------------------------------------------------------------
% Initialize waveform
waveform = zeros(1, length(t));

% Inverted Polar NRZ signal
for n = 1:l
    start_i = (n-1) * fs + 1;  % Start index
    end_i = n * fs;            % End index
    
    if digital_data(n) == 1
        waveform(start_i:end_i) = -1;  % -V for bit '1' (inverted)
    else
        waveform(start_i:end_i) = 1;   % +V for bit '0' (inverted)
    end
end

% Plot the Polar NRZ waveform
figure(signals_figure);
subplot(6,1,2);
% figure;
% subplot(2,1,1);
stairs(t, waveform, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Inverted Polar NRZ Encoding: ', mat2str(digital_data)]);
ylim([-1.5 1.5]); % Set y-axis limits
grid on;

% Compute PSD
[psd_values, f] = pwelch(waveform, hamming(256), [], [], fs, 'centered');

% PSD Plot
figure(psd_figure);
subplot(6,1,2);
% subplot(2,1,2);
plot(f, psd_values, 'r', 'LineWidth', 1);
xlabel('Frequency');
ylabel('PSD');
title('Inverted Polar NRZ PSD');
grid on;

%-------------------------------------------------------------------------------------------
%----------------------------------------POLAR RZ----------------------------------------
%-------------------------------------------------------------------------------------------
% Initialize waveform
waveform = zeros(1, length(t));

% Polar RZ signal
for n = 1:l
    start_i = (n-1) * fs + 1;  % Start index
    mid_i = start_i + fs/2 - 1; % Middle index 
    end_i = n * fs;            % End index
    
    if digital_data(n) == 1
        waveform(start_i:mid_i) = 1;  % +V for first half of bit '1'
    else
        waveform(start_i:mid_i) = -1; % -V for first half of bit '0'
    end
    % Second half of duration remains 0 (already initialized to zero)
end

% Plot the Polar RZ waveform
figure(signals_figure);
subplot(6,1,3);
% figure;
% subplot(2,1,1);
stairs(t, waveform, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Polar RZ Encoding: ', mat2str(digital_data)]);
ylim([-1.5 1.5]); % Set y-axis limits
grid on;

% Compute PSD
[psd_values, f] = pwelch(waveform, hamming(256), [], [], fs, 'centered');

% PSD Plot
figure(psd_figure);
subplot(6,1,3);
% subplot(2,1,2);
plot(f, psd_values, 'r', 'LineWidth', 1);
xlabel('Frequency');
ylabel('PSD');
title('Polar RZ PSD');
grid on;

%-------------------------------------------------------------------------------------------
%----------------------------------------BIPOLAR NRZ----------------------------------------
%-------------------------------------------------------------------------------------------
% Initialize waveform
waveform = zeros(1, length(t));
last_polarity = -1;  % Start with -1

% Bipolar NRZ (AMI) signal
for n = 1:l
    x = (n-1) * fs * bit_duration + (1:fs*bit_duration); % full duration for the bit
    if digital_data(n) == 1
        last_polarity = -last_polarity;  % Toggle polarity
        waveform(x) = last_polarity;
    else
        waveform(x) = 0;
    end
end

% Plot
figure(signals_figure);
subplot(6,1,4);
% figure;
% subplot(2,1,1);
plot(t, waveform, 'LineWidth', 2);
ylim([-1.5 1.5]);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Bipolar NRZ (AMI) Encoding: ', mat2str(digital_data)]);
grid on;

% Compute and plot PSD
[psd_values, f] = pwelch(waveform, hamming(256), [], [], fs, 'centered');

% PSD Plot
figure(psd_figure);
subplot(6,1,4);
% subplot(2,1,2);
plot(f, psd_values, 'r', 'LineWidth', 1);
xlabel('Frequency');
ylabel('PSD');
title('Bipolar NRZ PSD');
grid on;

%-------------------------------------------------------------------------------------------
%-----------------------------------------BIPOLAR RZ----------------------------------------
%-------------------------------------------------------------------------------------------
% Initialize waveform
waveform = zeros(1, length(t));
last_polarity = -1;  % Start with -1

% Bipolar RZ signal
for n = 1:l
    x = (n-1) * fs * bit_duration + (1:fs*bit_duration/2); % half duration for the bit
    if digital_data(n) == 1
        last_polarity = -last_polarity;  % Toggle polarity
        waveform(x) = last_polarity;
    else
        waveform(x) = 0;
    end
end

% Plot
figure(signals_figure);
subplot(6,1,5);
% figure;
% subplot(2,1,1);
plot(t, waveform, 'LineWidth', 2);
ylim([-1.5 1.5]);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Bipolar RZ Encoding: ', mat2str(digital_data)]);
grid on;

% Compute PSD
[psd_values, f] = pwelch(waveform, hamming(256), [], [], fs, 'centered');

% PSD Plot
figure(psd_figure);
subplot(6,1,5);
% subplot(2,1,2);
plot(f, psd_values, 'r', 'LineWidth', 1);
xlabel('Frequency');
ylabel('PSD');
title('Bipolar RZ PSD');
grid on;

%-------------------------------------------------------------------------------------------
%-----------------------------------------MANCHESTER----------------------------------------
%-------------------------------------------------------------------------------------------
% Initialize waveform
waveform = zeros(1, length(t));

% Generate Manchester Encoding
for n = 1:l
    x1 = (n-1) * fs * bit_duration + (1:fs*bit_duration/2);  % First half
    x2 = x1 + fs*bit_duration/2;  % Compute second half
    
    if digital_data(n) == 1
        waveform(x1) = 1;   % First half high
        waveform(x2) = -1;  % Second half low
    else
        waveform(x1) = -1;  % First half low
        waveform(x2) = 1;   % Second half high
    end
end

% Plot
figure(signals_figure);
subplot(6,1,6);
% figure;
% subplot(2,1,1);
plot(t, waveform, 'LineWidth', 2);
ylim([-1.5 1.5]);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Manchester Encoding: ', mat2str(digital_data)]);
grid on;

% Compute PSD
[psd_values, f] = pwelch(waveform, hamming(256), [], [], fs, 'centered');

% PSD Plot
figure(psd_figure);
subplot(6,1,6);
% subplot(2,1,2);
plot(f, psd_values, 'r', 'LineWidth', 1);
xlabel('Frequency');
ylabel('PSD');
title('Manchester PSD');
grid on;
