%% Paricle Swarm Optimisation with Kemba
% https://www.youtube.com/watch?v=xPkRL_Gt6PI

clc;
clear;
close all;

delete(gcp('nocreate'));
parpool("local",18);

%% Create file for results
% fileID = fopen('results_tst_tsw_kx.txt','a');
% tst = linspace(0.05,0.12,4);
% kx = linspace(0.1,0.2,4);
% 
% for i = tst
%     for j = kx

        %% Problem Definition
        simParams.nGrid = 1000;
        simParams.tstf = 0.08;
        simParams.tstb = 0.0793;
        simParams.kx = 0.05;
        simParams.constraintTol = 1e-1;

        problem.CostFunction = @(x) objective_c(x,simParams);     % Cost Function x is val, y is sim var
        problem.nVar = 9;  % Number of unknown/decision variable [c,y,r,dx,dr,x_oscf,y_oscf,x_oscb,y_oscb]
        problem.VarMin = [-pi,0.45,-pi/6,0.1,-3,-0.6,0.5,-1.2,-1.2];  % Lower Bound of Decision variables
        problem.VarMax = [pi,0.7,pi/6,simParams.kx*20,0,0.6,1.2,1.2,1.2];               % Upper Bound of Decision variables
        
        %% Parameters of PSO
        
        params.MaxIt = 30;        % Maximum Number of Iterations
        params.nPop = 18*2;          % Population Size (Swarm Size)
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
        save("sol.mat","out","simParams","params");
        BestCosts = out.BestCosts;
        BestSol = out.BestSol;
        
%         %% Results
% 
%         fprintf('%d %d %d\n',i,j,BestSol.Position);
%     end
% end

% fclose(fileID);
figure;
plot(BestCosts, 'LineWidth', 2);
% semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

%% PSO using MATLAB function

% [x,fval,exitflag,output,points] = particleswarm(problem.CostFunction,problem.nVar,problem.VarMin,problem.VarMax);
% 
% disp(out)