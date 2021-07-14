clear
clc

%% test filtering operation
t = linspace(0,100,401);
x = sin(t) + 0.25*rand(size(t));

tsVal = timeseries(x,t);

windowSize = 5; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

y = filter(b,a,x);

plot(t,x)
hold on
plot(t,y)
legend('Input Data','Filtered Data')
plot(t,out.simout.Data(:))
