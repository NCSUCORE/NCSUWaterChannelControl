close all
clear all
clc

T = 10;
Ts = 0.01;


set_param('filteredPDController_th/FilteredPDController','enable',1)
set_param('filteredPDController_th/FilteredPDController','kp','1')
set_param('filteredPDController_th/FilteredPDController','kd','0')
set_param('filteredPDController_th/FilteredPDController','timeConstant_s','0.1')

time = 0:Ts:T;

setpoint = timeseries(zeros(size(time)),time);
measured = setpoint;

setpoint.data = ones(size(setpoint.data));

sim('filteredPDController_th')

response.plot