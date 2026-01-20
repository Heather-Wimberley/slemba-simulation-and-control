%% Inertia
% https://www.mathworks.com/help/physmod/sm/ug/specify-custom-inertia.html
% NB: by default solidworks gives inertia tensor in positive notation
clc; clear;

Boom.Connector.mass = 0.228; %kg
Boom.Connector.CoM = [0.00 0.00 -14.19]; %[x y z] mm
Boom.Connector.MoI = [49031.36 109368.31 106547.59]; %[Lxx Lyy Lzz] gmm^2
Boom.Connector.PoI = [0.00 0.00 0.00]; %[Lyz Lzx Lxy] gmm^2

Boom.mass = 2.47066; % kg
Boom.length = 2.575;
Boom.CoM = [1149.01 0 0.46]; %mm
Boom.MoI = [1403119.37 1561987235.33 1561886539.18]; %gmm^2
Boom.massPoly = [-34.0773;11.3323;-1.3331;6.6056]; % polynominal generated from Simscape of boom
Boom.massForce = 20; % force in N used to get polynomial

Boom.force = -13.4029;
Boom.effectMass = abs(Boom.force)/9.81;
% Boom.force = 0;

Foot.r = 0.02;

Motor.Cover.mass = 0.71968; %kg
Motor.Cover.CoM = [-0.43,0.01,-22.77]; %[x y z] mm
Motor.Cover.MoI = [501930.12 501456.37 751646.27]; %[Lxx Lyy Lzz] gmm^2
Motor.Cover.PoI = [-166.63 17635.65 238.37]; %[Lyz Lzx Lxy] gmm^2

Femur.mass = 0.39106; % kg
Femur.CoM = [110.02 -6.93 20.92]; % [x y z] mm
Femur.MoI = [185002.98 3654417.11 2981115.38]; % [Lxx Lyy Lzz] gmm^2
Femur.PoI = [-374.85 6464.32 188188.40]; % [Lyz Lzx Lxy] gmm^2
Femur.length = 0.242; % m
Femur.offset = 0.038; % m

Tibia.mass = 0.172; % kg
Tibia.CoM = [-111.91 -0.70 0.07]; % [x y z] mm
Tibia.MoI = [20700.79 1219124.44 3667470.66]; % [Lxx Lyy Lzz] gmm^2
Tibia.PoI = [7.12 236.43 -7212.85]; % [Lyz Lzx Lxy] gmm^2
Tibia.length = 0.234; % m
Tibia.offset = 0.057; % m

Piston.Body.mass = 0.524; % kg
Piston.Body.CoM = [85.91 -0.15 0]; % [x y z] mm
Piston.Body.MoI = [92277.26 2129169.03 2130968.97]; % [Lxx Lyy Lzz] gmm^2
Piston.Body.PoI = [0 0 172.33]; % [Lyz Lzx Lxy] gmm^2
Piston.length = 216; % mm

Piston.Rod.mass = 0.184; % kg
Piston.Rod.CoM = [0 0 103.77]; % [x y z] mm
Piston.Rod.length = 174.698; % mm
Piston.Rod.MoI = [489976.18 489964.66 8816.04]; % [Lxx Lyy Lzz] gmm^2
Piston.Rod.PoI = [0 0 0]; % [Lyz Lzx Lxy] gmm^2

Body.mass = 0.92905; % kg
Body.CoM = [122.58 23.21 -31.62]; % [x y z] mm
Body.MoI = [2331242.80 7339346.24 8721223.02]; % [Lxx Lyy Lzz] gmm^2
Body.PoI = [113411.43 -3731574.93 1323812.41]; % [Lyz Lzx Lxy] gmm^2
Body.length_motor = [-127.64 0 65];

% additions of mass in 2 different positions
Mass1.mass = 0; % closer to boom attachment
Mass1.attach_length = 52.33; % [mm]
Mass2.mass = 0; % further from boom attachment
Mass2.attach_length = 112.33; % [mm]

%% Visual
mesh_color = [1.0 1.0 1.0 0.75]; % RGBA
foot_color = [0.3 0.3 0.3 1.0]; % RGBA
ground_color = [0.5 0.5 0.5 0.25]; % RGBA
Body.color = mesh_color;

Boom.Base.color = [1.0 1.0 1.0 1.0]; % RGBA
Boom.Center.color = [1.0 1.0 1.0 1.0]; % RGBA
Boom.Pole.color = [0.4 0.4 0.4 1.0]; % RGBA
Boom.End.color = [1.0 1.0 1.0 1.0]; % RGBA

%% Joints
Piston.Limit.lower = 0; % mm
Piston.Limit.upper = 70; % mm
Piston.Limit.stiffness = 1e8; % N/m
Piston.Limit.damping = 1e7; % Ns/m
Piston.Limit.transition_region_width = 1e-3; % m

%% Contacts
Contact.stiffness = 1e5; % N/m actual = 1e4N/m
Contact.damping = 1e4; % Ns/m actual = 1e3 Ns/m
% Contact.stiffness = 1e6; % N/m actual = 1e4N/m
% Contact.damping = 1e7; % Ns/m actual = 1e3 Ns/m
Contact.transition_region_width = 1e-2; % m actual = 1e-3m
Contact.mu_s = 1; % static friction
Contact.mu_d = 1; % dynamic friction
% Contact.mu_s = 3; % static friction
% Contact.mu_d = 3; % dynamic friction
Contact.mu_vth = 1e-3; % 1e-3 m/s

%% Planarising Boom
Boom.pitchRadius = 2.493; % m
Boom.yawRadius = 2.575; % m
Boom.pitchHeightOffset = 0.101; % m

%% AK70-10 Gearbox
T = 8e-3; % m
N = 6; % gear ratio

% Ring Gear Parameters
Ring.RGB = [1.0 1.0 1.0];
Ring.R = 23.75e-3; % m
Ring.Width = 4e-3; % m

% Sun Gear Parameters
Sun.RGB = [1.0 1.0 1.0];
Sun.R = Ring.R / (N*(1-1/N));
Sun.MoI = [0 0 1]; % [Lxx Lyy Lzz] gmm^2

% Planet Gear Parameters
Planet.RGB = [1.0 1.0 1.0];
Planet.R = (Ring.R-Sun.R)/2;
Planet.MoI = [0 0 1]; % [Lxx Lyy Lzz] gmm^2 (Degenerate mass otherwise...)

% Gear Carrier Parameters
Carrier.L = Sun.R + Planet.R;

% Rotor Parameters
Rotor.color = [1.0 1.0 1.0 1.0]; % RGBA
Rotor.MoI = [0 0 120000]; % [Lxx Lyy Lzz] gmm^2

Body.Solenoid.mass = 0.12; %kg

%% Initial Conditions Simscape
Body.x0 = 0; % m
Body.y0 = 0.2; % m 0.172
Body.r0 = 0; % rad

Boom.y0 = 0.5;%0.3; %
Boom.Yaw.q0 = 0; % rad
Boom.Pitch.q0 = asin((Boom.y0 - Boom.pitchHeightOffset)/Boom.pitchRadius); % rad
Boom.Roll.q0 = 0; % rad

Piston.p0 = 0; % m
Piston.v0 = 0; % m/s

Hip.q0 = -pi/2; % rad
Hip.w0 = 0; % rad/s

%% Initial Conditions ODE113
Sim.time = 2;

x0 = 0; y0 = 0.6; th0 = 0.61; l0 = 0;
dx0 = 0.5; dy0 = 0; dth0 = 0; dl0 = 0;

Init.q = [x0,y0,th0,l0];
Init.dq = [dx0,dy0,dth0,dl0];
