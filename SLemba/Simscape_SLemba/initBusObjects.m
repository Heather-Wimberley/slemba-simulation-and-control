% Bus object: BodyState
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'x';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'dx';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'ddx';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'y';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'dy';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'ddy';
elems(6).DataType = 'double';

BodyState = Simulink.Bus;
BodyState.Elements = elems;
clear elems

% Bus object: MotorCommand
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'q';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'w';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'Kp';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'Kd';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'tff';
elems(5).DataType = 'double';

MotorCmd = Simulink.Bus;
MotorCmd.Elements = elems;
clear elems

% Bus object: MotorState
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'q';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'w';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 't';
elems(3).DataType = 'double';

MotorState = Simulink.Bus;
MotorState.Elements = elems;
clear elems

% Bus object: PistonCommand
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'ue';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'ur';
elems(2).DataType = 'double';

PistonCmd = Simulink.Bus;
PistonCmd.Elements = elems;
clear elems

% Bus object: PistonState
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'p';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'v';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'a';
elems(3).DataType = 'double';

PistonState = Simulink.Bus;
PistonState.Elements = elems;
clear elems

% Bus object: Command
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'height';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'speed';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'start';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'stop';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'feedforward';
elems(5).DataType = 'double';

Command = Simulink.Bus;
Command.Elements = elems;
clear elems

% Bus object: FootState
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'contact';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'separation';
elems(2).DataType = 'double';
elems(2).Unit = 'm';

elems(3) = Simulink.BusElement;
elems(3).Name = 'GRF';
elems(3).DataType = 'double';
elems(3).Unit = 'N';

elems(4) = Simulink.BusElement;
elems(4).Name = 'friction';
elems(4).DataType = 'double';
elems(3).Unit = 'N';

FootState = Simulink.Bus;
FootState.Elements = elems;
clear elems

% Bus object: State
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'Motor';
elems(1).DataType = 'Bus: MotorState';

elems(2) = Simulink.BusElement;
elems(2).Name = 'Piston';
elems(2).DataType = 'Bus: PistonState';

elems(3) = Simulink.BusElement;
elems(3).Name = 'Body';
elems(3).DataType = 'Bus: BodyState';

State = Simulink.Bus;
State.Elements = elems;
clear elems

% Bus object: Controller
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'state';
elems(1).DataType = 'Enum: States';

elems(2) = Simulink.BusElement;
elems(2).Name = 'Ts';
elems(2).DataType = 'double';

Controller = Simulink.Bus;
Controller.Elements = elems;
clear elems

% Bus object: Vitrual Leg
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'r';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'phi';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'dr';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'dphi';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'phi_d';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'dphi_d';
elems(6).DataType = 'double';

VirtualLeg = Simulink.Bus;
VirtualLeg.Elements = elems;
clear elems

% Bus object: HipState
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'y';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'y_max';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'y_min';
elems(3).DataType = 'double';

HipState = Simulink.Bus;
HipState.Elements = elems;
clear elems

% Bus Object: Optimised Trajectory
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'th_f';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'dth_f';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'th_b';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'dth_b';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'ue_f';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'ur_f';
elems(6).DataType = 'double';

elems(7) = Simulink.BusElement;
elems(7).Name = 'lp_f';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'ue_b';
elems(8).DataType = 'double';

elems(9) = Simulink.BusElement;
elems(9).Name = 'ur_b';
elems(9).DataType = 'double';

elems(10) = Simulink.BusElement;
elems(10).Name = 'lp_b';
elems(10).DataType = 'double';

elems(11) = Simulink.BusElement;
elems(11).Name = 'ue_s';
elems(11).DataType = 'double';

elems(12) = Simulink.BusElement;
elems(12).Name = 'ur_s';
elems(12).DataType = 'double';

elems(13) = Simulink.BusElement;
elems(13).Name = 'lp_s';
elems(13).DataType = 'double';

elems(14) = Simulink.BusElement;
elems(14).Name = 'x';
elems(14).DataType = 'double';

elems(15) = Simulink.BusElement;
elems(15).Name = 'y';
elems(15).DataType = 'double';

elems(16) = Simulink.BusElement;
elems(16).Name = 'r';
elems(16).DataType = 'double';

elems(17) = Simulink.BusElement;
elems(17).Name = 'dx';
elems(17).DataType = 'double';

elems(18) = Simulink.BusElement;
elems(18).Name = 'dy';
elems(18).DataType = 'double';

elems(19) = Simulink.BusElement;
elems(19).Name = 'dr';
elems(19).DataType = 'double';

TrajOpt = Simulink.Bus;
TrajOpt.Elements = elems;
clear elems
