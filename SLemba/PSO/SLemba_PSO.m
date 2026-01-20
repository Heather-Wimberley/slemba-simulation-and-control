%% Paricle Swarm Optimisation with Kemba
% https://www.youtube.com/watch?v=xPkRL_Gt6PI

clc;
clear;
close all;

%% Create parallel pool
% comment next two lines to run in serial - no other changes required
delete(gcp('nocreate'));
parpool("local",18);

%% Create file for results
% fileID = fopen('results_tst_tsw_kx.txt','a');
tst = linspace(0.065,0.105,5);
kx = linspace(0.05,0.4,20);
% tst = 0.08; kx = 0.08;
count = 1;
start = 98;

a = -0.005; b = 0.005; % interval of randomizer
% a = 0; b = 0;

for i = tst
    for j = kx
        if (count >= start)

        %% Problem Definition
        simParams.nGrid = 1000;
        simParams.tst = i + a + (b-a)*rand(1);
        simParams.kx = j + a + (b-a)*rand(1);
        simParams.constraintTol = 1e-1;
        simParams.front = false;

        problem.CostFunction = @(x) objective_single(x,simParams);     % Cost Function x is val, y is sim var
        problem.nVar = 5;                                       % Number of unknown/decision variable [x_osc, y_osc, y, tsw, dx]
        problem.VarMin = [-0.4,0.9,0.35,simParams.tst*1,simParams.kx*2];  % Lower Bound of Decision variables
        problem.VarMax = [0.4,1.3,0.8,simParams.tst*10,simParams.kx*15];               % Upper Bound of Decision variables
        
        % problem.VarMin = [0.4344,simParams.tst*2,0.1];  % Lower Bound of Decision variables
        % problem.VarMax = [0.7,simParams.tst*8,4];               % Upper Bound of Decision variables
        % problem.VarMin = simParams.tst*4;  % Lower Bound of Decision variables
        % problem.VarMax = simParams.tst*6;
        
        %% Parameters of PSO
        
        params.MaxIt = 50;        % Maximum Number of Iterations
        params.nPop = 18*4;          % Population Size (Swarm Size)
        params.w = 1;              % Inertia Coefficient
        params.wdamp = 0.99;       % Damping Ratio of Inertia Coefficient
        params.c1 = 2;             % Personal Acceleration Coefficient
        params.c2 = 2;             % Social Acceleration Coefficient
        params.ShowIterInfo = true; % Flag to show iteration info
        
        % Clerc and Kennedy, 2002 https://ieeexplore.ieee.org/document/985692
        % Constriction Coefficients
        
        kappa = 1;
        phi1 = 2.05;
        phi2 = 2.05;
        
        % kappa = 1;
        % phi1 = 1.8;
        % phi2 = 1.8;
        phi = phi1 + phi2;
        chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));
        % chi = kappa;
        
        params.w = chi;
        params.wdamp = 1;
        params.c1 = chi*phi1;
        params.c2 = chi*phi2;
        
        %% Calling PSO
        tic
        out = PSO(problem, params);
        toc
        filename = "PSO_runs/run" + count + ".mat";
        save(filename,"out","simParams","params");
        count = count + 1;
        BestCosts = out.BestCosts;
        BestSol = out.BestSol;
        
%         %% Results
% 
%         fprintf('%d %d %d\n',i,j,BestSol.Position);
        else
            count = count + 1;
        end
    end
end

%% Extract working solutions
delete(gcp('nocreate'));
parpool("local",8);

max = length(tst)*length(kx);

empty_allCosts.cost = [];
empty_allCosts.tst = [];
empty_allCosts.tsw = [];
empty_allCosts.kx = [];

all_costs = repmat(empty_allCosts,max,1);

parfor i = 1:max
    filename = "PSO_runs/run" + i + ".mat";

    out = load(filename);
    BestSol = out.out.BestSol; simParams = out.simParams;

    [cost,sols] = objective(BestSol.Position,simParams);
    figure
    plot(sols.t,sols.x);
    hold on
    plot(sols.t,sols.y);
    plot(sols.t,sols.th);
    plot(sols.t,sols.l);
    legend('x','y','th','l');
    titleName = i +" "+ cost;
    title(titleName);
    xlabel('time (s)');
    hold off

    all_costs(i).cost = cost;
    all_costs(i).tst = simParams.tst;
    all_costs(i).tsw = BestSol.Position(4);
    all_costs(i).kx = simParams.kx;
end

%% 
% determine values with cost within tolerance
tol = 4e5;
cost = zeros(1,max);

fileID = fopen("PSO/working_tst_tsw_kx.txt",'a');

for i = 1:max
    cost(i) = all_costs(i).cost;
    if (cost(i)<tol)
        data = all_costs(i).tst + " " + all_costs(i).tsw + " " + all_costs(i).kx + " run" + i + "\n";
        fprintf(fileID,data);
    end
end

fclose(fileID);

plot(cost);