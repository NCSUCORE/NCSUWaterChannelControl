INTRODUCTION
This file is intended to be a step-by-step guide to creating a new controller
and adding it to the appropriate model.

BACKGROUND
Controllers are included in model2_cm.slx which is run on machine 2.
Specifically, they should be added to the variant subsystem called "controllers"
in model2_cm.  The file containing this library block is located in the file
./compositions/controllers/controllers_cl.slx.

If you are unfamiliar with how variant subsystems work, it's probably a 
good idea to read up on them here:
https://www.mathworks.com/help/simulink/examples/variant-subsystems.html

For an explanation of the file naming conventions, see "NamingConventions.txt"
in the documentation folder.  Please stick to these naming conventions, doing so
will only help future users, neglecting them will make everyone's life harder.

INTEGRATING A NEW CONTROLLER: STEP-BY-STEP

Section A: Creating new files

1.  From the simulink project window (waterChannelControl.prj), copy and paste 
the folder
./compositions/controllers/template
to
./compositions/controllers/YOURNAMEHERE
Note that after pasting, you will have to change the name of the folder to match
the name of your controller.

2.  Change the name of the controller composition library .slx file from 
./compositions/controllers/YOURNAMEHERE/template_cl.slx
to
./compositions/controllers/YOURNAMEHERE/YOURNAMEHERE_cl.slx

3.  Open this new file, YOURNAMEHERE.sl.  This should contain a single, pre-configured
subsystem with all the correct inputs/outputs.  Rename this subsystem to whatever
you're using for YOURNAMEHERE.  At this point the directory, file, and subsystem
should all have extremely similiar names.

Section B: Implementing your controller

Basically, just go wild in the subsystem that you just created in

./compositions/controllers/YOURNAMEHERE/YOURNAMEHERE_cl.slx

However, do not change the name of the input and output blocks.  These must match the 
names of the in/out blocks in

./compositions/controllers/controllers_cl.slx

otherwise, you're free to do whatever you want, subject to the usual restrictions of
Simulink Real Time.  Note that the outputs are motor speeds that are normalized to
lie in the range from -1 (full speed wind tether in) to 1 (full speed spool tether 
out).

Finally, looking at the "default" controller in 

./compositions/controllers/constantSetpoint/constantSetpoint_cl.slx

will probably provide you with some good guidance to get you started.  This is just a
controller designed to regulate the system to constant roll, pitch, and altitude
setpoints.

Section C:  Integrating your controller

1.  Adding your controller to the variant subsystem library.

1a.  Open the variant subsystem composition library at 

./compositions/controllers/controllers_cl.slx

and unlock the diagram via Diagram>Unlock Library

1b.  Open your controller at 

./compositions/controllers/YOURNAMEHERE/YOURNAMEHERE_cl.slx

1c.  Click and drag the subsystem that is your controller from it's window into the
composition library window.  When prompted whether you want to add the block or a
wrapper containing the block, select "add block".

1d.  Right click on the new subsystem for you controller and select
Block Parameters (Subsystem).  In the field "Variant control" enter the name of your
variant, exactly as it will appear in the base workspace (more on this in the next
section).

1e.  Save the variant subsystem composition library.  From here on out any changes
you need to make to the structure of your controller (note, not the value of mask
parameters, constants, etc) should be done directly to the composition library file
at 
./compositions/controllers/YOURNAMEHERE/YOURNAMEHERE_cl.slx
These changes will automatically propagate through to model2_cl.slx, which gets run
on machine 2.

2.  Setting up variant control in the base workspace.

You should not have to do anything to set up variants in the base workspace.  The
script controllers_init.m should do this automatically.  This script is called during
the initialization of the water channel software, specifically, at the end of
initializeSystem.m.  The script controllers_init.m functions by first searching
./compositions/controllers
to obtain a list of directories.  It then creates a Simulink.Variant object in the
base workspace using the name of each directory.  Note that this means your controller
will correspond to a Simulink.Variant object with the name VSS_YOURNAMEHERE in the 
base workspace.

The active variant is controlled by the variable CONTROLLER in the base workspace.
You can check what CONTROLLER should be set to in order to activate your controller by
double clicking your variant object in the workspace window.  The condition that
activates your controller is shown in the popup dialog box.

3.  Initializing variables in the base workspace for your controller.

If you would like to store variables in the base workspace that determine how your
controller behaves (eg gains, time constants, etc) then you are welcome to store all
of those in an initialization script in the directory

./compositions/controllers/YOURNAMEHERE/

this script should be named YOURNAMEHERE_init.m.  Note that this script will not run
automatically at any point and you will have to call it manually yourself from the
command line.







