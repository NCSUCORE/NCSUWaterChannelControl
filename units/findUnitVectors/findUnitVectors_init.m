%% Function to initialize Find Unit Vectors block

sideEulerAngles = sideEulerAngles.*pi/180;
botEulerAngles = botEulerAngles.*pi/180;
slantEulerAngles = slantEulerAngles.*pi/180;

GFC2Side = calculateRotationMatrix(sideEulerAngles(1),sideEulerAngles(2),sideEulerAngles(3));
GFC2Bottom = calculateRotationMatrix(botEulerAngles(1),botEulerAngles(2),botEulerAngles(3));
GFC2Slant = calculateRotationMatrix(slantEulerAngles(1),slantEulerAngles(2),slantEulerAngles(3));

ASB = [GFC2Side(1)';GFC2Side(2)';GFC2Bottom(1)';GFC2Bottom(2)'];
ABL = [GFC2Bottom(1)';GFC2Bottom(2)';GFC2Slant(1)';GFC2Slant(2)'];

DSB = (ASB'*ASB)\ASB';
DBL = (ABL'*ABL)\ABL';