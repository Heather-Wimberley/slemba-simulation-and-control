function out = F_calc_dF(Fe,Fr,ue,ur,dl)

    % damping
    c = (1-ue).*(1-ur).*48 + (1-ue).*ur.*119 + ue.*(1-ur).*174 + ur.*ue.*193;

    out = Fe + Fr - c.*dl;

end