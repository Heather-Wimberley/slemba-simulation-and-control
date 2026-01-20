function [dx,dy] = CPG_Oscillator(x,y,y_foot,dy_foot,tst,tsw)
% constants
mu = 1;
F_1 = 50;%10;
F_2 = 10;
gamma = 10;

% if(dy_lift>0)
%     temp = load('fitdy1.mat');
%     trajopt_dyFit = temp.trajopt_dyFit;
%     if (feval(trajopt_dyFit,tst,dy_lift)>tst)
%         tsw = feval(trajopt_dyFit,tst,dy_lift);
%     end
% end

% large b
b = 100;
% params = hopf_Param(dy_lift,tst);
% T = 0.7661;
% d = 0.7650;
% tst = 0.12;
% tsw = 0.486;

T = tst + tsw;
d = tsw/T;
% T = 0.6394; % 0.75 working
% d = 0.7654; % 0.72 working with pi/2 extend cross over % pecentage in the air
% T = params(1); d = params(2);
k = 1; % 2 for extension at half way
e = 0;%0.4;

% 3 frequencies with quadrant crossover
omega_1 = (pi*k - 2*d*e + 2*d*e*k + pi)/(2*T*d*k);
omega_2 = k*omega_1;
omega_3 = (pi*k - 2*d*e + 2*d*e*k + pi)/(T - T*d + T*k - T*d*k);

% polar coordinates
r = sqrt(x^2 + y^2);
th = atan2(y,x);
% th = atan(y/x);
% if (x <= 0)
%     th = pi + atan(y/x);
% end

% 3 frequencies with quadrant cross over
k1 = omega_1/((exp(-b*(x+e))+1)*(exp(-b*y)+1));
k2 = omega_2/((exp(b*(x+e))+1)*(exp(-b*y)+1));
k3 = omega_3/(exp(b*y)+1);
omega = k1 + k2 + k3;

f = @(v) 1 + 0.5*cos(v)*tanh(sin(2*v));
f_dash = @(v) cos(v)*cos(2*v)*(sech(sin(2*v)))^2-0.5*sin(v)*tanh(sin(2*v));

% oscillation
dth = omega;
dr = mu*omega*f_dash(th) + gamma*(mu*f(th)-r);

% change in x
dx = dr*cos(th) - r*sin(th)*dth;

% control input to determine if the oscillation speed needs to be changed
% based on foot position
if (y_foot <= 0 && y > 0 && x < 0) % fast transition case 1
    % if (x<0)
    %     u = -F_1;
    % else 
    %     if (x>0.1)
    %         u = -F_2;
    %     else
    %         u = 0;
    %     end
    % end
    u = -F_1;
    % u = 0;
elseif(y_foot > 0 && y < 0 && x > 0) % fast transition case 3
    u = F_1;
elseif (y < 0 && dy_foot < 0 && y_foot > 0) % slow transition case 2
    u = - omega*x;
else
    u = 0;
end
    
% u = 0;
% oscillation
dy = dr*sin(th) + r*cos(th)*dth + u;

end