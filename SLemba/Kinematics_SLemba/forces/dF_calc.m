function out = dF_calc(q,ue,ur,l)
    % piston at 0.7MPa

    Fe = q(1);
    Fr = q(2);
   
    % maximum force
    Fe_max = 529;
    Fr_max = -453;

    % time constant
    le = l; lr = 0.07 - l;
    taue = ((1-ue)*((0.07-le)/0.07)*13 + ue*((0.07-le)/0.07)*8 + (1-ue)*(le/0.07)*37 + ue*(le/0.07)*25)/1000;
    taur = ((1-ur)*((0.07-lr)/0.07)*13 + ur*((0.07-lr)/0.07)*8 + (1-ur)*(lr/0.07)*37 + ur*(lr/0.07)*25)/1000;

    % forces
    dF_e = (Fe_max*ue - Fe)/taue;
    dF_r = (Fr_max*ur - Fr)/taur;
    
    out = [dF_e;dF_r];
end