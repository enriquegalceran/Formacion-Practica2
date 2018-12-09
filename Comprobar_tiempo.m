%Comprobar tiempo

Timeline = [8, 0, 7, 7, 7.25, 7.25, 12.9, 12.9, 13, 0, 0, 20, 20, 0, 0, 20, 20];
if length(Timeline) ~= Timeline(1)*2 + 1
    error('No cuadran las longitudes')
end
Timelinex = Timeline(2:1+Timeline(1));
Timeliney = Timeline(Timeline(1) + 2:end);

figure(99)
plot(Timelinex, Timeliney)