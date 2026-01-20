%% Inertia
% https://www.mathworks.com/help/physmod/sm/ug/specify-custom-inertia.html
% NB: by default solidworks gives inertia tensor in positive notation
Boom.Connector.mass = 0.228; %kg
Boom.Connector.CoM = [0.00 0.00 -14.19]; %[x y z] mm
Boom.Connector.MoI = [49031.36 109368.31 106547.59]; %[Lxx Lyy Lzz] gmm^2
Boom.Connector.PoI = [0.00 0.00 0.00]; %[Lyz Lzx Lxy] gmm^2

Foot.r = 0.02;

Boom.mass = 2.47066; % kg
Boom.length = 2.575; % m
Boom.MoI = [1403119.37 1561987235.33 1561886539.18]; %gmm^2
Boom.CoM = [1149.01 0 0.46]; %mm

Boom.force = -13.4029;
Boom.effectMass = abs(Boom.force)/9.81;
% Boom.force = 0;

Body.mass = 0.92905; % kg
Body.CoM = [122.58 23.21 -31.62]; % [x y z] mm
Body.MoI = [2331242.80 7339346.24 8721223.02]; % [Lxx Lyy Lzz] gmm^2
Body.PoI = [113411.43 -3731574.93 1323812.41]; % [Lyz Lzx Lxy] gmm^2
Body.length_motor = [-127.64 0 65]; % mm

% additions of mass in 2 different positions
Mass1.mass = 0; % closer to boom attachment
Mass1.attach_length = 52.33; % [mm]
Mass2.mass = 0; % further from boom attachment
Mass2.attach_length = 112.33; % [mm]

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
Piston.Rod.length = 174.698; % mm
% Piston.Rod.CoM = [0 0 73.77]*1e-3; % [x y z] m
Piston.Rod.CoM = [0 0 103.77]; % [x y z] mm
Piston.Rod.MoI = [489976.18 489964.66 8816.04]; % [Lxx Lyy Lzz] gmm^2
Piston.Rod.PoI = [0 0 0]; % [Lyz Lzx Lxy] gmm^2

%% Joints
Piston.Limit.lower = 0; % mm
Piston.Limit.upper = 70; % mm
Piston.Limit.stiffness = 1e6; % N/m
Piston.Limit.damping = 1e3; % Ns/m
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

%% Reduction for monoped
% get mass for 4 bodies in body: left, right piston body, piston rod
mBodyL = Spine.LeftBody.mass + 2 * Spine.Solenoid.mass + Spine.EnergyChain.mass;
mBodyR = Spine.RightBody.mass + 4 * Spine.Solenoid.mass + Spine.EnergyChain.mass;
mPistonB = Spine.PistonBody.mass;
mPistonR = Spine.PistonBody.mass;

% get position of x coord cog (using center of back hip as x = 0)
cBodyL = Spine.LeftBody.CoM(1);
cBodyR = Spine.RightBody.CoM(1) + Spine.RightBody.length + Spine.LeftBody.length;
cPistonB = Spine.PistonBody.length - Spine.PistonBody.CoM(1);
cPistonR = Spine.PistonBody.length + Spine.PistonRod.CoM(3);


cg_t = (mBodyL*cBodyL + mBodyR*cBodyL + mPistonB*cPistonB + mPistonR*cPistonR)/(mBodyL + mBodyR + mPistonR + mPistonB);

% Initial Variables
Init.x = 0;
Init.y = 0.6;

Init.l = 0;
% Init.thk = thk_calc(Init.th,Init.l);
% Init.tha = tha_calc(Init.th,Init.l);



Init.dx = 0.6;
Init.dy = 0;
Init.dth = 0;
Init.dl = 0;
% Init.dthk = dthk_calc(Init.th,Init.l,Init.dth,Init.dl);
% Init.dtha = dtha_calc(Init.th,Init.l,Init.dth,Init.dl);

Init.dq = [Init.dx,Init.dy,Init.dth,Init.dl];

% Initial Variables for CPG
T = 0.7661;
d = 0.7650; % pecentage in the air
k = 1; % 2 for extension at half way
e = 0;%0.4;
omega_1 = (pi*k - 2*d*e + 2*d*e*k + pi)/(2*T*d*k);
omega_2 = k*omega_1;

T_fall = 0.25;
th_osc = pi-T_fall*omega_2;
Init.x_osc = cos(th_osc);%-0.1; % x
Init.y_osc = sin(th_osc);%1; % y
Init.dx_osc = 0;
Init.dy_osc = 0;

Init.CPG = [Init.x_osc,Init.y_osc];

Init.th = 0;%th_calc(pi/2-0.1*Init.x_osc,0);

Init.q = [Init.x,Init.y,Init.th,Init.l];

Sim.time = 4;

function out = sign(x)
    if (x>0)
        out = 1;
    else 
        out = -1;
    end
end