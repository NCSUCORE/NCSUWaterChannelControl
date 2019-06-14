function createCoordinateCtrlBus()
% Creates output bus used by find6DOFSnellMin9_cl

elems(1) = Simulink.BusElement;
elems(1).Name = 'dotCoords';
elems(1).Dimensions = [2 1];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Unit = 'pixel';

CONTROL = Simulink.Bus;
CONTROL.Elements = elems;
CONTROL.Description = 'Bus containing pixel coordinates produced by image processing';

assignin('base','coordBus',CONTROL)

end