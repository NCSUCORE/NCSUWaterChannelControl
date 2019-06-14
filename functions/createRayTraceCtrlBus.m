function createRayTraceCtrlBus()
% Creates output bus used by find6DOFSnellMin9_cl

elems(1) = Simulink.BusElement;
elems(1).Name = 'outsideGlassVec';
elems(1).Dimensions = [3 1];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Unit = 'cm';

elems(2) = Simulink.BusElement;
elems(2).Name = 'insideGlassVec';
elems(2).Dimensions = [3 1];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';
elems(2).Unit = 'cm';

elems(3) = Simulink.BusElement;
elems(3).Name = 'unitVec';
elems(3).Dimensions = [3 1];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';
elems(3).Unit = 'cm';

CONTROL = Simulink.Bus;
CONTROL.Elements = elems;
CONTROL.Description = 'Bus containing vectors produced by ray trace block';

assignin('base','rayBus',CONTROL)

end