%% Temporary main.m
clear; clc; close all;

% 1. Add src, data, AND all subfolders (like load_flow) to MATLAB's search path
addpath(genpath('data'));
addpath(genpath('src'));

% 2. Load test network data
[bus_data, line_data, base_MVA] = get_bus_data('3_bus');
num_buses = size(bus_data, 1);

% 3. Build Y-bus matrix
Ybus = build_ybus(line_data, num_buses);

% 4. Print output
fprintf('--- Y-bus Matrix Output (%d-bus system) ---\n', num_buses);
disp(Ybus);