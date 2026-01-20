% Busses for CPG output
% generalised coordinates
clear elems;

elems(1) = Simulink.BusElement;
elems(1).Name = 'x';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'y';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'th';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'l';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'dx';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'dy';
elems(6).DataType = 'double'; 

elems(7) = Simulink.BusElement;
elems(7).Name = 'dth';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'dl';
elems(8).DataType = 'double'; 

Coordinate = Simulink.Bus;
Coordinate.Elements = elems;

clear elems;

% oscillator
elems(1) = Simulink.BusElement;
elems(1).Name = 'x';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'y';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'th';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'tst';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'tsw';
elems(5).DataType = 'double';

Oscillator = Simulink.Bus;
Oscillator.Elements = elems;

clear elems;

% system
elems(1) = Simulink.BusElement;
elems(1).Name = 'grf_n';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'grf_t';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'torque';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'force';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'foot_x';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'foot_y';
elems(6).DataType = 'double';

elems(7) = Simulink.BusElement;
elems(7).Name = 'foot_dx';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'foot_dy';
elems(8).DataType = 'double';

elems(9) = Simulink.BusElement;
elems(9).Name = 'ue';
elems(9).DataType = 'double';

elems(10) = Simulink.BusElement;
elems(10).Name = 'ur';
elems(10).DataType = 'double';

System = Simulink.Bus;
System.Elements = elems;

clear elems;

% system
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

Template = Simulink.Bus;
Template.Elements = elems;

clear elems;

% setpoint
elems(1) = Simulink.BusElement;
elems(1).Name = 'th_d';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'dth_d';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'phi_d';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'dphi_d';
elems(4).DataType = 'double';

Setpoint = Simulink.Bus;
Setpoint.Elements = elems;