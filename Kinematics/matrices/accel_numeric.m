function ddq = accel_numeric(q,dq,u)
x = q(1); y = q(2); r = q(3);
thf = q(4); lf = q(5); thkf = q(6); thaf = q(7);
thb = q(8); lb = q(9); thkb = q(10); thab = q(11);
dx = dq(1); dy = dq(2); dr = dq(3);
dthf = dq(4); dlf = dq(5); dthkf = dq(6); dthaf = dq(7);
dthb = dq(8); dlb = dq(9); dthkb = dq(10); dthab = dq(11);
tf = u(1); ff = u(2);
tb = u(3); fb = u(4);

M = M_func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab);
C = C_func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab,dx,dy,dr,dthf,dlf,dthkf,dthaf,dthb,dlb,dthkb,dthab);
G = G_func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab);

foot = foot_Func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab,dx,dy,dr,dthf,dlf,dthkf,dthaf,dthb,dlb,dthkb,dthab);
grf_f = grf_calc(foot(:,1));
grf_b = grf_calc(foot(:,2));
f_endf = end_calc(lf,dlf);
f_endb = end_calc(lb,dlb);

Q_partial = Q_Partial_func(r,thf,thkf,thb,thkb,tf,ff,tb,fb,grf_f(1),grf_f(2),grf_b(1),grf_b(2),f_endf,f_endb);
H = H_func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab);
dH = dH_func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab,dx,dy,dr,dthf,dlf,dthkf,dthaf,dthb,dlb,dthkb,dthab);

f_c = -(H*(M\transpose(H)))\(H*(M\(Q_partial - C - G)) + dH*dq);

Q = Q_func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab,tf,ff,tb,fb,grf_f(1),grf_f(2),grf_b(1),grf_b(2),f_endf,f_endb,f_c(1),f_c(2),f_c(3),f_c(4));

ddq = M\(-G-C+Q);
end