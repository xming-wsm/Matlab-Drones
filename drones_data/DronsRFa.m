%% 用于侦测低空无人机的大规模无人机射频信号数据集(DroneRFa)的论文
% Auther: xming
% Data: 2023.11.13
% Content: 使用stft绘制不同无人机的跳频信号时谱图，用于深度学习训练
clear;
close all;
clc;

% 无人机型号标签
type_of_uav = [
    "0001", "0010", "0011", "0100", "0111", "1100", "1110", ...
    "10000", "10010", "10100", "10110"
];
% 距离标签
type_of_distance = [
    "00", "01", "10"
];
% 距离频段
type_of_frequency = [
    "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",...
    "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"
];


%% 读取数据
input_file_path = "D:\0DataCollect\Drones\";    % 文件读取路径
for i = 1 : length(type_of_uav)
    for j = 1 : length(type_of_distance)
        for k = 1 : length(type_of_frequency)
            
            % 判断文件是否存在？
            input_file_name = "T" + type_of_uav(i) + "_D" + type_of_distance(j) + "_S" + type_of_frequency(k) + ".mat";
            if exist(input_file_path + input_file_name, 'file') ~= 2
                continue % 文件不存在，继续下一个循环
            else
                data = load(input_file_path + input_file_name);
                data_rf0_i = data.RF0_I;
                data_rf0_q = data.RF0_Q;
                data_rf1_i = data.RF1_I;
                data_rf1_q = data.RF1_Q;
                
                % 设置相关参数
                fs = 100e6;          % 采样频率为100M
                time_duration = 0.1; % 每个片段的时间长度为0.1s
                slice_point = fs * time_duration; % 每个片段的点数
                stft_point = 2048;   % stft点数为2048
                output_file_path = "D:\0DataCollect\Drones\figure\";    % 文件保存路径
                % 绘制 data_rf0_i 的 stft 图像
                for ii = 1 : floor(length(data_rf0_i)/slice_point)
                    stft(data_rf0_i((ii-1)*slice_point+1 : ii*slice_point), fs, ...
                        'Window', hamming(stft_point), 'FFTLength', stft_point);
                    saveas(gcf, output_file_path + input_file_name + "data_rf0_i" + num2str(ii) + ".jpg")
                end
            end
        end
    end
end