function out = F_calc(dt,ue,ur,l,dl)
    % piston force without damping and only in one direction. First order
    % response

    % piston at 0.7MPa
   
    % maximum force
    Fe_max = 529;
    Fr_max = -453;

    % damping
    c = (1-ue)*(1-ur)*48 + (1-ue)*ur*119 + ue*(1-ur)*174 + ur*ue*193;

    % time constant
    le = l; lr = 0.07 - l;
    taue = ((1-ue)*((0.07-le)/0.07)*13 + ue*((0.07-le)/0.07)*8 + (1-ue)*(le/0.07)*37 + ue*(le/0.07)*25)/1000;
    taur = ((1-ur)*((0.07-lr)/0.07)*13 + ur*((0.07-lr)/0.07)*8 + (1-ur)*(lr/0.07)*37 + ur*(lr/0.07)*25)/1000;

    % forces
    Fe = real(f_1D(ue,dt,taue,Fe_max));
    Fr = real(f_1D(ur,dt,taur,Fr_max));
    out = Fe + Fr - c*dl;
end