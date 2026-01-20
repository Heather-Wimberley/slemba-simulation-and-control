function out = grf_calc(foot) %from sprinting biped paper
    x = foot(1); y = foot(2); dx = foot(3); dy = foot(4);

    xf1 = x; yf1 = y; vxf1 = dx; vyf1 = dy;

    mu = 0.6; % was 0.5 
    divi = 0.05; % was 0.05, then 0.1
    a = 5*10^6; % was 5*10^7
    b = 1; % was 1
    bg = 100; % was 50 ground damping [s/m]
    pen1 = -yf1.*(0.5*(1+tanh(-yf1/divi*5)));
    dpen1 = -vyf1.*(0.5*(1+tanh(-yf1/divi*5)));
    GRFy1 = a*pen1.^3.*(1+b*dpen1);
    GRFx1 = mu*GRFy1.*tanh(vxf1/divi)+(bg*vxf1).*(0.5*(1+tanh(-yf1/divi)));

    a = 5*10^7;
    b = 0.75;
    u = 0.6;
    c = 50;% c = 50; 
    % a = 1*10^5;
    % b = 10;
    % u = 0.5;
    % c = 0.5;

    % if (isempty(a) == 1)
    %     parameters_Monoped;
    %     % 
    %     a = 1*10^8; % spring value of contact
    %     b = Normal.damp; % damping of contact
    %     u = 2;
    %     c = 2;
    % end
    yf = y;

    phi = -yf*H(-5*yf);
    dphi = -dy*H(-5*yf);

    GRFy = a*phi^3*(1+b*dphi);

    GRFx = u*GRFy*sign(-dx) + c*dx*H(-yf);

    out = [-GRFx1;GRFy1];
end

function out = H(x)
    if(x>0)
        out = 1;
    else
        out = 0;
    end
end

function out = sign(x)
    if (x>0)
        out = 1;
    else
        if (x<0)
            out = -1;
        else
            out = 0;
        end
    end
end
