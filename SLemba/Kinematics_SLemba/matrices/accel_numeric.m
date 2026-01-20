function ddq = accel_numeric(q,dq,u)
x = q(1); y = q(2); th = q(3); l = q(4); thk = q(5); tha = q(6);
dx = dq(1); dy = dq(2); dth = dq(3); dl = dq(4); dthk = dq(5); dtha = dq(6);
t = u(1); f = u(2);

f_up = 0;

% torque limiting
t = speedTorque(t,dth);

M = M_func(x,y,th,l,thk,tha);
C = C_func(x,y,th,l,thk,tha,dx,dy,dth,dl,dthk,dtha);
G = G_func(x,y,th,l,thk,tha);

foot = foot_Func(x,y,th,l,thk,tha,dx,dy,dth,dl,dthk,dtha);
grf = grf_calc(foot);
f_end = end_calc(l,dl);

Q_partial = Q_Partial_func(th,thk,t,f,grf(1),grf(2),f_end,y,dy);% + [0;f_up;0;0;0;0];
H = H_func(x,y,th,l,thk,tha);
dH = dH_func(x,y,th,l,thk,tha,dx,dy,dth,dl,dthk,dtha);

f_c = -(H*(M\transpose(H)))\(H*(M\(Q_partial - C - G)) + dH*dq);

Q = Q_func(x,y,th,l,thk,tha,t,f,grf(1),grf(2),f_end,f_c(1),f_c(2),dy);% + [0;f_up;0;0;0;0];

ddq = M\(-G-C+Q);
end