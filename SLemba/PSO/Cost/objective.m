function [cost,sim] = objective(decVar,P)

init.x_osc = decVar(1);
init.y_osc = decVar(2);
init.y = decVar(3);
init.tsw = decVar(4);
init.dx = decVar(5);

P.time = 1;

% init.x_osc = 0.02;
% init.y_osc = 1.02;
% init.y = decVar(1);
% init.tsw = decVar(2);
% init.dx = decVar(3);

% init.x_osc = 0.02;
% init.y_osc = 1.02;
% init.y = 0.6;
% init.tsw = decVar;
% init.dx = 1;

sim = simulateMonoped(init,P);

cost = 0;

dx_avg = sum(sim.dx)/length(sim.dx);

for i = 1:length(sim.t)
    % manipulated variable tracking from matlab optimisation problem
    % tutorial
    % osc cost gets 2 local minimum to floow shape
    cost = cost + 10^0*(sim.dy_osc(i) - calculateIdealOscDY(sim.x_osc(i),sim.y_osc(i),P.tst,init.tsw))^2;
    % include move suppression
    if (i ~= 1)
        cost = cost + 10^0*(sim.y_osc(i)-sim.y_osc(i-1))^2;
    end

    scale = 1.0942e5/23.3878;

    % put cost on stability
    cost = cost + scale*(sim.dx(i)-dx_avg)^2;
end

% include ending conditions
% cost = cost + (sim.y(1)-sim.y(end))^2;
% cost = cost + (sim.dx(1)-sim.dx(end))^2;
% cost = cost + sim.dy(end)^2;

end