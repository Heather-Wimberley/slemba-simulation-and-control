function dy_d = calculateIdealOscDY(x,y,tst,tsw,c,y_other)
% constants
mu = 1;
gamma = 10;

% large b
b = 100;
k = 1; % 2 for extension at half way
e = 0;

T = tst + tsw;
d = tsw/T;
omega_1 = (pi*k - 2*d*e + 2*d*e*k + pi)/(2*T*d*k);
omega_2 = k*omega_1;
omega_3 = (pi*k - 2*d*e + 2*d*e*k + pi)/(T - T*d + T*k - T*d*k);

k1 = omega_1/((exp(-b*(x+e))+1)*(exp(-b*y)+1));
k2 = omega_2/((exp(b*(x+e))+1)*(exp(-b*y)+1));
k3 = omega_3/(exp(b*y)+1);
omega = k1 + k2 + k3;

% polar coordinates
r = sqrt(x^2 + y^2);
th = atan(y/x);
if (x <= 0)
    th = pi + atan(y/x);
end

f = @(v) 1 + 0.5*cos(v)*tanh(sin(2*v));
f_dash = @(v) cos(v)*cos(2*v)*(sech(sin(2*v)))^2-0.5*sin(v)*tanh(sin(2*v));

% oscillation
dth = omega;
dr = mu*omega*f_dash(th) + gamma*(mu*f(th)-r);

dy_d = dr*sin(th) + r*cos(th)*dth + + c*y_other;
end