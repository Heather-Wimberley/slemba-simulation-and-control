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
elems(3).Name = 'r';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'thf';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'lf';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'thb';
elems(6).DataType = 'double';

elems(7) = Simulink.BusElement;
elems(7).Name = 'lb';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'dx';
elems(8).DataType = 'double';

elems(9) = Simulink.BusElement;
elems(9).Name = 'dy';
elems(9).DataType = 'double';

elems(10) = Simulink.BusElement;
elems(10).Name = 'dr';
elems(10).DataType = 'double';

elems(11) = Simulink.BusElement;
elems(11).Name = 'dthf';
elems(11).DataType = 'double';

elems(12) = Simulink.BusElement;
elems(12).Name = 'dlf';
elems(12).DataType = 'double'; 

elems(13) = Simulink.BusElement;
elems(13).Name = 'dthb';
elems(13).DataType = 'double';

elems(14) = Simulink.BusElement;
elems(14).Name = 'dlb';
elems(14).DataType = 'double'; 

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
elems(4).Name = 'T';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'd';
elems(5).DataType = 'double';

Oscillator = Simulink.Bus;
Oscillator.Elements = elems;

clear elems;

% system
elems(1) = Simulink.BusElement;
elems(1).Name = 'grf_n_f';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'grf_t_f';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'grf_n_b';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'grf_t_b';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'torque_f';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'torque_b';
elems(6).DataType = 'double';

elems(7) = Simulink.BusElement;
elems(7).Name = 'force_f';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'force_b';
elems(8).DataType = 'double';

elems(9) = Simulink.BusElement;
elems(9).Name = 'foot_x_f';
elems(9).DataType = 'double';

elems(10) = Simulink.BusElement;
elems(10).Name = 'foot_y_f';
elems(10).DataType = 'double';

elems(11) = Simulink.BusElement;
elems(11).Name = 'foot_dx_f';
elems(11).DataType = 'double';

elems(12) = Simulink.BusElement;
elems(12).Name = 'foot_dy_f';
elems(12).DataType = 'double';

elems(13) = Simulink.BusElement;
elems(13).Name = 'foot_x_b';
elems(13).DataType = 'double';

elems(14) = Simulink.BusElement;
elems(14).Name = 'foot_y_b';
elems(14).DataType = 'double';

elems(15) = Simulink.BusElement;
elems(15).Name = 'foot_dx_b';
elems(15).DataType = 'double';

elems(16) = Simulink.BusElement;
elems(16).Name = 'foot_dy_b';
elems(16).DataType = 'double';

elems(17) = Simulink.BusElement;
elems(17).Name = 'ue_f';
elems(17).DataType = 'double';

elems(18) = Simulink.BusElement;
elems(18).Name = 'ur_f';
elems(18).DataType = 'double';

elems(19) = Simulink.BusElement;
elems(19).Name = 'ue_b';
elems(19).DataType = 'double';

elems(20) = Simulink.BusElement;
elems(20).Name = 'ur_b';
elems(20).DataType = 'double';

System = Simulink.Bus;
System.Elements = elems;

clear elems;

% system
elems(1) = Simulink.BusElement;
elems(1).Name = 'rf';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'phif';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'drf';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'dphif';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'rb';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'phib';
elems(6).DataType = 'double';

elems(7) = Simulink.BusElement;
elems(7).Name = 'drb';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'dphib';
elems(8).DataType = 'double';

Template = Simulink.Bus;
Template.Elements = elems;

clear elems;

% setpoint
elems(1) = Simulink.BusElement;
elems(1).Name = 'th_df';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'dth_df';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'phi_df';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'dphi_df';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'th_db';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'dth_db';
elems(6).DataType = 'double';

elems(7) = Simulink.BusElement;
elems(7).Name = 'phi_db';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'dphi_db';
elems(8).DataType = 'double';

Setpoint = Simulink.Bus;
Setpoint.Elements = elems;

% oscillator
elems(1) = Simulink.BusElement;
elems(1).Name = 'xf';
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'yf';
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'xb';
elems(3).DataType = 'double';

elems(4) = Simulink.BusElement;
elems(4).Name = 'yb';
elems(4).DataType = 'double';

elems(5) = Simulink.BusElement;
elems(5).Name = 'tstf';
elems(5).DataType = 'double';

elems(6) = Simulink.BusElement;
elems(6).Name = 'ytswf';
elems(6).DataType = 'double';

elems(7) = Simulink.BusElement;
elems(7).Name = 'tstb';
elems(7).DataType = 'double';

elems(8) = Simulink.BusElement;
elems(8).Name = 'tswb';
elems(8).DataType = 'double';

elems(9) = Simulink.BusElement;
elems(9).Name = 'kx';
elems(9).DataType = 'double';

Oscillator = Simulink.Bus;
Oscillator.Elements = elems;

clear elems;