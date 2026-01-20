%% Inertia
% https://www.mathworks.com/help/physmod/sm/ug/specify-custom-inertia.html
% NB: by default solidworks gives inertia tensor in positive notation
Boom.Connector.mass = 0.22617; %kg
Boom.Connector.CoM = [0.00 3.12 0.00]*1e-3; %[x y z] m
Boom.Connector.MoI = [235091.30 135027.95 223047.70]*1e-9; %[Lxx Lyy Lzz] kgm^2
Boom.Connector.PoI = [1.68 0.02 0.71]*1e-9; %[Lyz Lzx Lxy] kgm^2

Motor.Cover.mass = 0.71968; %kg
Motor.Cover.CoM = [-0.43,0.01,-22.77]*1e-3; %[x y z] m
Motor.Cover.MoI = [501930.12 501456.37 751646.27]*1e-9; %[Lxx Lyy Lzz] kgm^2
Motor.Cover.PoI = [-166.63 17635.65 238.37]*1e-9; %[Lyz Lzx Lxy] kgm^2

Femur.mass = 0.39106; % kg
Femur.CoM = [110.02 -6.93 20.92]*1e-3; % [x y z] m
Femur.MoI = [185002.98 3654417.11 2981115.38]*1e-9; % [Lxx Lyy Lzz] kgm^2
Femur.PoI = [-374.85 6464.32 188188.40]*1e-9; % [Lyz Lzx Lxy] kgm^2
Femur.length = 0.242; % m
Femur.offset = 0.038; % m

Tibia.mass = 0.172; % kg
Tibia.CoM = [-111.91 -0.70 0.07]*1e-3; % [x y z] m
Tibia.MoI = [20700.79 1219124.44 3667470.66]*1e-9; % [Lxx Lyy Lzz] kgm^2
Tibia.PoI = [7.12 236.43 -7212.85]*1e-9; % [Lyz Lzx Lxy] gkgm^2
Tibia.length = 0.234; % m
Tibia.offset = 0.057; % m

Piston.Body.mass = 0.524; % kg
Piston.Body.CoM = [85.91 -0.15 0]*1e-3; % [x y z] m
Piston.Body.MoI = [92277.26 2129169.03 2130968.97]*1e-9; % [Lxx Lyy Lzz] kgm^2
Piston.Body.PoI = [0 0 172.33]*1e-9; % [Lyz Lzx Lxy] kgm^2
Piston.length = 0.221; % m

Piston.Rod.mass = 0.184; % kg
% Piston.Rod.CoM = [0 0 73.77]*1e-3; % [x y z] m
Piston.Rod.CoM = [0 0 103.77]*1e-3; % [x y z] m
Piston.Rod.MoI = [489976.18 489964.66 8816.04]*1e-9; % [Lxx Lyy Lzz] kgm^2
Piston.Rod.PoI = [0 0 0]*1e-9; % [Lyz Lzx Lxy] kgm^2

%% Joints
Piston.Limit.lower = 0; % mm
Piston.Limit.upper = 70; % mm
Piston.Limit.stiffness = 1e7; % N/m
Piston.Limit.damping = 1e7; % Ns/m
Piston.Limit.transition_region_width = 1e-3; % m

%% Contacts
Contact.stiffness = 1e4; % N/m actual = 1e4N/m
Contact.damping = 1e3; % Ns/m actual = 1e3 Ns/m
Contact.transition_region_width = 1e-3; % m actual = 1e-3m
Contact.mu_s = 1.2; % static friction
Contact.mu_d = 1.2; % dynamic friction
Contact.mu_vth = 1e-4; % m/s

%% Planarising Boom
Boom.pitchRadius = 2.493; % m
Boom.yawRadius = 2.575; % m
Boom.pitchHeightOffset = 0.101; % m

%% Spine Parameters

%Piston Body
Spine.PistonBody.mass = 0.458;  % kg
Spine.PistonBody.CoM = [159.05529650365344 -0.17222702625008443 -1.0027454077384203e-05]*1e-3;  % m
Spine.PistonBody.MoI = [6.261714278229233 784.94160991314243 785.05397331182439]*1e-6;  % kg*m^2
Spine.PistonBody.PoI = [1.096836336880277e-06 -7.0783452908391498e-05 0.047651833528736497]*1e-6;  % kg*m^2
Spine.PistonBody.length = 378.1*1e-3; % m length from back motor to front end of piston body

%Spine Rod
Spine.PistonRod.mass = 0.191;  % kg
Spine.PistonRod.CoM = [5.1438135152414795e-10 2.4438112911257237e-10 -130.27462331377629]*1e-3;  % m
Spine.PistonRod.MoI = [198.70008471605013 198.69980382580869 0.51337017404520813]*1e-6;  % kg*m^2
Spine.PistonRod.PoI = [-6.8492074022479536e-10 -1.441844877482857e-09 -8.7105710739977544e-09]*1e-6;  % kg*m^2

%% Spine Reduced
Spine.LeftBody.mass = 1.21794; %kg
Spine.LeftBody.CoM = [209.34 0.02 -37.74]*1e-3; % m
Spine.LeftBody.MoI = [2653.71281e-6 16378.75434e-6 17484.89419e-6];  % kg*m^2
Spine.LeftBody.PoI = [-3.72088e-6 -160.01821e-6 3.97971e-6];  % kg*m^2
Spine.LeftBody.length = 0.198;

Spine.RightBody.mass = 0.54341; %kg
Spine.RightBody.CoM = [-109.33 0.06 34.94]*1e-3;% m
Spine.RightBody.MoI = [925.41477e-6 5125.19047e-6 5542.62791e-6];  % kg*m^2
Spine.RightBody.PoI = [0.42259e-6 90.85022e-6 -2.43643e-6];  % kg*m^2
Spine.RightBody.length = 0.318;

Spine.EnergyChain.mass = 0.361; % kg
Spine.Solenoid.mass = 0.12; % kg

%% Initial Conditions
init.x = 0;
init.y = 0.5;
init.r = 0;
init.thf = 0.6;
init.lf = 0;
init.thb = 0.6;
init.lb = 0;

Init.q = [init.x,init.y,init.r,init.thf,init.lf,init.thb,init.lb];

init.dx = 0;
init.dy = 0;
init.dr = 0;
init.dthf = 0;
init.dlf = 0;
init.dthb = 0;
init.dlb = 0;

Init.dq = [init.dx,init.dy,init.dr,init.dthf,init.dlf,init.dthb,init.dlb];

Init.CPG = [0,1,0,1];

Sim.time = 5;