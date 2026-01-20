%% Inertia
% https://www.mathworks.com/help/physmod/sm/ug/specify-custom-inertia.html
% NB: by default solidworks gives inertia tensor in positive notation
Boom.Connector.mass = 0.22617; %kg
Boom.Connector.CoM = [0.00 3.12 0.00]; %[x y z] mm
Boom.Connector.MoI = [235091.30 135027.95 223047.70]; %[Lxx Lyy Lzz] gmm^2
Boom.Connector.PoI = [1.68 0.02 0.71]; %[Lyz Lzx Lxy] gmm^2

Motor.Cover.mass = 0.72462; %kg
Motor.Cover.CoM = [0.63 0.01 16.17]; %[x y z] mm
Motor.Cover.MoI = [505363.21 505192.66 760626.29]; %[Lxx Lyy Lzz] gmm^2
Motor.Cover.PoI = [74.57 11463.43 -259.40]; %[Lyz Lzx Lxy] gmm^2

Femur.Right.mass = 0.33290; % kg
Femur.Right.CoM = [95.03 4.24 19.71]; % [x y z] mm
Femur.Right.MoI = [119296.69 2970311.77 2981115.38]; % [Lxx Lyy Lzz] gmm^2
Femur.Right.PoI = -[3907.50 93117.38 -72966.52]; % [Lyz Lzx Lxy] gmm^2

Femur.Left.mass = 0.33290; % kg
Femur.Left.CoM = [95.03 -4.24 19.71]; % [x y z] mm
Femur.Left.MoI = [119296.69 2970311.77 2981115.38]; % [Lxx Lyy Lzz] gmm^2
Femur.Left.PoI = -[-3907.50 93117.38 72966.52]; % [Lyz Lzx Lxy] gmm^2

Tibia.mass = 0.15924; % kg
Tibia.CoM = [-109.44 -0.68 0.05]; % [x y z] mm
Tibia.MoI = [20796.07 1261060.35 1264673.14]; % [Lxx Lyy Lzz] gmm^2
Tibia.PoI = -[5.80 522.67 -6951.40]; % [Lyz Lzx Lxy] gmm^2

Piston.Body.mass = 0.22970; % kg
Piston.Body.CoM = [75.20 2.59 0.14]; % [x y z] mm
Piston.Body.MoI = [32528.09 763808.27 777104.29]; % [Lxx Lyy Lzz] gmm^2
Piston.Body.PoI = -[769.93 23.49 675.15]; % [Lyz Lzx Lxy] gmm^2

Piston.Rod.mass = 0.07112; % kg
Piston.Rod.CoM = [0 0 77.90]; % [x y z] mm
Piston.Rod.MoI = [225318.30 225248.46 1949.13]; % [Lxx Lyy Lzz] gmm^2
Piston.Rod.PoI = -[0 0 0]; % [Lyz Lzx Lxy] gmm^2

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

%% Spine Parameters

%Linear Bearing
Spine.LinearBearing.mass = 0.031153084662319433;  % kg
Spine.LinearBearing.CoM = [-5.0000000000000009 3.9799296750568307 -20];  % mm
Spine.LinearBearing.MoI = [4.878079777170524 2.525677341729363 5.763428200573097];  % kg*mm^2
Spine.LinearBearing.PoI = [0 0 0];  % kg*mm^2
Spine.LinearBearing.color = [0.89803921568627454 0.91764705882352937 0.92941176470588238];
Spine.LinearBearing.opacity = 1;
% Spine.LinearBearing.ID = "8mm Linear Bearing Rail Shaft Support*:*Default";

%Piston Body
Spine.PistonBody.mass = 0.458;  % kg
Spine.PistonBody.CoM = [159.05529650365344 -0.17222702625008443 -1.0027454077384203e-05];  % mm
Spine.PistonBody.MoI = [6.261714278229233 784.94160991314243 785.05397331182439];  % kg*mm^2
Spine.PistonBody.PoI = [1.096836336880277e-06 -7.0783452908391498e-05 0.047651833528736497];  % kg*mm^2
Spine.PistonBody.color = [0.75686274509803919 0.76862745098039209 0.75294117647058822];
Spine.PistonBody.opacity = 1;
% Spine.Body.ID = "559289 DSNU-25-200-PPS---(A----0-ZR)*:*Default";

%Spine Rod
Spine.PistonRod.mass = 0.191;  % kg
Spine.PistonRod.CoM = [5.1438135152414795e-10 2.4438112911257237e-10 -130.27462331377629];  % mm
Spine.PistonRod.MoI = [198.70008471605013 198.69980382580869 0.51337017404520813];  % kg*mm^2
Spine.PistonRod.PoI = [-6.8492074022479536e-10 -1.441844877482857e-09 -8.7105710739977544e-09];  % kg*mm^2
Spine.PistonRod.color = [0.75686274509803919 0.76862745098039209 0.75294117647058822];
Spine.PistonRod.opacity = 1;
% Spine.Rod.ID = "559289 DSNU-25-200-PPS---(A---00--0-KS)*:*Default";

%Piston Insert
Spine.Insert.mass = 2.8507684619897092e-13;  % kg
Spine.Insert.CoM = [15 -10.670505137099285 0];  % mm
Spine.Insert.MoI = [0 0 0];  % kg*mm^2
Spine.Insert.PoI = [0 0 0];  % kg*mm^2
Spine.Insert.color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
Spine.Insert.opacity = 1;
% Spine.Insert.ID = "spine_piston_insert*:*Default";

%Piston End Stop Bearings
Spine.EndStop.mass = 0.049328859194049612;  % kg
Spine.EndStop.CoM = [-10.065262227128819 6.3051159044684217 2.767634643442624e-10];  % mm
Spine.EndStop.MoI = [8.7495752728602536 5.8272489557567555 11.974953025835163];  % kg*mm^2
Spine.EndStop.PoI = [0 0 0.041381563216542572];  % kg*mm^2
Spine.EndStop.color = [0.89803921568627454 0.91764705882352937 0.92941176470588238];
Spine.EndStop.opacity = 1;
% Spine.EndStop.ID = "8mm End Stop Bearing Rail Shaft Support*:*Default";

%Piston Mounting
Spine.Mounting.mass = 0.011935209898797658;  % kg
Spine.Mounting.CoM = [7.7958665411523542 11.995875965112157 -1.0521160952728112e-07];  % mm
Spine.Mounting.MoI = [4.4612598351418828 3.2101450837163905 2.5121091055742655];  % kg*mm^2
Spine.Mounting.PoI = [-1.1957888194337839e-08 -5.732876469147166e-09 0.59973350504666834];  % kg*mm^2
Spine.Mounting.color = [0.75686274509803919 0.76862745098039209 0.75294117647058822];
Spine.Mounting.opacity = 1;
% Spine.Mounting.ID = "5128 HBN-20_25x2---*:*Default";

% Spine Left Front Plate
Spine.LeftFront.mass = 0.47123336679011285;  % kg
Spine.LeftFront.CoM = [-60.64040784050961 -0.10794888171539058 -19.461235340286105];  % mm
Spine.LeftFront.MoI = [1065.0880715388239 6377.0071552010531 7020.4019111883081];  % kg*mm^2
Spine.LeftFront.PoI = [0.086417069536466634 -29.775363107497647 -0.82610577177669542];  % kg*mm^2
Spine.LeftFront.color = [0.89411764705882346 0.9137254901960784 0.92941176470588238];
Spine.LeftFront.opacity = 1;
% Spine.LeftFront.ID = "left_spine_front*:*Default";

%Spine Left Back Plate
Spine.LeftBack.mass = 0.46972155743887639;  % kg
Spine.LeftBack.CoM = [-148.45596167810513 -0.090530687199485094 18.220565491121945];  % mm
Spine.LeftBack.MoI = [1000.5892635000853 6407.959839723907 6967.140261907889];  % kg*mm^2
Spine.LeftBack.PoI = [1.6968600223557992 4.5938559311864049 -1.5780135938671276];  % kg*mm^2
Spine.LeftBack.color = [0.89803921568627454 0.91764705882352937 0.92941176470588238];
Spine.LeftBack.opacity = 1;
% Spine.LeftBack.ID = "left_spine_back*:*Default";

%Support Spacer
Spine.Spacer.mass = 0.0078927920759197107;  % kg
Spine.Spacer.CoM = [0 0.27207553901147047 2.5000000000000004];  % mm
Spine.Spacer.MoI = [0.44067164238047002 1.8580086979252206 2.2657937066560256];  % kg*mm^2
Spine.Spacer.PoI = [0 0 0];  % kg*mm^2
Spine.Spacer.color = [0.69803921568627447 0.69803921568627447 0.69803921568627447];
Spine.Spacer.opacity = 1;
% Spine.Spacer.ID = "Piston Support Spacer*:*Default";

%Right Back Plate
Spine.RightBack.mass = 0.13679525495136124;  % kg
Spine.RightBack.CoM = [-201.18113415427698 -0.12526239973680814 -20.180850271596992];  % mm
Spine.RightBack.MoI = [318.74500831848798 223.33056025695348 419.14257129818475];  % kg*mm^2
Spine.RightBack.PoI = [-0.31561769148156515 -7.9758930275471434 -0.014031513486604114];  % kg*mm^2
Spine.RightBack.color = [0.89411764705882346 0.9137254901960784 0.92941176470588238];
Spine.RightBack.opacity = 1;
% Spine.RightBack.ID = "right_spine_back*:*Default";

%Connecting Rod
Spine.ConnectingRod.mass = 0.16021793667126386;  % kg
Spine.ConnectingRod.CoM = [0.20855281011591378 24.997664722745853 0];  % mm
Spine.ConnectingRod.MoI = [146.34083479846785 127.24795368913188 103.29030237153322];  % kg*mm^2
Spine.ConnectingRod.PoI = [0 0 -0.36763094088421472];  % kg*mm^2
Spine.ConnectingRod.color = [0.89803921568627454 0.91764705882352937 0.92941176470588238];
Spine.ConnectingRod.opacity = 1;
% Spine.ConnectingRod.ID = "New Connecting Rod*:*Default";

%Supporting Rod
Spine.SupportRod.mass = 0.15019584895976237;  % kg
Spine.SupportRod.CoM = [-188.38745264101914 -2.5750948071696584e-05 -5.4215826621842014e-07];  % mm
Spine.SupportRod.MoI = [1.1899063077545629 1841.4670761304003 1841.4670815864386];  % kg*mm^2
Spine.SupportRod.PoI = [3.8327330106852658e-07 1.4768219798036613e-05 0.00075685167360583627];  % kg*mm^2
Spine.SupportRod.color = [0.77647058823529413 0.75686274509803919 0.73725490196078436];
Spine.SupportRod.opacity = 1;
% Spine.SupportRod.ID = "8mm 200mm stroke rod*:*Default";

%PTFE Sleeve
Spine.PTFE.mass = 0.00072884949563283181;  % kg
Spine.PTFE.CoM = [5 0 0];  % mm
Spine.PTFE.MoI = [0.018403449764729001 0.015275470679304768 0.01527547067930477];  % kg*mm^2
Spine.PTFE.PoI = [0 0 0];  % kg*mm^2
Spine.PTFE.color = [1 1 1];
Spine.PTFE.opacity = 1;
% Spine.PTFE.ID = "PTFE_sleeve*:*Default";

%Spine Right Front Plate
Spine.RightFront.mass = 0.13776452755258486;  % kg
Spine.RightFront.CoM = [0.093653003110881011 -0.078052065018045971 -19.436292907356215];  % mm
Spine.RightFront.MoI = [288.39447937209229 222.39991482186821 387.46875858108211];  % kg*mm^2
Spine.RightFront.PoI = [-0.27921541470684569 -0.21617239429615318 -0.027659479964316089];  % kg*mm^2
Spine.RightFront.color = [0.89803921568627454 0.91764705882352937 0.92941176470588238];
Spine.RightFront.opacity = 1;
% Spine.RightFront.ID = "right_spine_front*:*Default";

%% Spine Reduced
Spine.LeftBody.mass = 1.21794; %kg
Spine.LeftBody.CoM = [209.34 0.02 -37.74];%[209.34 0.02 -37.74]; % mm
Spine.LeftBody.MoI = [2653.71281e-6 16378.75434e-6 17484.89419e-6];  % kg*m^2
Spine.LeftBody.PoI = [-3.72088e-6 -160.01821e-6 3.97971e-6];  % kg*m^2
Spine.LeftBody.color = [1.0 1.0 1.0 0.75]; % RGBA;
Spine.LeftBody.opacity = 1;

Spine.RightBody.mass = 0.54341; %kg
Spine.RightBody.CoM = [-109.33 0.06 34.94];% % mm
Spine.RightBody.MoI = [925.41477e-6 5125.19047e-6 5542.62791e-6];  % kg*m^2
Spine.RightBody.PoI = [0.42259e-6 90.85022e-6 -2.43643e-6];  % kg*m^2
Spine.RightBody.color = [1.0 1.0 1.0 0.75]; % RGBA;
Spine.RightBody.opacity = 1;

Spine.EnergyChain.mass = 0.361; % kg
Spine.Solenoid.mass = 0.12; %kg

%% Initial Conditions
Body.x0 = 0; % m
Body.y0 = 0.18; % m 0.172
Body.r0 = 0; % rad

Boom.y0 = 0.18; %
Boom.Yaw.q0 = 0; % rad
Boom.Pitch.q0 = asin((Boom.y0 - Boom.pitchHeightOffset)/Boom.pitchRadius); % rad
Boom.Roll.q0 = 0; % rad

Piston.Right.p0 = 0; % m
Piston.Right.v0 = 0; % m/s
Piston.Left.p0 = 0; % m
Piston.Left.v0 = 0; % m/s
Piston.Spine.p0 = 0; %m
Piston.Spine.v0 = 0; %m/s

Hip.Right.q0 = -1.0*0.23*pi; % rad
Hip.Right.w0 = 0; % rad/s
Hip.Left.q0 = -1.0*0.23*pi; % rad
Hip.Left.w0 = 0; % rad/s
