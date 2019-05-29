function exportSim( index )
%EXPORTSIM Summary of this function goes here
%   Detailed explanation goes here
file = strcat('simout_',num2str(index),'.mat');

vT = evalin('caller','vT');
vU = evalin('caller','vU');
mX = evalin('caller','mX');
mXobs = evalin('caller','mXobs');


save(file,'vT', 'vU', 'mX', 'mXobs');

end

