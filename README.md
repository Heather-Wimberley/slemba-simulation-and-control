# SLemba Simulation and Control
This repository contains all simulation code and hardware interface code that was used for the SLemba robot developed at UCT as part of a Master's thesis in the ARU. All files are written to be used in MATLAB.

# Kemba 2.5
This folder contains all work done on the spine version of Kemba with updated leg pistons. This includes an ODE113 model and the PSO done on the full system with the CPG. This folder also includes the work done on the Raibert control.

- To run the ODE, use: kemba_solver.mlx
- To run the PSO, use: PSO/Kemba_PSO_single.m
- To run the simulated Kemba Raibert controller, use: bounding_spine_Simscape.slx
- To run the Raibert Controller on the actual robot, use: bounding_spine_Physical.slx

>Note the physical Raibert controller and PSO method are not in a working state.

# SLemba
This folder contains the ODE simulation, Simscape simulation and physical interface, including the CPG controller. It also contains the PSO and Trajectory Optimisation methods used to optimise the robot.

- To run the ODE simulation, use: Kinematics_SLemba/runSingleForward.mlx
- To run the Simscape, use: Simscape_SLemba/SLemba_CPG.slx (_note SLemba_CPG_startup.slx includes the throw-in startup method used on the physical robot_)
- To run the controller on the physical robot, use: Physical_SLemba/Controller/SLemba_cpg.slx (_see below for robot setup procedure_)
- To run the PSO, use: PSO/SLemba_PSO.m
- To run the Trajectory Optimisation, use: TrajOpt/runOscParamSolver.m

>When running everything except the physical robot, the Kinematics_SLemba folder needs to be added to the path

# SLemba Physical Setup
## Robot Assembly
To assemble SLemba, the motor, leg, and one set of solenoid valves need to be removed from Kemba. It is best to use the left leg to Kemba to ensure colour coding conventions are kept. When assembling, the parts should be added in the following order
1. attach Solenoids to body frame with the external pressuriser interface attached
2. place the body insert in between lining up with the boom attachment holes
3. place the placeholder long screws through the boom insert (_it is best to always keep a screw in so the insert does not loose its alignment_)
4. connect the two body parts together
5. attach the motor to the body
6. feed the motor power and CAN through the motor cap and push the body's solenoid connector through
7. plug in the solenoids and all motor cables
8. attach the motor cap to the motor
9. attach the leg to the motor
10. connect the leg pneumatic tubes to the solenoid values
11. attach the body end cap (_ensure not to overtighten_)

## Robot Connection
Once the robot is assembled, it needs to be connected to the boom and the Speedgoat. This is done using the following steps
1. check that the boom head is the stationary one and that the IMU cable is plugged in (if it is the rotating one, this one needs to be removed by untensioning the cables, detaching the rotating head, attaching the stationary head and retensioning the cables to ensure the boom end is perpendicular to the floor)
2. place the 4 boom connection screws through the boom attachment (one in each corner) with the end of the screw pointing away from the center
3. slide the robot onto these screws (this should push out the screws that are already there), ensuring the leg is on the outside of the boom radius
4. secure the bolts using the nyloc nuts (these should be replaced the boom screws ever start to rattle)
5. connect the CAN (5 pin), Solenoid control (8 pin) and Hall Effect Sensor (4 pin with matching colour band) as well as the power and pneumatic tube
6. pressurise the compressor to 7 MPa
7. connect the pneumatics to the compressor, making sure the output of the compressor is not pressurised
8. pressurise the output, making sure there is no escaping air anywhere in the system

## Robot Interface Setup
Once the robot is attached and pressurised, it needs to be checked that all sensors and actuators are connected correctly and are reading the correct measurements. This is done as follows:
1. place the leg in the resting position (piston retracted with the femur touching the white zeroing bracket)
2. power on the motors (ensure this is done gradually, starting at 10V, then 24V, then 48V) and press the button to connect them to the batteries. To set up the boom box
  - charge 2 6 cell batteries to 24V each
  - plug into the boom box system (putting the batteries in a bat box)
  - connect all other labelled parts of the boom box
  - ensure that the batteries are initially **not** connected to the motor until they have been powered on gradually
3. open the file **Physical_SLemba/TestingSensors/TestingSensors.slx**
4. set all piston inputs to zero and then run it
5. ensure that robot height is correct and that it moves correctly
   >Sometimes an integration error occurs where this value changes slowly. To fix this, just unplug the power IMU from the board at the centre of the boom and then replug in the IMU, then power
6. click the green button to zero the motors, cycle motor power, then check that the motor changes value as expected and reads zero in the resting position
7. check the hall effect sensor position (it should move between 0m and 0.07m) If this is not the case (eg the hall effect sensor was removed and put back on) do the following:
  - move the piston to fully extended and retracted making note of the "raw" value (should be in integer)
  - change the parameters of the piston sensor to match these (this needs to be done in Testing Sensors and the physical interface separately)
  - recompile the Testing Sensors to check it now goes between the correct values
9. command the piston chambers to extend and retract one at a time making sure the command does as expected (you might need to switch which pneumatic tube is connected where)

After this the robot should be ready to run a controller.

## Robot Testing Notes
During the tests, there are various things to note:
- Compressor pressure will change throughout. Ensure you keep checking that it is at 7 MPa
- The L-brackets for the piston pneumatics are considered a consumable. If anything goes wrong, these are likely to break first so make sure you have plenty spares whenever you work
