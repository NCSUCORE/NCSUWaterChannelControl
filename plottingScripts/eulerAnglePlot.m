figure
hold on
grid

plot(180/pi*tsc.pitch_rad.Data(5000:7000),'r-')
plot(180/pi*tsc.roll_rad.Data(5000:7000),'g-')
plot(180/pi*tsc.yaw_rad.Data(5000:7000),'b-')

legend('pitch','roll','yaw')

