function out = end_calc(l,dl) %from sprinting biped paper

    % function adapted from ground reaction forces
    a = 5*10^10;
    b = 0.6;

    if (l>0.07)
        phi = - l + 0.07;
        dphi = dl;
        a = 1*10^12;
        b = 10;
    else 
        if (l<0)
            phi = - l;
            dphi = - dl;
            a = 1*10^12;
            b = 10;
        else
            phi = 0;
            dphi = 0;
        end
    end

    out = a*phi^3*(1+b*dphi);

    % out = phi*a + dphi*b;

end
