%% 用于侦测低空无人机的大规模无人机射频信号数据集(DroneRFa)的论文
% Auther: xming
% Data: 2023.11.13
% Content: 使用stft绘制不同无人机的跳频信号时谱图，用于深度学习训练

clear;
close all;
clc;


%% 读取数据
input_file_path = "D:\0DataCollect\Drones\";
input_file_name = "T0001_D00_S0000.mat";
data = load(input_file_path+input_file_name);
data_rf0_i = data.RF0_I;
data_rf0_q = data.RF0_Q;
data_rf1_i = data.RF1_I;
data_rf1_q = data.RF1_Q;


%% 设定参数
fs = 100e6; % 采样频率100M
time_duration = 0.1; % 每张stft照片的时间长度为0.1s
point_clip = fs * time_duration;    % 时间长度0.1s对应的点数
stft_point = 2048;   % stft的窗口点数设为2048
for i = 1 : 1
% for i = 1 : length(data_rf0_i)/point_clip
    % stft(data_rf0_i((i-1)*point_clip+1 : i*point_clip), fs, 'Window', hamming(stft_point), 'FFTLength', stft_point);
    stft(data_rf0_i((i-1)*point_clip+1 : i*point_clip), fs, 'FFTLength', stft_point);
end