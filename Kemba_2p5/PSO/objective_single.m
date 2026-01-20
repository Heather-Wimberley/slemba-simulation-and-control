function cost = objective_single(decVar,P)

init.x_oscf = decVar(1);
init.y_oscf = decVar(2);
init.x_oscb = decVar(3);
init.y_oscb = decVar(4);
init.y = decVar(5);
init.tswf = decVar(6);
init.tswb = decVar(7);
init.dx = decVar(8);
init.dr = decVar(9);

init.r = decVar(10);

init.tstb = (P.tst + init.tswf) - init.tswb;

P.time = init.tswf + P.tst;

sim = simulateFull(init,P);

cost = 0;

dx_avg = sum(sim.dx)/length(sim.dx);

for i = 1:length(sim.t)
    % front leg cpg cost
    % manipulated variable tracking from matlab optimisation problem
    % tutorial
    % osc cost gets 2 local minimum to floow shape
    cost = cost + 10^0*(sim.dy_oscf(i) - calculateIdealOscDY(sim.x_oscf(i),sim.y_oscf(i),P.tst,init.tswf,P.c(1,2),sim.y_oscb(i)))^2;
    % include move suppression
    if (i ~= 1)
        cost = cost + 10^0*(sim.y_oscf(i)-sim.y_oscf(i-1))^2;
    end

    % back leg speed cost
    cost = cost + 10^0*(sim.dy_oscb(i) - calculateIdealOscDY(sim.x_oscb(i),sim.y_oscb(i),init.tstb,init.tswb,P.c(2,1),sim.y_oscf(i)))^2;
    % include move suppression
    if (i ~= 1)
        cost = cost + 10^0*(sim.y_oscb(i)-sim.y_oscb(i-1))^2;
    end

    % speed cost
    % scale = 1.0942e5/23.3878;

    % put cost on stability
    % cost = cost + scale*(sim.dx(i)-dx_avg)^2;
end

tol = P.constraintTol;

% include ending conditions
cost = cost + max(10^10*(abs(sim.y(1) - sim.y(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.dx(1)-sim.dx(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.r(1) - sim.r(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.dr(1) - sim.dr(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.dy(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.x_oscf(1) - sim.x_oscf(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.y_oscf(1) - sim.y_oscf(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.x_oscb(1) - sim.x_oscb(end)) - tol),0);
cost = cost + max(10^10*(abs(sim.y_oscb(1) - sim.y_oscb(end)) - tol),0);

end