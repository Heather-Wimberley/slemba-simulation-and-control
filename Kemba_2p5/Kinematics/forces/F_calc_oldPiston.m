function out = F_calc_oldPiston(dt,ue,ur,l,dl)
    % piston force without damping and only in one direction. First order
    % response

    % piston at 0.7MPa
   
    % maximum force
    Fe_max = 324;
    Fr_max = -260;

    % damping
    c = (1-ue)*(1-ur)*25 + (1-ue)*ur*84 + ue*(1-ur)*97 + ur*ue*59;

    % time constant
    le = l; lr = 0.07 - l;
    taue = ((1-ue)*((0.07-le)/0.07)*13 + ue*((0.07-le)/0.07)*8 + (1-ue)*(le/0.07)*37 + ue*(le/0.07)*25)/1000;
    taur = ((1-ur)*((0.07-lr)/0.07)*13 + ur*((0.07-lr)/0.07)*8 + (1-ur)*(lr/0.07)*37 + ur*(lr/0.07)*25)/1000;

    % forces
    Fe = f_1D(ue,dt,taue,Fe_max);
    Fr = f_1D(ur,dt,taur,Fr_max);
    out = Fe + Fr - c*dl;
end