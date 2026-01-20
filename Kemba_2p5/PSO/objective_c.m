function cost = objective_c(decVar,P)

init.c = decVar(1);
init.y = decVar(2);
init.r = decVar(3);
init.dx = decVar(4);
init.dr = decVar(5);
init.x_oscf = decVar(6);
init.y_oscf = decVar(7);
init.x_oscb = decVar(8);
init.y_oscb = decVar(9);

temp = load("tsw_fits\fit_front.mat","fit_front");
tswf_fit = temp.fit_front;
temp = load("tsw_fits\fit_back.mat","fit_back");
tswb_fit = temp.fit_back;

P.tswf = feval(tswf_fit,P.tstf,P.kx);
P.tswb = feval(tswb_fit,P.tstb,P.kx);

P.time = P.tswf + P.tstf;

sim = simulateFull(init,P);

cost = sum(sim.r.^2);

tol = P.constraintTol;

% include ending conditions
cost = cost + max(10^10*(abs(sim.y(1) - sim.y(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.dx(1) - sim.dx(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.dy(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.r(1) - sim.r(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.dr(1) - sim.dr(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.x_oscf(1) - sim.x_oscf(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.y_oscf(1) - sim.y_oscf(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.x_oscb(1) - sim.x_oscb(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.y_oscb(1) - sim.y_oscb(end)) - tol),0);

end