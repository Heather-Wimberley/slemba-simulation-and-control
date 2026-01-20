%% Load CPG Parameters into workspace to be used by the controller
clc; clear;

% load('Controller/CPG_Param/fit1.mat');
load("run_1p0ms.mat");
tst_sol = out.tst(1);
tsw_sol = out.tsw(1);
kx_sol = out.kx(1);
stddev = 1;